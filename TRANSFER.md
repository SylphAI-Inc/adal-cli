# AdaL Release Signing Key — Transfer Instructions

**This directory must be emptied once the key is safely stored in the release
pipeline. Do not leave the private key on a laptop.**

## Files

| File | Content | Destination |
|---|---|---|
| `adal-release.minisign` | **PRIVATE** minisign secret key | Release pipeline secret store (GitHub Actions secret / AWS Secrets Manager / KMS). NEVER commit, embed, or email. |
| `adal-release.pub` | Public key (safe to share) | Already embedded in `install.sh` as `SIGNING_PUBLIC_KEY`; keep a copy with the private key. |

## Verification checksum

SHA-256 of the private key (verify the copy you store against this):

```
435b2748198bbf2f891e69c019c60c06760965cf7edb5e44324c605a634204d9
```

On the target machine:

```bash
shasum -a 256 adal-release.minisign   # or: sha256sum adal-release.minisign
```

## ⚠️ Key rotation note (2026-08-05)

The previous signing keypair was **rotated** because the private key blob was
accidentally pasted into a terminal and a chat transcript. Do not use the old
key (`RWTpQA9...`). The public key embedded in `install.sh` has been replaced
with the one in this directory (`adal-release.pub`).

## Store (pick one, in order of preference)

1. **KMS / managed signing service** — if the pipeline supports signing with a
   cloud KMS key, use it and delete this file entirely.
2. **AWS Secrets Manager / GitHub Actions secret** — store the file contents
   (the minisign secret key is a short text blob; store it as-is, preserving
   the trailing newline), then decrypt/restore it inside the release workflow
   only during the signing step.

## Restore inside CI (GitHub Actions example)

```yaml
- name: Restore signing key
  env:
    ADAL_SIGNING_KEY: ${{ secrets.ADAL_SIGNING_KEY }}
  run: |
    printf '%s' "$ADAL_SIGNING_KEY" > adal-release.minisign
    chmod 600 adal-release.minisign
- name: Sign artifacts
  run: ./scripts/sign-release.sh --version ${{ github.ref_name }} \
       --key adal-release.minisign --files "dist/adal-*.tar.gz" "dist/adal-*.zip"
```

## After storage is confirmed

Delete this directory:

```bash
rm -rf /Users/Brendan/.adal-release-key/
```

If the key is lost before it is stored, releases cannot be signed — rotate by
regenerating a new keypair and shipping the new public key in a new install.sh
(must be done together; see SECURITY.md "Key management").
