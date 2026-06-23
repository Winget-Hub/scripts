# Luarmor Marbeg

## Files

| Path | Description |
|------|-------------|
| `Clean/Loadstring.lua` | Canonical Luarmor loader with `script_key = "KEY"` placeholder. |
| `Dirty/Loader.lua` | Raw API loader response from `https://api.luarmor.net/files/v4/loaders/06010a4d1c6229affd71713d6a9adc6c.lua`. |
| `Dirty/v4_init_marbeg.lua` | Secondary Luarmor V4 bootstrap fetched from `https://cdn.luarmor.net/v4_init_marbeg.lua`. |
| `Clean/Deobfuscation/roblox_emulator.py` | Safe Python emulator for the saved Roblox/executor loader flow. |
| `Clean/Deobfuscation/decode_superflow.py` | Static extractor/decoder attempts for the CDN `superflow_bytecode` payload. |
| `Clean/Deobfuscation/initv4_combined.lua` | Analysis-only file combining `_bsdata0` from `Dirty/Loader.lua` with the CDN init payload. |
| `Clean/Deobfuscation/sandbox_KEY/` | Sandbox attempt using placeholder key `KEY`; failed to recover real output. |
| `Clean/Deobfuscation/emulator_run/` | Latest emulator trace with HttpGet, cache, writefile, listfiles, and loadstring captures. |
| `Clean/Deobfuscation/superflow_decode/` | Best-effort static decode artifacts for `loadstring_002_cdn_init_payload.lua`. |

## Fetch Status

| URL | Status | Content type | Bytes | SHA-256 |
|-----|--------|--------------|-------|--------|
| `https://api.luarmor.net/files/v4/loaders/06010a4d1c6229affd71713d6a9adc6c.lua` | `200` | `text/plain` | `1429` | `dabe3bc1a07f982e94f57ab5874930449c0f2b835ec2be033d1203b47ac05b5b` |
| `https://cdn.luarmor.net/v4_init_marbeg.lua` | `200` | `application/octet-stream` | `602650` | `1bf08aaa6f3f95ceb97dd0c81d066b03bfafbacd2a75bb64c118503eb1a2dcdf` |

## Recovery Notes

The API URL returns a Luarmor V4 bootstrap, not plain Lua source. The loader defines `_bsdata0`, checks a local `static_content_130525/init-74c74f95fd0-marbeg.lua` cache, and fetches `v4_init_marbeg.lua` when the cache is missing.

The CDN init payload was fetched successfully, but it is still a Luarmor bootstrap with bytecode data (`superflow_bytecode`). Static URL scanning only exposed `https://luarmor.net/`; the final script source was not recovered without running the Luarmor VM/loader in a Roblox executor environment.

`script_key = "KEY"` was added to `Clean/Loadstring.lua` because Luarmor requires a key global before the loader runs. The placeholder value does not change the first HTTP response; it is consumed later by the Luarmor bootstrap during VM/key validation.

A local sandbox attempt was run against `Clean/Deobfuscation/initv4_combined.lua` with key `KEY`. It detected compression, dynamic generation, VM bootstrap, and XOR protections, but did not recover decoded Lua. The sandbox generated fixture output only, so `Clean/Deobfuscation/sandbox_KEY/deobfuscated.full.lua` is not the real script.

## Emulator

Run the safe emulator with:

```sh
python3 "Clean/Deobfuscation/roblox_emulator.py" --fresh
```

The emulator does not execute captured Lua. It maps the API and CDN URLs to the saved local files, stubs the cache filesystem calls, and writes traces to `Clean/Deobfuscation/emulator_run/`.

The current trace captured:

- `chunks/loadstring_001_initial_loader.lua` — API loader response.
- `chunks/loadstring_002_cdn_init_payload.lua` — Luarmor CDN init payload.
- `workspace/static_content_130525/init-74c74f95fd0-marbeg.lua` — emulated cache write.
- `events.jsonl` and `summary.json` — structured replay log.

## Superflow Decode Attempt

Run the static extractor with:

```sh
python3 "Clean/Deobfuscation/decode_superflow.py" --fresh
python3 "../../Unhiding/format_luraph.py" "Clean/Deobfuscation/emulator_run/chunks/loadstring_002_cdn_init_payload.lua" -o "Clean/Deobfuscation/superflow_decode/loadstring_002_cdn_init_payload.formatted.lua"
```

Recovered artifacts:

- `superflow_decode/blobs/superflow_001.bin` through `superflow_003.bin` — reconstructed byte strings from the `superflow_bytecode` table.
- `superflow_decode/superflow_combined.bin` — combined blob (`6584` bytes, entropy about `7.97`).
- `superflow_decode/transforms/` — XOR/index/PRGA probes using placeholder key `KEY`.
- `superflow_decode/tail_only.lua` — the 579 KB obfuscated Lua VM source after the `superflow_bytecode` table.
- `superflow_decode/loadstring_002_cdn_init_payload.formatted.lua` — token-preserving readable layout of the CDN init payload.
- `superflow_decode/vm_function_index.txt` and `vm_static_summary.json` — static VM index (`135` function assignments, `7741` decoded string literals).

No transform or common decompressor produced plain Lua. The recovered literals are still packed/encoded VM data, not game source.
