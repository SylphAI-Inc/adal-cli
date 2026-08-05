# Security — AdaL Installer

This document describes the threat model of `install.sh`, what the hardening
protects against, what remains intentionally unguarded, and what the SylphAI
release pipeline must do to close the remaining gaps.

## Threat model

The installer runs as the invoking user (root in Dockerfiles). The relevant
attackers are:

| Attacker | Capability | Defended by |
|---|---|---|
| CDN/S3 bucket compromise | Rewrite any artifact + manifest served from `adal.sylph.ai` | **minisign Ed25519 signature** over each tarball; public key embedded in the installer |
| Compromised manifest only | Modify checksums/sizes in `manifest-<ver>.json` | Signature: checksum is not a trust root, only a corruption check |
| Content-delivery tampering | MITM or modify bytes in transit (non-TLS, or TLS breakage) | Signature covers the artifact bytes; checksum additionally verifies integrity |
| Malicious version/filename injection | Craft `--version` or a tarball name that smuggles shell into URLs/paths | Strict semver regex + strict tarball filename regex |
| Malformed/manipulated manifest | Omit or falsify checksum/size to weaken verification | Manifest schema validation; **hard fail** when a field is missing/invalid |

## What the installer verifies, in order

1. **Version string** — strict semver (`X.Y.Z` or `X.Y.Z-pre.n`) before it is
   interpolated into any URL.
2. **Manifest schema** — `version`, `platforms.<platform>.filename`,
   `.checksum` (64 hex), `.size` (positive int) must all be present and valid;
   otherwise the install refuses to proceed.
3. **Downloaded size** — cheap first-line check against the manifest.
4. **SHA-256 checksum** — against the manifest value (integrity check).
5. **Ed25519 signature** — `minisign -Vm <tarball> -P <embedded pubkey>` using
   the detached `<tarball>.minisig`. This is the tamper-protection layer.

A `curl | bash` install can never be fully protected by the script itself —
the user must review what they pipe to `bash` — but the combination above
means an attacker who controls the CDN still cannot install signed payloads
they did not author.

## Transition mode (signature availability)

The release pipeline does not yet publish `.minisig` files. To avoid breaking
installs today, the installer runs in **transition mode**:

- A `.minisig` file **is** published → it is *always* verified; a bad signature
  is a hard failure (this was tested with a forged-manifest attack).
- A `.minisig` file is **missing** → a loud warning is printed and install
  continues with SHA-256 only.
- `ADAL_REQUIRE_SIGNATURE=1` → missing signature or missing `minisign` binary
  becomes a hard failure.

**Rollout plan:** publish `.minisig` files for all platforms for ≥ 2 release
cycles (so existing cached/old installers keep working), then flip the default
in `install.sh` so a missing signature is a hard error, and finally advertise
`ADAL_REQUIRE_SIGNATURE=1` in Dockerfiles/CI.

## Key management

- **Private key:** `adal-release.minisign` — must live ONLY in the release
  pipeline (GitHub Actions secrets, a secrets manager, or a KMS-backed
  signing service). Never commit it, never embed it, never send it to a
  non-release machine.
- **Public key:** embedded in `install.sh` as `SIGNING_PUBLIC_KEY`. Anyone can
  see it — that is by design.
- **Rotation:** generate a new keypair, embed the new public key in a new
  `install.sh`, publish signatures with the new key for a full release cycle
  (old installers still trust the old key), then move the old private key to
  cold storage/delete it.
- A keypair has already been generated and the public key embedded. **The
  private key must be moved to the release pipeline and deleted from the
  machine that generated it** (see RELEASE.md, "First release").

## Known limitations (accepted)

1. **HMAC tracking secret is extractable.** The tracking payload is signed
   with a secret embedded in a public script. Anyone can read it, so the
   signature is *obfuscation*, not authentication. The tracking endpoint must
   not treat `X-Adal-Signature` as proof of identity; it should rate-limit by
   IP/UA and validate the timestamp window. Reference server code is in
   RELEASE.md.
2. **No certificate pinning.** The connection to the release CDN uses standard
   TLS. Pinning is not implemented because CDN cert rotation would break
   installs; the signature layer is the tamper protection.
3. **Local tarball installs** (`--local-tarball`) are not signed/checksummed —
   by design, the file is already on the user's disk. The filename regex and
   entry-point verification still apply.
4. **The bootstrap is `curl | bash`.** The very first fetch of `install.sh`
   itself is not authenticated. Consider publishing the script's SHA-256 on
   the docs site as a secondary channel.

## Org-side actions still required

1. Wire the hardened `install.sh` into the private release pipeline and
   deploy it to `adal.sylph.ai/install.sh`.
2. Publish `.minisig` files for every artifact (scripts/sign-release.sh).
3. Move the signing key into CI secrets; delete it from the generator machine.
4. Add the `linux-arm64-musl` build to the release matrix (or stop advertising
   it) — see RELEASE.md.
5. Add HMAC + timestamp + rate-limit verification to the tracking endpoint.
