# buffer-overflow-basic (pwntools-tutorial)

Source of the binary: `pwntools-tutorial/walkthrough/buffer-overflow-basic` (course material, not copied here).

## Recon (static, on the Mac)

- `file`: ELF 32-bit LSB, Intel 80386, dynamically linked, not stripped.
- `checksec`: Partial RELRO, **no canary**, **NX disabled** (stack executable), **PIE disabled**.
- `main`: `char buffer[32]` at `esp+0x10`, then `gets(buffer)`. The bug: `gets` has no length limit.
- `oh_look_useful`: contains `jmp esp` at `0x8048420`. Useful as a return target because the stack is executable and the buffer lives on the stack.

## Plan (to be completed by me)

1. Find the offset from `buffer` to saved EIP with a cyclic pattern.
2. Overwrite EIP with `0x8048420` (`jmp esp`).
3. Place shellcode right after the saved EIP.

## Dynamic: crash with a cyclic pattern (lab container, gdb 12.1)

- Input: `cyclic(200)` on stdin.
- Result: `SIGSEGV` at `0x6161616c` ("laaa").
- `EIP` = `0x6161616c`, `EBP` = `0x6161616b` ("kaaa").
- `ESP` = `0xff977c50`, which points at the pattern bytes after the overwritten EIP (`maaa...`).
- gdb disables ASLR by default here, so these addresses are stable across runs in gdb.

Next: compute the offset from the start of the buffer to EIP (`cyclic_find`), then decide where the shellcode goes.

## Status

- [x] Recon
- [x] Crash reproduced in the lab
- [ ] Offset found
- [ ] Exploit runs in the lab
