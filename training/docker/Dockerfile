# RE / pwn practice lab. Built on dockerhost, not on the Mac.
# glibc base (CTF targets are glibc), i386 multilib for 32-bit challenges.
FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y --no-install-recommends \
    gdb gdbserver gcc gcc-multilib g++-multilib make binutils file strace ltrace \
    python3 python3-dev python3-pip python3-venv git curl ca-certificates \
    netcat-openbsd socat patchelf nasm xxd libc6-dbg:i386 \
    && rm -rf /var/lib/apt/lists/*

# pwndbg: its own setup script installs the pinned gdb-side pieces.
RUN git clone --depth 1 https://github.com/pwndbg/pwndbg /opt/pwndbg \
    && cd /opt/pwndbg && ./setup.sh

# Python tools for exploit work, in a venv so they stay isolated.
RUN python3 -m venv /opt/pwn && /opt/pwn/bin/pip install --no-cache-dir pwntools ropper ROPgadget
ENV PATH="/opt/pwn/bin:${PATH}"

WORKDIR /work
CMD ["/bin/bash"]
