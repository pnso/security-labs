# Nmap Recon Guide

This guide is about Nmap ("Network mapper") to document my learning and usage of it.

## TL;DR: Go-To Nmap Commands

```bash
nmap -sC -sV -oN scan.txt 10.10.10.10
nmap -p- --min-rate=10000 -oG full.txt 10.10.10.10
nmap -sS -T4 -p- 10.129.228.219

```

## Basic Scans

```bash
nmap <target>
nmap -v <target>           # Verbose output
nmap -Pn <target>          # Skip host discovery (treat host as up)
```

## Port Scanning

```bash
nmap -F <target>           # Fast scan (default top 100 ports)
nmap -p- <target>          # Scan all 65535 ports
nmap -p 21,22,80 <target>  # Scan specific ports (FTP, SSH, HTTP)

```

## Version & Service Detection

```bash
nmap -sV <target>         # Detect service versions
nmap -sC -sV <target>     # Default scripts + version info

```

## OS Detection

```bash
nmap -O <target>
nmap -A <target>          # Aggressive scan: OS + services + traceroute

```

## Output Formats

```bash
nmap -oN scan.txt <target> # Normal output
nmap -oG grep.txt <target> # Grepable output
nmap -oX xml.txt <target>  # XML output

```

## Timing & Stealth

```bash
nmap -T0 <target>          # Paranoid (slowest)
nmap -T4 <target>          # Aggressive (faster, less stealthy)
nmap -sS <target>          # SYN scan (stealthy)
nmap -sT <target>          # TCP connect (less stealthy)

```

## NSE Scripts (Examples)

Nmap has a powerful scripting engine (NSE) to automate discovery and exploitation.

```bash
nmap --script vuln <target>          # Run all vulnerability scripts
nmap --script http-title <target>    # Get page title (if HTTP found)
nmap --script smb-enum-shares -p 139,445 <target> # List open SMB shares
nmap --script ftp-anon -p 21 <target>      # Check for anonymous FTP login
nmap --script ssh-hostkey -p 22 <target>   # Show SSH key fingerprint

```

## Sample Scenarios

```bash
nmap -p- --min-rate=10000 -oG full.txt <target>  # Fast scan all ports
nmap -sC -sV -oN recon.txt <target>  # Common recon scan

```

## Notes To Self

- Use `-Pn` when ICMP is blocked.
- Use `-p-` early to find non-standard services.
- Always save output (`-oN`, `-oG`) to reuse findings.

