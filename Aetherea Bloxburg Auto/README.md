# Aetherea Bloxburg Auto Recovery Report

## Files

- Original loader: `OriginalLoader.lua`
- Fetched protected source: `Main.lua`
- Recovered readable Rubis stage: `RubisPrompt.lua`

## Source Chain

The original loader fetched:

```lua
https://aetherea.lol/free-bloxburg-auto.luau
```

Fetched source size: 69,935 bytes.

SHA-256:

```text
d3b4fa9f6159c0479d0a67c729d3d88939c8e531c66732f84011e1c978046bae
```

The fetched source immediately loads this readable Rubis stage before entering a protected Luraph payload:

```lua
https://api.rubis.app/v2/scrap/eUPIQ40aubRhT0sy/raw
```

Rubis stage size: 3,073 bytes.

SHA-256:

```text
68663bb5362a9db63fd7e5dd02f86ca66cc678331a8d44fc279ac96ddfb84c8c
```

## Recovered Behavior

- The top-level script is only a remote `loadstring(game:HttpGet(...))()` wrapper.
- The fetched Aetherea source is marked `Luraph Obfuscator v14.6`.
- Luraph detection classified the protected tail as `luraph_v14_4_initv4`.
- The first visible action in the fetched source loads the Rubis raw script.
- The Rubis stage creates a Discord prompt GUI.
- The prompt has a Copy Invite button for `https://discord.gg/d6B27J2uYm`.
- The Copy Invite button calls `setclipboard(invite_link)`.
- If `request` is available, it also POSTs to local Discord RPC at `http://127.0.0.1:6463/rpc?v=1` with `INVITE_BROWSER`.

## Luraph Status

The bundled Luraph helper detected the protected tail and produced artifacts, but reported that a script key is required to decode the initv4 payload. The artifact-only run decrypted 16 constants and produced a best-effort output, but that output is not reliable clean source.

The real Bloxburg automation payload remains protected behind the Luraph tail. The readable recovered source in this folder is `RubisPrompt.lua`.

## Verification

`luau-compile` passed for `Main.lua`, `RubisPrompt.lua`, and `OriginalLoader.lua`.
