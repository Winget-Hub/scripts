# NinjaLegends hub 2 opcode map

Bytecode dispatch uses `handler[op + 1]`, but that dispatch table is permuted. This map is the corrected bytecode opcode to handler semantic mapping.

| Bytecode op | Handler slot | Mnemonic | Pseudocode |
|---:|---:|---|---|
| OP_00 | 3 | `FORPREP` | `numeric for prep; validate R[A..A+2], R[A] -= R[A+2], PC += sBx` |
| OP_01 | 33 | `VARARG` | `load varargs into R[A..]` |
| OP_02 | 11 | `TAILCALL` | `tail-call R[A](R[A+1..]) and return its results` |
| OP_03 | 28 | `UNM` | `R[A] = -R[C]` |
| OP_04 | 37 | `LEN` | `R[A] = #R[C]` |
| OP_05 | 19 | `FORLOOP` | `numeric for loop step; R[A]+=R[A+2], compare with R[A+1], PC += sBx` |
| OP_06 | 30 | `CLOSURE` | `R[A] = closure(proto[Bx], upvalues...)` |
| OP_07 | 29 | `CALL` | `call R[A](R[A+1..]) and store B results` |
| OP_08 | 16 | `LOADK` | `R[A] = K[Bx]` |
| OP_09 | 34 | `SUB` | `R[A] = RK(C) - RK(B)` |
| OP_10 | 18 | `MOVE` | `R[A] = R[C]` |
| OP_11 | 27 | `SETUPVAL` | `UPVAL[K[Bx] or R[251]] = R[A]` |
| OP_12 | 0 | `TEST` | `if (not not R[A]) == (B == 0) then PC++ end` |
| OP_13 | 9 | `SETTABLE` | `R[A][RK(C)] = RK(B)` |
| OP_14 | 21 | `NEWTABLE` | `R[A] = {}` |
| OP_15 | 25 | `SETGLOBAL` | `ENV[C] = R[A]` |
| OP_16 | 15 | `POW` | `R[A] = RK(C) ^ RK(B)` |
| OP_17 | 32 | `JMP` | `PC += sBx` |
| OP_18 | 23 | `TESTSET` | `if boolean test passes PC++ else R[A] = R[C]` |
| OP_19 | 1 | `ADD` | `R[A] = RK(C) + RK(B)` |
| OP_20 | 6 | `DIV` | `R[A] = RK(C) / RK(B)` |
| OP_21 | 10 | `CLOSE` | `close/upvalue bookkeeping for registers >= A` |
| OP_22 | 20 | `NOT` | `R[A] = not R[C]` |
| OP_23 | 22 | `LE` | `if RK(C) <= RK(B) ~= (A ~= 0) then PC++ end` |
| OP_24 | 31 | `LOADNIL` | `for reg=A,C do R[reg] = nil end` |
| OP_25 | 17 | `RETURN` | `return R[A..A+C-2], or open return when C == 0` |
| OP_26 | 2 | `GETTABLE` | `R[A] = R[C][RK(B)]` |
| OP_27 | 35 | `GETUPVAL` | `R[A] = UPVAL[K[Bx] or R[251]]` |
| OP_28 | 4 | `EQ` | `if RK(C) == RK(B) ~= (A ~= 0) then PC++ end` |
| OP_29 | 24 | `CONCAT` | `R[A] = R[C] .. ... .. R[B]` |
| OP_30 | 8 | `TFORLOOP` | `generic for iterator step; calls R[A](R[A+1], R[A+2])` |
| OP_31 | 7 | `SETLIST` | `for n=1,C do R[A][(B-1)*50+n] = R[A+n] end` |
| OP_32 | 36 | `MOD` | `R[A] = RK(C) % RK(B)` |
| OP_33 | 14 | `SELF` | `R[A+1] = R[C]; R[A] = R[C][RK(B)]` |
| OP_34 | 12 | `LT` | `if RK(C) < RK(B) ~= (A ~= 0) then PC++ end` |
| OP_35 | 26 | `LOADBOOL` | `R[A] = (C ~= 0); if B ~= 0 then PC++ end` |
| OP_36 | 13 | `MUL` | `R[A] = RK(C) * RK(B)` |
| OP_37 | 5 | `GETGLOBAL` | `R[A] = ENV[C]` |
