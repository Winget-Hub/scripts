# Arsenic Hub Free Recovery Report

## Files

- Dirty wrapper: `Scripts/Skids/Arsenic Hub Free/Dirty/Main.lua`
- Recovered source wrapper: `Scripts/Skids/Arsenic Hub Free/Clean/Main.lua`
- Fetched second-stage source: `Scripts/Skids/Arsenic Hub Free/Clean/Loadstring.lua`
- Analysis mirror: `Scripts/Unhiding/arsenic_hub_free_artifacts/fetched_loadstring.lua`

## Source Chain

The user-provided loader fetched:

```lua
https://api.jnkie.com/api/v1/luascripts/public/ae6d3e6163817a447ddd82c645b024589c3b7c8ec872d44a86c3789f9f604cdf/download
```

That endpoint redirected to:

```lua
https://cdn.jnkie.com/a53707746564fc4b83bf00b328e656e226bc637b9a142d1893dc13fba1e63a8f.lua
```

Fetched source size: 1,147,885 bytes, 298 lines.

SHA-256:

```text
a53707746564fc4b83bf00b328e656e226bc637b9a142d1893dc13fba1e63a8f
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

The local Luraph helper detected the protected tail as `luraph_v14_4_initv4` family, but full recovery needs a script key. The artifact-only run produced a best-effort output that corrupts literals, so it was kept under `Scripts/Unhiding/arsenic_hub_free_artifacts/` and was not used as clean source.

Relevant helper outputs:

- `luraph_detect.stdout.txt`
- `luraph_artifact.stdout.txt`
- `luraph_recovered.lua`
- `luraph_recovered.json`

## Verification

`luau-compile` passed for the fetched second-stage source.
