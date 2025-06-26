# Linux Privilege Escalation

## Quick checklist

- Check kernel version: `uname -a`
- Look for SUID binaries: `find / -perm -4000 -type f 2>/dev/null`
- Check for writable files or services running as root
- Crontabs: `cat /etc/crontab`, `ls -la /etc/cron.*`
- Capabilities: `getcap -r / 2>/dev/null`

## Useful Tools

- [LinPEAS](https://github.com/carlospolop/PEASS-ng)
- [Linux Exploit Suggester](https://github.com/mzet-/linux-exploit-suggester)
- [GTFOBins](https://gtfobins.github.io)

## Sample Exploit: SUID Bash

```bash
chmod +s /bin/bash
./bash -p
# Now you have a root shell if bash is misconfigured

```
## Notes

Always check /etc/passwd and /etc/shadow
Look for $PATH misconfigs or writable dirs

