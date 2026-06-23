# ABA Free Script No Key Failed Recovery Report

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
getgenv().SCRIPT_KEY = "no key needed"
```

It then fetches this Junkie API endpoint:

```text
https://api.jnkie.com/api/v1/luascripts/public/74e6268fbc8439cb76576a71627aaf71b8ac87b6b582120434632ea592c4e04c/download
```

Fetched payload size: 1,699,019 bytes.

SHA-256:

```text
3b14dbc6a7117d69e4409e550b61ace25d0bd5f6bd2e9aba9d4aadf277790da8
```

Original loader SHA-256:

```text
ef37a428e93facfbcc8f095a0d9a241ab13e6e7e11c02df10ad636246bf1209f
```

## Hiding Method

- The public script is a small `loadstring(game:HttpGet(...))()` wrapper.
- The loader sets `SCRIPT_KEY` to the literal text `no key needed`.
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

The Luraph helper was run with the loader-provided script key value. It detected an initv4-style Luraph payload:

```text
Detected version: luraph_v14_4_initv4
Script key: no key... (len=13)
Decoded 3722 blobs, total 175702 bytes
Final output length: 34 chars
```

The recovered Lua body was only repeated placeholders:

```lua
noop()
noop()
noop()
noop()
noop()
```

A second pass with the VM lifter, debug bootstrap logging, and sandboxed Lua fallback produced the same placeholder result. The lifter warnings repeatedly report that the decoded chunks do not resemble VM bytecode:

```text
Chunk 1 does not resemble VM bytecode (27 bytes). Skipping VM lifter; rerun with --force to override.
```

The placeholder intermediate output is archived so future tooling can compare against the same attempt without re-fetching the remote payload.

## Status

This entry is stored under `failed/` because the original loader and protected Luraph payload were preserved, but the payload was not recovered into working original source with the current tools.
