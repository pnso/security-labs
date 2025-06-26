#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "[!] Run as root for full results (some dirs might be restricted)."
  echo
fi

echo "==== LINUX PRIVILEGE ESCALATION SCAN ===="
echo "Scan run at: $(date)"
echo

echo "==== SYSTEM INFO ===="
echo "[+] Kernel:"
uname -a
echo

echo "[+] OS Version:"
cat /etc/*release 2>/dev/null
echo

echo "[+] Hostname:"
hostname
echo

echo "[+] Current User & Groups:"
whoami
id
groups
echo

echo "==== SUDO MISCONFIG ===="
echo "[+] Sudo rights:"
sudo -l 2>/dev/null
echo

echo "[*] Checking for NOPASSWD sudo access..."
if sudo -l 2>/dev/null | grep -q NOPASSWD; then
    echo "[!] NOPASSWD sudo access detected. Potential privesc!"
else
    echo "[-] No NOPASSWD rules found"
fi
echo

echo "==== USERS & PASSWORDS ===="
echo "[+] Home directories:"
ls /home
echo

echo "[+] .bash_history files:"
find /home /root -name ".*history" 2>/dev/null
echo

echo "[+] Shadow file permissions:"
ls -l /etc/shadow
echo

echo "==== SUID BINARIES ===="
echo "[+] SUID files:"
find / -perm -4000 -type f 2>/dev/null | tee suid.txt
echo

echo "[*] Known GTFOBins from SUID list:"
grep -E 'nmap|vim|less|nano|bash|perl|python|find' suid.txt || echo "[-] No Known GTFOBins found"
echo

echo "==== FILE PERMISSIONS ===="
echo "[+] World-writable files:"
find / -type f -perm -o+w -not -path "/proc/*" 2>/dev/null | head -n 20
echo

echo "[+] Writable /etc files:"
find /etc -writable 2>/dev/null | head -n 20
echo

echo "==== CRON JOBS ===="
echo "[+] Crontab contents:"
cat /etc/crontab 2>/dev/null
ls -la /etc/cron* 2>/dev/null
echo

echo "[+] Writable cron dirs:"
find /etc/cron* -type d -perm -2 -ls 2>/dev/null
echo

echo "==== CAPABILITIES ===="
echo "[+] File capabilities:"
getcap -r / 2>/dev/null | grep -v "No such"
echo

echo "==== ENVIRONMENT & PATH ===="
echo "[+] PATH variable:"
echo $PATH
echo

echo "[*] Writable dirs in PATH:"
echo $PATH | tr ':' '\n' | while read path; do
    [ -w "$path" ] && echo "[!] Writable: $path"
done
echo

echo "==== NETWORK INFO ===="
echo "[+] Interfaces:"
ip a
echo

echo "[+] Listening Ports:"
netstat -tulnp 2>/dev/null || ss -tulnp
echo

echo "[+] Hosts file:"
cat /etc/hosts
echo

echo "==== EXPLOIT SUGGESTIONS ===="
KERNEL=$(uname -r | cut -d '-' -f1)

echo "[*] Kernel version: $KERNEL"
if [[ "$KERNEL" < "4.4" ]]; then
    echo "[!] Old kernel - search for local exploits on ExploitDB"
else
    echo "[-] Kernel not very old, but still check manually"
fi

if [[ "$KERNEL" < "4.8" ]]; then
    echo "[!] Dirty COW (CVE-2016-5195) may be exploitable. Try https://github.com/FireFart/dirtycow"
fi
echo

echo "==== DONE ===="
