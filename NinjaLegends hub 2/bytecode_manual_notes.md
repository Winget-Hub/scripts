# NinjaLegends hub 2 bytecode notes

Files produced:

- `bytecode.lua`: raw decoded VM bytecode returned as a Lua string.
- `bytecode_disasm.txt`: pseudo-disassembly of the parsed Luraph VM prototypes.
- `bytecode_semantic_disasm.txt`: semantic pseudo-disassembly with the permuted VM dispatch table corrected.
- `opcode_map.md`: corrected bytecode opcode to handler/mnemonic map.
- `Scripts/Unhiding/ninjalegends_hub2_artifacts/bytecode_parsed.json`: machine-readable parsed prototype/instruction dump.
- `Scripts/Unhiding/ninjalegends_hub2_artifacts/opcode_semantic_map.json`: machine-readable opcode map.

What was decoded:

- Prototype count: 74
- Instruction records: 14,957
- Constant records: 1,156

Instruction field layout:

- `op`: VM handler index.
- `A`, `B`, `C`: decoded ABC-style operand fields.
- `Bx`: decoded 18-bit field.
- `sBx`: `Bx - 131071`.
- Any `B` or `C` operand above 255 is a constant reference: `constant_index = operand - 256`.

Dispatch table:

The VM does not dispatch directly to the table literal in order. It uses
`handler[op + 1]`, where `handler` is a shuffled table built from the original
handler slots. `opcode_map.md` contains the corrected mapping for bytecode
`OP_00` through `OP_37`.

Current limitation:

The VM bytecode is parsed into structured prototypes, constants, numeric
instructions, and semantic opcode names. A trustworthy exact Lua source
reconstruction would still require control-flow structuring and expression
lifting from the semantic instruction stream.

Handler names confirmed from manual inspection:

- `ADD`, `SUB`, `MUL`, `DIV`, `MOD`, `POW`, `UNM`
- `LOADK`, `LOADBOOL`, `LOADNIL`, `MOVE`, `NEWTABLE`
- `GETGLOBAL`, `SETGLOBAL`, `GETUPVAL`, `SETUPVAL`, `GETTABLE`, `SETTABLE`, `SELF`
- `JMP`, `EQ`, `LT`, `LE`, `TEST`, `TESTSET`
- `CALL`, `TAILCALL`, `RETURN`, `CLOSURE`, `VARARG`
- `FORPREP`, `FORLOOP`, `TFORLOOP`, `SETLIST`, `CONCAT`, `LEN`, `NOT`, `CLOSE`
