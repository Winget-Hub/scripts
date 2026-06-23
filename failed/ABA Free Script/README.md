# ABA Free Script Failed Recovery Report

## Files

- Original loader: `OriginalLoader.lua`
- Protected payload: `Payload.obfuscated.lua`
- Luau syntax-check status: `attempts/compile.status.txt`
- Static protection detection: `attempts/luraph_detect.json`
- Keyed Luraph artifact run: `attempts/luraph_artifact.stdout.txt`
- Keyed Luraph lifter run: `attempts/luraph_lifter.stdout.txt`
- Lifter warnings: `attempts/luraph_lifter.stderr.txt`
- Placeholder decoded payload: `attempts/payload_decode.placeholder.lua`
- Placeholder recovered source: `attempts/luraph_recovered.placeholder.lua`

## Source Chain

The screenshot loader sets this executor global:

```lua
getgenv().SCRIPT_KEY = "06e22a38-6431-4d3d-aae5-a4e452ce4988"
```

It then fetches this Junkie API endpoint:

```text
https://api.jnkie.com/api/v1/luascripts/public/559eb289e96ef1c475a3f1046e3409904dca4abf4b01534d03a3ba652132fa92/download
```

Fetched payload size: 1,656,065 bytes.

SHA-256:

```text
c9cdc2f654ab617450a5e76b49c2b3f192e82a52a6f22956f03ea7562d193977
```

Original loader SHA-256:

```text
e0cdd1dcd3ca86e3e57aba6bb04d9d52e9f7fb5f2301c229e66d063c7bb74fc3
```

## Hiding Method

- The public script is a small `loadstring(game:HttpGet(...))()` wrapper.
- The wrapper also supplies a `SCRIPT_KEY`, so the payload expects key-aware decoding.
- The fetched file is marked:

```text
This file was protected using Luraph Obfuscator v14.7
```

- Static detection found compression, dynamic generation, VM bootstrap behavior, and XOR-style hiding.

## Recovery Attempt

The loader and payload were fetched as data and saved without running them in Roblox. Luau syntax checking completed successfully:

```text
compile_exit=0
```

The Luraph helper was run with the provided script key. It detected an initv4-style Luraph payload:

```text
Detected version: luraph_v14_4_initv4
Script key: 06e22a... (len=36)
Decoded 3684 blobs, total 176416 bytes
Final output length: 6 chars
```

The recovered Lua body was only:

```lua
noop()
```

A second pass with the VM lifter, debug bootstrap logging, and sandboxed Lua fallback produced the same placeholder result. The lifter warnings repeatedly report that the decoded chunks do not resemble VM bytecode:

```text
Chunk 1 does not resemble VM bytecode (35 bytes). Skipping VM lifter; rerun with --force to override.
```

The placeholder intermediate output is archived so future tooling can compare against the same attempt without re-fetching the remote payload.

## Status

This entry is stored under `failed/` because the original loader and protected Luraph payload were preserved, but the payload was not recovered into working original source with the current tools, even when using the provided `SCRIPT_KEY`.
