# RecycledGate

This is just another implementation of Hellsgate + Halosgate/Tartarosgate.    

However, this implementation makes sure that **all system calls still go through ntdll.dll** to avoid the usage of direct systemcalls.
To do so, I parse the ntdll for nonhooked syscall-stubs and re-use existing ```syscall;ret``` instructions - thus the name of this project.   

This probably bypasses some EDR trying to detect abnormal systemcalls.

A sample program using **RecycledGate** can be found in the **sample** folder     

## Usage
Here is a snippet, which should be self-explanatory.
```c
Syscall sysNtCreateSection = { 0x00 };
NTSTATUS ntStatus;

dwSuccess = getSyscall(0x916c6394, &sysNtCreateSection);
if (dwSuccess == FAIL)
  goto exit;

PrepareSyscall(sysNtCreateSection.dwSyscallNr, sysNtCreateSection.pRecycledGate);
ntStatus = DoSyscall(&hSection, SECTION_MAP_READ | SECTION_MAP_WRITE | SECTION_MAP_EXECUTE, NULL, (PLARGE_INTEGER)&sizeBuffer, PAGE_EXECUTE_READWRITE, SEC_COMMIT, NULL);
if (!NT_SUCCESS(ntStatus)) {
  printf("[-] Failed to create section\n");
  goto exit;
}

```
**Note**:
* No instructions must exist between the call to **PrepareSyscall** and **DoSyscall**
* The hash algorithm used is djb2. All hashes must be encrypted with the key **0x41424344**. You can use the Hashgenerator.c file in the samples folder

## Credits

* Am0nsec and RtlMateusz for [Original Hellsgate implementation](https://github.com/am0nsec/HellsGate)
* Boku7 for inspiration and his [Halosgate implementation](https://github.com/boku7/AsmHalosGate/)
* Sektor7 for the amazing [windows evasion class](https://sektor7.net)
