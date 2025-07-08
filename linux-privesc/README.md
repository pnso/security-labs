# Linux Privilege Escalation Scanner

This script automates basic Linux privilege escalation checks. Useful in CTFs, lab environments, or when you gain limited shell access and need a quick overview of potential priv-esc paths.


## Features

- SUDO/NOPASSWD misconfig checks
- SUID/GTFOBins detection
- Crontab and world-writable cron directories
- PATH misconfig and writable folders
- File capabilities
- Kernel version exploit hints (Dirty COW, old kernels)
- Network, host, and environment recon
- History and shadow file exposure checks

## File

- `linux_privesc_scan.sh`: Bash script for scanning a Linux system for privilege escalation vectors.

## How To Use: 

chmod +x linux_privesc_scan.sh
./linux_privesc_scan.sh > scan_output.txt


## Notes
This script is meant to be run from a low-privilege shell (post initial access) to help find a path to root.
If you run it after privilege escalation (as root), more checks like /etc/shadow access and full cron visibility will be available.