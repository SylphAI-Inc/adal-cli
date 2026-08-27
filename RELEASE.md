# Release & deploy runbook — AdaL CLI

How to publish a signed release and keep the installers honest. This document
is the companion to SECURITY.md; read that first.

## Layout (observed from the live CDN)

```
s3://<bucket>/cli/
├── latest                      # plain text: latest stable version, e.g. "1.5.7"
├── beta                        # plain text: latest beta version
├── manifests/
│   └── manifest-<version>.json # one per version
└── <version>/
    ├── adal-<version>-darwin-arm64.tar.gz
    ├── adal-<version>-darwin-arm64.tar.gz.minisig     ← NEW
    ├── adal-<version>-darwin-x64.tar.gz
    ├── adal-<version>-darwin-x64.tar.gz.minisig       ← NEW
    ├── adal-<version>-linux-x64.tar.gz
    ├── adal-<version>-linux-x64.tar.gz.minisig        ← NEW
    ├── adal-<version>-linux-arm64.tar.gz
    ├── adal-<version>-linux-arm64.tar.gz.minisig      ← NEW
    └── adal-<version>-win32-x64.zip
    └── adal-<version>-win32-x64.zip.minisig           ← NEW
```

## Manifest schema (enforced by install.sh)

```json
{
  "version": "1.5.7",
  "channel": "latest",
  "platforms": {
    "darwin-arm64": {
      "filename": "adal-1.5.7-darwin-arm64.tar.gz",
      "checksum": "<sha256 hex, 64 chars>",
      "size": 74559913
    }
  }
}
```

The installer **hard-fails** if `version` is missing, if the platform block is
missing, if `checksum` is not 64 hex chars, if `size` is not a positive
integer, or if `filename` does not match the URL being downloaded. Keep this
schema stable — a rename silently disables verification for old installers.

Platform keys currently accepted: `darwin-arm64`, `darwin-x64`, `linux-x64`,
`linux-x64-musl`, `linux-arm64`, `win32-x64`. `linux-arm64-musl` is detected
but **not published yet** — the installer prints a specific, actionable error
for it instead of a generic one.

## Release procedure (add to the existing release pipeline)

```bash
# 1. Build tarballs for every platform (existing pipeline step), then:

# 2. Generate the manifest (existing step), then:

# 3. Sign every artifact with the release key
./scripts/sign-release.sh \
  --version 1.5.7 \
  --key     $ADAL_SIGNING_KEY \        # CI secret, NOT committed
  --files   "dist/adal-1.5.7-*.tar.gz" "dist/adal-1.5.7-*.zip"

# 4. Sanity-check the signatures
./scripts/sign-release.sh --check --files "dist/adal-1.5.7-*"

# 5. Upload to S3 (existing step): each <tarball> AND its <tarball>.minisig
# 6. Update manifests/, latest, beta (existing steps)
# 7. Deploy the hardened install.sh to adal.sylph.ai/install.sh
```

If the pipeline generates manifests itself, keep the schema above. If it
already uploads `.minisig` files under a different convention, adjust
`verify_signature` in install.sh accordingly.

## First release with signing — key custody

A keypair was generated for this change:

- Private key: `adal-release.minisign` (this value is held out-of-band; it is
  NOT in this repository).
- Public key: already embedded in `install.sh` as `SIGNING_PUBLIC_KEY`.

Actions:

1. Copy the private key into the release pipeline's secret store (GitHub
   Actions secret, AWS Secrets Manager, etc.).
2. Confirm the pipeline can sign (step 3 above) before publishing.
3. Delete the private key from the machine that generated it.
4. If the pipeline must sign without human interaction, store the key
   **encrypted** in the secrets manager and decrypt in the workflow. Do not
   commit it, do not embed it in images.

## CI matrix for linux-arm64-musl (close the gap)

Add the missing build to the release matrix, then the existing
`linux-x64-musl` logic in `detect_platform()` handles it automatically:

```yaml
# In the release workflow's build matrix:
matrix:
  include:
    - os: ubuntu-latest
      target: linux-arm64-musl
      command: |
        cargo build --release --target aarch64-unknown-linux-musl
        # then bundle with the musl bun runtime (same as linux-x64-musl)
```

Verify the `apk add libstdc++ libgcc` runtime-deps path in
`ensure_musl_runtime_deps()` against the produced artifact before shipping.

## Tracking endpoint — server-side reference (HMAC + timestamp)

Client behavior (`track_install` in install.sh, opt-in only):

- Default OFF. Enabled by `--track` or `ADAL_TRACK=1`; `--no-track` /
  `ADAL_NO_TRACK=1` always win.
- `POST` with `content-type: application/json`:
  `{"platform":"cli","channel":"stable|beta","event_type":"install|upgrade","version":"1.5.7","ts":<unix>,"nonce":"<32 hex>"}`
- Headers: `X-Adal-Signature: <hex hmac-sha256(body, secret)>`,
  `X-Adal-Ts: <unix>`, `X-Adal-Nonce: <32 hex>`.

Minimal server-side validation (Python/FastAPI flavor):

```python
import hashlib, hmac, json, time

SECRET = b"adal-cli-install-track-v1"  # keep in sync with install.sh
MAX_AGE = 300  # seconds

async def track(request):
    body = await request.body()
    sig = request.headers.get("X-Adal-Signature", "")
    ts = int(request.headers.get("X-Adal-Ts", "0"))
    if hmac.compare_digest(sig, hmac.new(SECRET, body, hashlib.sha256).hexdigest()) \
       and 0 <= time.time() - ts <= MAX_AGE \
       and request.headers.get("X-Adal-Nonce"):
        record(json.loads(body))
    # rate-limit by IP + User-Agent; treat signature as a filter, not identity
    return 200
```

Reminder from SECURITY.md: the secret ships in a public installer, so the HMAC
is an anti-naive-abuse filter, not authentication. Rate limiting is the real
protection.

## Installing the hardened installer

```bash
# Directly:
curl -fsSL https://adal.sylph.ai/install.sh | bash

# Specific version / channel:
curl -fsSL https://adal.sylph.ai/install.sh | bash -s -- --version 1.5.7
curl -fsSL https://adal.sylph.ai/install.sh | bash -s -- --version beta

# Dockerfiles that install AdaL should pin + enforce signatures:
RUN curl -fsSL https://adal.sylph.ai/install.sh | \
    ADAL_REQUIRE_SIGNATURE=1 bash
```

## Testing

```bash
brew install shellcheck minisign   # or: apt install shellcheck minisign
bash -n install.sh
shellcheck --shell=bash install.sh scripts/*.sh tests/*.sh
bash tests/run.sh
```

The E2E suite builds a fake signed release served over `file://` and verifies
the full pipeline: happy path, tampered tarball, forged manifest, missing
signature (transition + `ADAL_REQUIRE_SIGNATURE=1`), schema violations, channel
resolution, and the HMAC tracking payload (captured by a local HTTP server).
