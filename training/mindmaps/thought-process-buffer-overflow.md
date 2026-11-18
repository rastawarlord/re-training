# Thought process: buffer overflow (buffer-overflow-basic)

```mermaid
mindmap
  root((Stack overflow))
    Recon
      32-bit ELF, not stripped
      No canary
      NX disabled
      PIE disabled
    Bug
      gets has no length limit
      buffer is 32 bytes on stack
    Control flow
      Offset to saved EIP
        cyclic pattern
        cyclic_find
      Overwrite EIP
        jmp esp gadget 0x8048420
    Payload
      Padding to offset
      Return address
      Shellcode after return address
    Verify
      Crash in gdb first
      Then full exploit
```

## Questions to answer before writing the exploit

1. Where does the input land relative to the saved return address?
2. Which bytes of the payload does the program read as control data?
3. Why does the stack being executable matter here?
4. What breaks if the return address points at the shellcode directly, with no `jmp esp`?
