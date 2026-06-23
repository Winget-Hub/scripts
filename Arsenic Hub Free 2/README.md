# Arsenic Hub Free 2 Recovery Report

## Files

- Dirty wrapper: `Scripts/Skids/Arsenic Hub Free 2/Dirty/Main.lua`
- Recovered source wrapper: `Scripts/Skids/Arsenic Hub Free 2/Clean/Main.lua`
- Fetched second-stage source: `Scripts/Skids/Arsenic Hub Free 2/Clean/Loadstring.lua`
- Analysis mirror: `Scripts/Unhiding/arsenic_hub_free_2_artifacts/fetched_loadstring.lua`

## Source Chain

The user-provided loader fetched:

```lua
https://api.jnkie.com/api/v1/luascripts/public/d1a135ac03a36cad818c63a8b0671dc78fb0425bc825e276d43f63477eb4e505/download
```

That endpoint initially redirected to:

```lua
https://cdn.jnkie.com/37c2a7c6619fec9a7d8c09e95a17ad597ab352f13dedc2b542c4eedf8555867f.lua
```

Later checks of the public API endpoint returned 404. The direct CDN `GET`
still returned the second-stage source, while direct CDN `HEAD` also returned
404.

Fetched source size: 1,272,260 bytes, 298 lines.

SHA-256:

```text
37c2a7c6619fec9a7d8c09e95a17ad597ab352f13dedc2b542c4eedf8555867f
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
family, but full recovery needs a script key. The artifact-only run produced a
best-effort output and was kept under
`Scripts/Unhiding/arsenic_hub_free_2_artifacts/` instead of being used as clean
source.

Relevant helper outputs:

- `luraph_detect.stdout.txt`
- `luraph_artifact.stdout.txt`
- `luraph_recovered.lua`
- `luraph_recovered.json`

## Verification

`luau-compile` passed for:

- `Scripts/Skids/Arsenic Hub Free 2/Dirty/Main.lua`
- `Scripts/Skids/Arsenic Hub Free 2/Clean/Main.lua`
- `Scripts/Skids/Arsenic Hub Free 2/Clean/Loadstring.lua`
