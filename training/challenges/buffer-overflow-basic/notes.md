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

## Offset

- `cyclic_find(0x6161616c)` with `context.arch = 'i386'` returns **44**.
- Verified: payload `b'A' * 44 + p32(0x42424242)` puts `0x42424242` in EIP under gdb.
- Note: in the container gdb could not disable ASLR (`Operation not permitted`). Stack addresses can change between runs, so do not hardcode the stack address. The `jmp esp` address is fixed, because the binary is not PIE.

Next: send the shellcode after the return address, and use `jmp esp` to jump to it.

## Status

- [x] Recon
- [x] Crash reproduced in the lab
- [x] Offset found (44)
- [ ] Exploit runs in the lab
