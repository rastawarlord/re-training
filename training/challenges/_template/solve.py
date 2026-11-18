#!/usr/bin/env python3
# Solve script template. Copy this folder to training/challenges/<name>/ and edit.
from pwn import *

context.binary = ELF("./challenge", checksec=False)
context.log_level = "info"

def start():
    if args.REMOTE:
        return remote(args.HOST, int(args.PORT))
    return process(context.binary.path)

io = start()

# payload = ...
# io.sendline(payload)
# io.interactive()
