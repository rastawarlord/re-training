# RE and Pwn CTF Training

Notes, walkthroughs, and solve scripts for reverse engineering and binary exploitation (pwn) challenges.

## What's here

- `training/`: the practice plan, the Docker lab definition, the progress tracker, and the Mermaid mind maps
- `training/challenges/`: one folder per challenge with recon notes and the solve
- `training/mindmaps/`: diagrams of the workflow, the thought process, and the tool categories
- `solves/`: solve scripts and writeups
- `scripts/install-re-tools.sh`: installs the root-requiring tools on macOS with MacPorts
- `.claude/settings.json`: command allowlist for the project's AI-assisted workflow

Challenge binaries from third-party courses are not included. Each challenge's notes point to its original source.

## Lab

Linux-only challenges run in a container. The lab image is built from `training/docker/Dockerfile` (Ubuntu 22.04, i386 multilib, pwntools, ropper, ROPgadget, pwndbg).

## Status

Work in progress. Start with `training/progress.md`.
