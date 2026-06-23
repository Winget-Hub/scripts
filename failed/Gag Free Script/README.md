# Gag Free Script Failed Recovery Report

## Files

- Original screenshot loader: `OriginalLoader.lua`
- Readable key-system wrapper: `GagFreeScript.lua`
- Pastebin feature note: `Features.pastebin.txt`
- Protected second stage: `SecondStage.obfuscated.lua`
- Wrapper Luau syntax-check status: `attempts/compile.status.txt`
- Second-stage Luau syntax-check status: `attempts/second_stage_compile.status.txt`
- Static protection detection: `attempts/luraph_detect.json`
- Keyed Luraph artifact run: `attempts/luraph_artifact.stdout.txt`
- Keyed Luraph lifter run: `attempts/luraph_lifter.stdout.txt`
- Lifter warnings: `attempts/luraph_lifter.stderr.txt`
- Placeholder decoded payload: `attempts/payload_decode.placeholder.lua`
- Placeholder recovered source: `attempts/luraph_recovered.placeholder.lua`

## Source Chain

The screenshot loader fetches this raw GitHub file:

```text
https://raw.githubusercontent.com/f2playelias-lab/cool/refs/heads/main/GagFreeScript
```

Fetched wrapper size: 40,631 bytes.

SHA-256:

```text
ecffde18a61fafa7a70ec87b4960949b1cd972af9498dfd220a130686e2dcaba
```

The screenshot also linked this Pastebin feature note:

```text
https://pastebin.com/Qp8fgLii
```

Raw Pastebin SHA-256:

```text
8b21d49f8a16f304f937b86b800520bba3c448c50af20b294e2a27704e9bb200
```

The wrapper is readable. It builds a key-system GUI and checks this hardcoded key:

```text
UvuHubHolyMoly
```

The Get Key and Discord buttons copy this invite:

```text
https://discord.gg/Jw4szxjcbJ
```

After successful key validation, the wrapper sets this executor global:

```lua
getgenv().SCRIPT_KEY = "no Key needed"
```

It then fetches this Junkie API endpoint:

```text
https://api.jnkie.com/api/v1/luascripts/public/d8e84227671c13dfe29100fa0a56104803f13aed819e15dd222694df15e821b4/download
```

Fetched second-stage size: 1,698,213 bytes.

Second-stage SHA-256:

```text
f7322539be9f023271929ef7fafc2255a5543502b49be0527c31ed013c86d5f2
```

Original screenshot loader SHA-256:

```text
8c274376a321c67580bd7a48fe795a3bcdc06248434b5572482db4db70bf334e
```

## Hiding Method

- The public script is a one-line raw GitHub loader.
- The first fetched file is readable, but gates the real payload behind a key-system UI.
- The real second stage is loaded only after the hardcoded key check passes.
- The fetched second stage is marked:

```text
This file was protected using Luraph Obfuscator v14.7
```

- Static detection found compression, dynamic generation, VM bootstrap behavior, and XOR-style hiding.

## Recovery Attempt

The loader, wrapper, Pastebin note, and Junkie payload were fetched as data and saved without running them in Roblox. Luau syntax checking completed successfully for both the readable wrapper and the protected second stage:

```text
compile_exit=0
```

The Luraph helper was run with the wrapper-provided script key value. It detected an initv4-style Luraph payload:

```text
Detected version: luraph_v14_4_initv4
Script key: no Key... (len=13)
Decoded 3832 blobs, total 183216 bytes
Final output length: 152 chars
```

The recovered Lua body was only placeholder output:

```lua
noop()
noop()
noop()
noop()
noop()
```

The VM lifter warnings repeatedly report that the decoded chunks do not resemble recoverable VM bytecode:

```text
Chunk 1 does not resemble VM bytecode (83 bytes). Skipping VM lifter; rerun with --force to override.
```

The placeholder intermediate output is archived so future tooling can compare against the same attempt without re-fetching the remote payload.

## Status

This entry is stored under `failed/` because the readable GitHub wrapper was recovered, but the Luraph v14.7 second-stage payload was not devirtualized into working original source with the current tools.
