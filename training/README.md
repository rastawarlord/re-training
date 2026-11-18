# RE and Pwn Training Lab

Daily practice for reverse engineering and pwn CTF challenges.

## Where things run

- **Mac (this machine):** notes, solve scripts, Ghidra GUI, radare2/rizin static analysis, pwntools scripting. Static work is fine here.
- **dockerhost (Linux):** anything that *runs* a challenge binary. The lab image `re-pwn:latest` is built there from `docker/Dockerfile`.

ELF challenge binaries do not execute on macOS. Run them in the lab container.

## Layout

- `docker/Dockerfile`: lab image (Ubuntu 22.04, i386 multilib, gdb + pwndbg, pwntools, ropper, ROPgadget)
- `challenges/<name>/`: one folder per challenge (notes.md, solve.py)
- `progress.md`: what's solved, when, and what to review
- Original course material stays in its own folders (`pwntools-tutorial/`, `dc540-0x00005b/`, ...). Never copy it into `challenges/` or push it to GitHub. Reference it by path.

## Daily loop (weekdays)

1. Pick one challenge from the track in `progress.md`.
2. Recon on the Mac: `file`, `checksec`, `strings`, `rizin`/`r2` for the function list.
3. Run it in the lab: `ssh dockerhost` then `docker run -it --rm -v <path>:/work re-pwn:latest`.
4. Debug with `pwndbg` inside the container. Try the solve yourself first.
5. Write `challenges/<name>/notes.md` (what it does, the bug, the primitive, the solve) and `solve.py`.
6. Update `progress.md`.

## Weekend CTF

Friday to Sunday: play the event. Log each solve or attempt in `progress.md`. Review unsolved challenges on Monday.
