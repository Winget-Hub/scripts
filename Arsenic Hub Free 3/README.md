# Arsenic Hub Free 3 Recovery Report

## Files

- Dirty wrapper: `Scripts/Skids/Arsenic Hub Free 3/Dirty/Main.lua`
- Recovered source wrapper: `Scripts/Skids/Arsenic Hub Free 3/Clean/Main.lua`
- Fetched second-stage source: `Scripts/Skids/Arsenic Hub Free 3/Clean/Loadstring.lua`
- Analysis mirror: `Scripts/Unhiding/arsenic_hub_free_3_artifacts/fetched_loadstring.lua`

## Source Chain

The user-provided loader fetched:

```lua
https://api.jnkie.com/api/v1/luascripts/public/d1c9e01bb9267910db3aacb917d174095e758ec050424403fa28b49012ebfe4a/download
```

That endpoint redirected to:

```lua
https://cdn.jnkie.com/52a79ffe936b6f7b3862b82d0bea9505ba037683b9dede42ed6a4203c1b66175.lua
```

Fetched source size: 1,153,203 bytes, 298 lines.

SHA-256:

```text
52a79ffe936b6f7b3862b82d0bea9505ba037683b9dede42ed6a4203c1b66175
```

## Recovered Behavior

- The top-level dirty script is only a remote `loadstring(game:HttpGet(...))()` wrapper.
- The fetched source starts as a Havoc UI/Junkie key-system template.
- It sets `getgenv().SCRIPT_KEY = "KEYLESS"`.
- It identifies the service/provider as `Arsenic Hub Free` with identifier `1069166`.
- It fetches and executes `https://cdn.jnkie.com/havoc.lua` for the key-system UI.
- It fetches and executes `https://jnkie.com/sdk/library.lua` for key checking.
- It may persist a verified key through executor file APIs if configured: `isfile`, `readfile`, and `writefile`.
- The final payload body is marked `Luraph Obfuscator v14.7`.

## External URLs Found

- `https://mrhavoc-jnkie.github.io/MrHavoc-KeySystem/`
- `https://cdn.jnkie.com/havoc.lua`
- `https://jnkie.com/sdk/library.lua`
- `https://lura.ph/`

## Luraph Status

The local Luraph helper detected the protected tail as `luraph_v14_4_initv4`
family. The artifact-only run decrypted 261 constants and produced a
best-effort output, but full recovery still needs the script key. The
best-effort output was kept under `Scripts/Unhiding/arsenic_hub_free_3_artifacts/`
instead of being used as clean source.

Relevant helper outputs:

- `luraph_detect.stdout.txt`
- `luraph_artifact.stdout.txt`
- `luraph_recovered.lua`
- `luraph_recovered.json`

## Verification

`luau-compile` passed for:

- `Scripts/Skids/Arsenic Hub Free 3/Dirty/Main.lua`
- `Scripts/Skids/Arsenic Hub Free 3/Clean/Main.lua`
- `Scripts/Skids/Arsenic Hub Free 3/Clean/Loadstring.lua`
