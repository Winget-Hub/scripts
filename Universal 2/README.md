# Universal 2 Recovery Report

## Files

- Dirty wrapper: `Scripts/Skids/Universal 2/Dirty/Main.lua`
- Recovered source wrapper: `Scripts/Skids/Universal 2/Clean/Main.lua`
- Fetched second-stage source: `Scripts/Skids/Universal 2/Clean/Loadstring.lua`
- Readable WRD layer reconstruction: `Scripts/Skids/Universal 2/Clean/WrdLayer.lua`
- Analysis mirror: `Scripts/Unhiding/universal2_artifacts/fetched_loadstring.lua`

## Source Chain

The user-provided loader fetched:

```lua
https://api.jnkie.com/api/v1/luascripts/public/8e4ea2929a44f8c8caa9590791acd914d892c445c7f8ae2f144f0325a3a699f6/download
```

That endpoint redirected to:

```lua
https://cdn.jnkie.com/f582e2e54ce6d6fa356dbb1c30bc7f592f140fdcb73e6f1680a0ee276eec5681.lua
```

Fetched source size: 2,122,922 bytes, 4 non-empty logical lines.

SHA-256:

```text
f582e2e54ce6d6fa356dbb1c30bc7f592f140fdcb73e6f1680a0ee276eec5681
```

## Recovered Behavior

- The top-level dirty script is only a remote `loadstring(game:HttpGet(...))()` wrapper.
- The fetched source starts with a `wearedevs.net/obfuscator` VM layer.
- The WRD layer was split into `wrd_line1_return.lua` for sandbox analysis.
- A sandbox run with Roblox/executor stubs recovered network fetches for:
  - `https://cdn.jnkie.com/havoc.lua`
  - `https://jnkie.com/sdk/library.lua`
- Decoded WRD constants include `getgenv`, `Color3`, `writefile`, `readfile`, `isfile`, `loadstring`, `HttpGet`, `Init`, and key-system style generated global names.
- The fetched source then contains a separate `Luraph Obfuscator v14.7` payload tail.

## External URLs Found

- `https://wearedevs.net/obfuscator`
- `https://cdn.jnkie.com/havoc.lua`
- `https://jnkie.com/sdk/library.lua`
- `https://lura.ph/`

## Luraph Status

The local Luraph helper detected the protected tail as `luraph_v14_4_initv4`
family. The artifact-only run decrypted 449 constants and produced a
best-effort output, but full recovery still needs the script key. The
best-effort output was kept under `Scripts/Unhiding/universal2_artifacts/`
instead of being used as clean source.

Relevant helper outputs:

- `luraph_detect.stdout.txt`
- `luraph_artifact.stdout.txt`
- `luraph_recovered.lua`
- `luraph_recovered.json`
- `wrd_probe_roblox_stub/runtime_events.json`
- `wrd_probe_roblox_stub/decoded_constants.json`

## Verification

`luau-compile` passed for:

- `Scripts/Skids/Universal 2/Dirty/Main.lua`
- `Scripts/Skids/Universal 2/Clean/Main.lua`
- `Scripts/Skids/Universal 2/Clean/WrdLayer.lua`
- `Scripts/Skids/Universal 2/Clean/Loadstring.lua`
