# Ninja Legends Universal V1 Recovery Report

## Files

- Analysis scaffold: `Main.lua`
- Runtime-recovered notes/source: `Main.runtime-recovered.lua`
- Recovered server-side safeguard: `OwnGameCurrencySafeguard.server.lua`
- Recovered client reset button: `OwnGameResetMoneyButton.client.lua`
- Original protected source: `Original.obfuscated.lua`

## Status

Partial Voltils recovery. The outer packer, string table, base85 decoder, XOR stream, sparse table swaps, and resolver arithmetic were decoded, but the remaining body is still a control-flow VM. This entry is intentionally an analysis artifact rather than a working rehost.
