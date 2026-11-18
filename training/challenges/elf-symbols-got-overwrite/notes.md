# elf-symbols-got-overwrite (pwntools-tutorial)

Source: `pwntools-tutorial/walkthrough/elf-symbols-got-overwrite` (course material, not copied here).
Type: pwn, i386 ELF, PIE. Lab: lab container (run); recon on the Mac.

## Recon (static)

- `checksec`: Partial RELRO, **stack canary**, **NX enabled**, **PIE enabled**.
- Imports: `printf`, `read`, `system`, `write`. `system` is imported, so it exists in the binary's GOT/PLT.
- `oh_look_useful()` calls `system("/bin/sh")`, but nothing calls it. It's a ret2win-style target.
- `main` does two things:
  1. Leaks `&main` with `write(1, ...)`, so you learn the runtime address of `main`.
  2. Loops forever: `read` a `where` pointer and a `what` value, then `*where = what`. That's an arbitrary 4-byte write.

## Plan (to be completed by me)

- Use the leaked `&main` to compute the PIE base. `main` is at `0x73d` in the file, so `base = leak - 0x73d`.
- Pick a GOT entry that gets called later, and point it at `oh_look_useful` (`base + offset`).
- Partial RELRO means the GOT is writable, so the write primitive can change it.

## Status

- [x] Recon
- [ ] Leak parsed and base computed
- [ ] GOT entry chosen
- [ ] Exploit runs in the lab
