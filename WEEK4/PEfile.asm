.386
.model flat, stdcall
option casemap :none

include D:\masm32\include\windows.inc
include D:\masm32\include\kernel32.inc ;include winAPI( GetStdHandle,ReadConsole,CreateFile....)
include D:\masm32\include\msvcrt.inc
include D:\masm32\include\comdlg32.inc
includelib D:\masm32\lib\msvcrt.lib
includelib D:\masm32\lib\kernel32.lib

includelib D:\masm32\lib\comdlg32.lib

.data
    ImportDirectory_SIZE_STORE dd 0
    ImportDirectory_VA_STORE dd 100 dup(?)
    PSECT_VIRTUALADDRESS dd 0
    PSECT_PointerToRawData dd 0
    BUFFER_SIZE dd 0
    hOutPut dd 0 
    hFile dd 0
    filepath db 100 dup(0)
    chars_read dd 0
    filepath1 db "C:\Users\ADMIN\Downloads\CFF_Explorer\CFF Explorer.exe",0
    FullHeader db 1000h dup(0)
    FullHeader_size dd 0
    HexString db 17 dup(?)
    HexString_rev db 17 dup(?)
    DOSHEADER db "######## DOS HEADER ##############",0
    endheader db 10,"##################################",0
    DOS_e_magic db 10,9,"[+] e_magic:0x",0
    DOS_e_cblp db 10,9,"[+] e_cblp:0x", 0
    DOS_e_cp db 10,9,"[+] e_cp:0x", 0
    DOS_e_crlc db 10,9,"[+] e_crlc:0x", 0
    DOS_e_cparhdr db 10,9,"[+] e_cparhdr:0x", 0
    DOS_e_minalloc db 10,9,"[+] e_minalloc:0x", 0
    DOS_e_maxalloc db 10,9,"[+] e_maxalloc:0x", 0
    DOS_e_ss db 10,9,"[+] e_ss:0x", 0
    DOS_e_sp db 10,9,"[+] e_sp:0x", 0
    DOS_e_csum db 10,9,"[+] e_csum:0x", 0
    DOS_e_ip db 10,9,"[+] e_ip:0x", 0
    DOS_e_cs db 10,9,"[+] e_cs:0x", 0
    DOS_e_lfarlc db 10,9,"[+] e_lfarlc:0x", 0
    DOS_e_ovno db 10,9,"[+] e_ovno:0x", 0
    DOS_e_res db 10,9,"[+] e_res:0x", 0
    DOS_e_oemid db 10,9,"[+] e_oemid:0x", 0
    DOS_e_oeminfo db 10,9,"[+] e_oeminfo:0x", 0
    DOS_e_res2 db 10,9,"[+] e_res2:0x", 0
    DOS_e_lfanew db 10,9,"[+] e_lfanew:0x", 0 

    NT_Signature db 10,9,"[+] Signature:0x",0
    NT_Machine               db 10,9,"[+] MAchine:0x",0
    NT_NumberOfSections      db 10,9,"[+] NUMBER OF SECTION:0x",0
    NT_TimeDateStamp         db 10,9,"[+] Time Date Stamp:",0
    NT_PointerToSymbolTable  db 10,9,"[+] Pointer to symbol table:",0
    NT_NumberOfSymbols       db 10,9,"[+] NUmber of Symbol:",0
    NT_SizeOfOptionalHeader  db 10,9,"[+] SIZE OF OPTIONAL HEADER:0x",0
    NT_Characteristics       db 10,9,"[+] Characteristic:0x",0

    NT_optional_Magic                         db 10,9,"[+] MAGIC:0x",0
    NT_optional_MajorLinkerVersion            db 10,9,"[+] MajorLinkerVersion:0x",0
    NT_optional_MinorLinkerVersion            db 10,9,"[+] MinorLinkerVersion:0x",0
    NT_optional_SizeOfCode                    db 10,9,"[+] SizeOfCode:0x",0
    NT_optional_SizeOfInitializedData         db 10,9,"[+] SizeOfInitializedData:0x",0
    NT_optional_SizeOfUninitializedData       db 10,9,"[+] SizeOfUninitializedData:0x",0
    NT_optional_AddressOfEntryPoint           db 10,9,"[+] AddressOfEntryPoint:0x",0
    NT_optional_BaseOfCode                    db 10,9,"[+] BaseOfCode:0x",0
    NT_optional_BaseOfData                    db 10,9,"[+] BaseOfData:0x",0
    NT_optional_ImageBase                     db 10,9,"[+] ImageBase:0x",0
    NT_optional_SectionAlignment              db 10,9,"[+] SectionAlignment:0x",0
    NT_optional_FileAlignment                 db 10,9,"[+] FileAlignment:0x",0
    NT_optional_MajorOperatingSystemVersion   db 10,9,"[+] MajorOperatingSystemVersion:0x",0
    NT_optional_MinorOperatingSystemVersion   db 10,9,"[+] MinorOperatingSystemVersion:0x",0
    NT_optional_MajorImageVersion             db 10,9,"[+] MajorImageVersion:0x",0
    NT_optional_MinorImageVersion             db 10,9,"[+] MinorImageVersion:0x",0
    NT_optional_MajorSubsystemVersion         db 10,9,"[+] MajorSubsystemVersion:0x",0
    NT_optional_MinorSubsystemVersion         db 10,9,"[+] MinorSubsystemVersion:0x",0
    NT_optional_Win32VersionValue             db 10,9,"[+] Win32VersionValue:0x",0
    NT_optional_SizeOfImage                   db 10,9,"[+] SizeOfImage:0x",0
    NT_optional_SizeOfHeaders                 db 10,9,"[+] SizeOfHeaders:0x",0
    NT_optional_CheckSum                      db 10,9,"[+] CheckSum:0x",0
    NT_optional_Subsystem                     db 10,9,"[+] Subsystem:0x",0
    NT_optional_DllCharacteristics            db 10,9,"[+] DllCharacteristics:0x",0
    NT_optional_SizeOfStackReserve            db 10,9,"[+] SizeOfStackReserve:0x",0
    NT_optional_SizeOfStackCommit             db 10,9,"[+] SizeOfStackCommit:0x",0
    NT_optional_SizeOfHeapReserve             db 10,9,"[+] SizeOfHeapReserve:0x",0
    NT_optional_SizeOfHeapCommit              db 10,9,"[+] SizeOfHeapCommit:0x",0
    NT_optional_LoaderFlags                   db 10,9,"[+] LoaderFlags:0x",0
    NT_optional_NumberOfRvaAndSizes           db 10,9,"[+] NumberOfRvaAndSizes:0x",0
    ExportDirectory_VA db 10,9,"[+] ExportDirectory VA:0x",0
    ExportDirectory_Size db 10,9,"[+] ExportDirectory Size:0x",0
    ImportDirectory_VA db 10,9,"[+] ImportDirectory VA:0x",0
    ImportDirectory_Size db 10,9,"[+] ImportDirectory Size:0x",0
    ResourceDirectory_VA db 10,9,"[+] ResourceDirectory VA:0x",0
    ResourceDirectory_Size db 10,9,"[+] ResourceDirectory Size:0x",0
    ExceptionDirectory_VA db 10,9,"[+] ExceptionDirectory VA:0x",0
    ExceptionDirectory_Size  db 10,9,"[+] ExceptionDirectory_Size:0x",0
    SecurityDirectory_VA db 10,9,"[+] SecurityDirectory_VA:0x",0
    SecurityDirectory_Size db 10,9,"[+] SecurityDirectory_Size:0x",0
    BaseRelocationTable_VA db 10,9,"[+] BaseRelocationTable_VA:0x",0
    BaseRelocationTable_Size db 10,9,"[+] BaseRelocationTable_Size:0x",0
    DebugDirectory_VA db 10,9,"[+] DebugDirectory_VA:0x",0
    DebugDirectory_Size db 10,9,"[+] DebugDirectory_Size:0x",0
    ArchitectureSpecificData_VA db 10,9,"[+] ArchitectureSpecificData_VA:0x",0
    ArchitectureSpecificData_Size db 10,9,"[+] ArchitectureSpecificData_VA:0x",0
    RVAofGP_VA db 10,9,"[+] RVAofGP_VA:0x",0
    RVAofGP_Size db 10,9,"[+] RVAofGP_Size:0x",0
    TLSDirectory_VA db 10,9,"[+] TLSDirectory_VA:0x",0
    TLSDirectory_Size db 10,9,"[+] TLSDirectory_Size:0x",0
    LoadConfigurationDirectory_VA db 10,9,"[+] LoadConfigurationDirectory_VA:0x",0
    LoadConfigurationDirectory_Size db 10,9,"[+] LoadConfigurationDirectory_Size:0x",0
    BoundImportDirectoryinheaders_VA db 10,9,"[+] BoundImportDirectoryinheaders_VA:0x",0
    BoundImportDirectoryinheaders_Size db 10,9,"[+] BoundImportDirectoryinheaders_Size:0x",0
    ImportAddressTable_VA db 10,9,"[+] ImportAddressTable_VA:0x",0
    ImportAddressTable_Size db 10,9,"[+] ImportAddressTable_Size:0x",0
    DelayLoadImportDescriptors_VA db 10,9,"[+] DelayLoadImportDescriptors_VA:0x",0
    DelayLoadImportDescriptors_Size db 10,9,"[+] DelayLoadImportDescriptors_Size:0x",0
    COMRuntimedescriptor_VA db 10,9,"[+] COMRuntimedescriptor_VA:0x",0
    COMRuntimedescriptor_Size db 10,9,"[+] COMRuntimedescriptor_Size:0x",0
   ;;;;;;;;;; SECTION HEADER ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    SECTIONHEADER db 10,"############### SECTION HEADER ###############",10,0
    Name1 db 10,9,"[+]NAME:",0 
    PhysicalAddress_or_VirtualSize db 10,9,"Physic/Virtual Address:0x",0 
    VirtualAddress  db 10,9,"Virtual address:0x",0
    SizeOfRawData  db 10,9,"Size of raw data:0x",0
    PointerToRawData  db 10,9,"Pointer to raw data0x",0
    PointerToRelocations  db 10,9,"Pointer to Relocation:0x",0
    PointerToLinenumbers  db 10,9,"Pointer to line number:0x",0
    NumberOfRelocations  db 10,9,"NUmber of relocation:0x",0
    NumberOfLinenumbers  db 10,9,"NUmber of line number:0x",0
    Characteristics  db 10,9,"Characteristics:0x",0
    ;;;;;;;;;;;;;;;;;;;;; IMPORT DIRECTORY ;;;;;;;;;;;;;;;;;;;;;;;;;


    IMPORTHEADER db 10,"################# IMPORT DIRECTORY ############",10
    OriginalFirstThunk  db 10,10,9,"OriginalFirstThunk:0x",0
    TimeDateStamp db 10,9,"TimeDateStamp:0x",0
    ForwarderChain db 10,9,"ForwarderChain:0x",0
    Name_IMPORT db 10,9,"Name:",0
    FirstThunk db 10,9,"FirstThunk:0x",0

.code

IMPORT_DIRECTORY_READ PROC
    push ebp 
    mov ebp,esp 
    push eax 
    mov edi,offset IMPORTHEADER
    mov esi,LENGTHOF IMPORTHEADER
    call print_f

IMPORT_DIRECTORY_READ_START:
    mov eax,DWORD PTR [esp]
    mov edi,DWORD PTR [FullHeader+eax]
    and edi,0ffffffffh
    cmp edi ,0
    jmp IMPORT_DIRECTORY_READ_CHECK
IMPORT_DIRECTORY_READ_CONTINUE:
    mov edi,offset OriginalFirstThunk
    mov esi,LENGTHOF OriginalFirstThunk
    call print_f
    mov eax,DWORD PTR [esp]
    mov edi,DWORD PTR [FullHeader+eax]
    and edi,0ffffffffh
    xor esi ,esi 
    call intohex
    mov edi,offset HexString_rev
    mov esi,9
    call print_f

    mov edi,offset TimeDateStamp
    mov esi,LENGTHOF TimeDateStamp
    call print_f
    mov eax,DWORD PTR [esp]
    mov edi,DWORD PTR [FullHeader+eax+4]
    and edi,0ffffffffh
    xor esi ,esi 
    call intohex
    mov edi,offset HexString_rev
    mov esi,9
    call print_f

    mov edi,offset ForwarderChain
    mov esi,LENGTHOF ForwarderChain
    call print_f
    mov eax,DWORD PTR [esp]
    mov edi,DWORD PTR [FullHeader+eax+8]
    and edi,0ffffffffh
    xor esi ,esi 
    call intohex
    mov edi,offset HexString_rev
    mov esi,9
    call print_f

    mov edi,offset Name_IMPORT
    mov esi,LENGTHOF Name_IMPORT
    call print_f
    mov eax,DWORD PTR [esp]
    mov edi,DWORD PTR [FullHeader+eax+0ch]
    sub edi,DWORD PTR [PSECT_VIRTUALADDRESS]
    add edi ,DWORD PTR [PSECT_PointerToRawData]
    mov eax,edi 
    mov edi ,offset FullHeader
    add edi , eax  
    mov esi,20
    call print_f

    mov edi,offset FirstThunk
    mov esi,LENGTHOF FirstThunk
    call print_f
    mov eax,DWORD PTR [esp]
    mov edi,DWORD PTR [FullHeader + eax + 10h]
    xor esi,esi 
    call intohex
    mov edi,offset HexString_rev
    mov esi,9
    call print_f
    add DWORD PTR [esp],20
    jmp IMPORT_DIRECTORY_READ_START 
IMPORT_DIRECTORY_READ_CHECK:
    mov eax,DWORD PTR [esp]
    mov edi,DWORD PTR [FullHeader + eax + 4]
    cmp edi,0 
    jne IMPORT_DIRECTORY_READ_CONTINUE
    mov edi,DWORD PTR [FullHeader + eax + 8] 
    cmp edi,0
    jne IMPORT_DIRECTORY_READ_CONTINUE
    mov edi,DWORD PTR [FullHeader + eax + 0ch] 
    cmp edi,0
    jne IMPORT_DIRECTORY_READ_CONTINUE
    mov edi,DWORD PTR [FullHeader + eax + 10h] 
    cmp edi,0
    jne IMPORT_DIRECTORY_READ_CONTINUE
    mov esp,ebp
    pop ebp 
    ret 
IMPORT_DIRECTORY_READ ENDP

SECTION_HEADER_READ PROC
    push ebp 
    mov ebp,esp 
    push edx ; count 
    push eax 
    ; print start 

    mov edi,offset SECTIONHEADER
    mov esi,LENGTHOF SECTIONHEADER
    call print_f
    SECTION_HEADER_READ_START:
        cmp DWORD PTR [esp+4],0
        je SECTION_HEADER_READ_done
        mov edi,offset Name1
        mov esi,LENGTHOF Name1 
        call print_f 
        cmp DWORD PTR [esp+4],2
        jne SECTION_HEADER_READ_START_CONTINUE
        mov eax,DWORD PTR [esp]
        mov  edi,DWORD PTR [FullHeader+eax + 0ch + 2]
        mov DWORD PTR [PSECT_VIRTUALADDRESS],edi 
        mov  edi,DWORD PTR [FullHeader+eax + 014h + 2]
        mov DWORD PTR [PSECT_PointerToRawData],edi
    SECTION_HEADER_READ_START_CONTINUE:  
        mov eax,DWORD PTR [esp]
        mov edi,offset FullHeader 
        add edi,eax 
        add edi,2 ; add 2 by trial dont know why
        mov esi,8
        call print_f

        mov edi,offset PhysicalAddress_or_VirtualSize
        mov esi,LENGTHOF PhysicalAddress_or_VirtualSize
        call print_f
        mov eax,DWORD PTR [esp]
        mov edi,DWORD PTR [FullHeader+eax+ 8+2]
        and edi,0ffffffffh
        xor esi ,esi 
        call intohex
        mov edi,offset HexString_rev
        mov esi,9
        call print_f

        mov edi,offset VirtualAddress
        mov esi,LENGTHOF VirtualAddress
        call print_f
        mov eax,DWORD PTR [esp]
        mov edi,DWORD PTR [FullHeader+eax+ 0ch  +2]
        and edi,0ffffffffh
        xor esi ,esi 
        call intohex
        mov edi,offset HexString_rev
        mov esi,9
        call print_f

        mov edi,offset SizeOfRawData
        mov esi,LENGTHOF SizeOfRawData
        call print_f
        mov eax,DWORD PTR [esp]
        mov edi,DWORD PTR [FullHeader+eax+ 010h +2]
        and edi,0ffffffffh
        xor esi ,esi 
        call intohex
        mov edi,offset HexString_rev
        mov esi,9
        call print_f

        mov edi,offset PointerToRawData
        mov esi,LENGTHOF PointerToRawData
        call print_f
        mov eax,DWORD PTR [esp]
        mov edi,DWORD PTR [FullHeader+eax+ 014h +2]
        and edi,0ffffffffh
        xor esi ,esi 
        call intohex
        mov edi,offset HexString_rev
        mov esi,9
        call print_f 

        mov edi,offset PointerToRelocations
        mov esi,LENGTHOF PointerToRelocations
        call print_f
        mov eax,DWORD PTR [esp]
        mov edi,DWORD PTR [FullHeader+eax+ 018h +2]
        and edi,0ffffffffh
        xor esi ,esi 
        call intohex
        mov edi,offset HexString_rev
        mov esi,9
        call print_f

        mov edi,offset PointerToLinenumbers
        mov esi,LENGTHOF PointerToLinenumbers
        call print_f
        mov eax,DWORD PTR [esp]
        mov eax,DWORD PTR [esp]
        mov edi,DWORD PTR [FullHeader+eax+ 01ch +2]
        and edi,0ffffffffh
        xor esi ,esi 
        call intohex
        mov edi,offset HexString_rev
        mov esi,9
        call print_f

        mov edi,offset NumberOfRelocations
        mov esi,LENGTHOF NumberOfRelocations
        call print_f
        mov eax,DWORD PTR [esp]
        mov edi,DWORD PTR [FullHeader+eax+ 020h +2]
        and edi,0ffffh
        xor esi ,esi 
        call intohex
        mov edi,offset HexString_rev
        mov esi,9
        call print_f

        mov edi,offset NumberOfLinenumbers
        mov esi,LENGTHOF NumberOfLinenumbers
        call print_f
        mov eax,DWORD PTR [esp]
        mov edi,DWORD PTR [FullHeader+eax+ 022h +2]
        and edi,0ffffh
        xor esi ,esi 
        call intohex
        mov edi,offset HexString_rev
        mov esi,9
        call print_f

        mov edi,offset Characteristics
        mov esi,LENGTHOF Characteristics
        call print_f
        mov eax,DWORD PTR [esp]
        mov edi,DWORD PTR [FullHeader+eax+ 024h +2]
        and edi,0ffffffffh
        xor esi ,esi 
        call intohex
        mov edi,offset HexString_rev
        mov esi,9
        call print_f
        add DWORD PTR [esp],40
        sub DWORD PTR [esp+4],1

        jmp SECTION_HEADER_READ_START
    SECTION_HEADER_READ_done:
        mov eax,DWORD PTR [esp] 
        mov esp,ebp 
        pop ebp 
        ret 
SECTION_HEADER_READ endp 
NT_HEADER_READ PROC
    push ebp
    mov ebp,esp
    push eax
    mov edi , offset NT_Signature
    mov esi , LENGTHOF NT_Signature
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_Machine
    mov esi,LENGTHOF NT_Machine
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+4]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_NumberOfSections
    mov esi,LENGTHOF NT_NumberOfSections
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+6]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f


    mov edi,offset NT_TimeDateStamp
    mov esi,LENGTHOF NT_TimeDateStamp
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+8]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_PointerToSymbolTable
    mov esi,LENGTHOF NT_PointerToSymbolTable
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0ch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_NumberOfSymbols
    mov esi,LENGTHOF NT_NumberOfSymbols
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+10h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_SizeOfOptionalHeader
    mov esi,LENGTHOF NT_SizeOfOptionalHeader
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+14h]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_Characteristics
    mov esi,LENGTHOF NT_Characteristics
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+16h]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    ;;;;;;;;;;;;;;;;;
    mov edi,offset NT_optional_Magic
    mov esi,LENGTHOF NT_optional_Magic
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+18h]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_MajorLinkerVersion
    mov esi,LENGTHOF NT_optional_MajorLinkerVersion
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+1ah]
    xor esi,esi
    and edi,0ffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_MinorLinkerVersion
    mov esi,LENGTHOF NT_optional_MinorLinkerVersion
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+1bh]
    xor esi,esi
    and edi,0ffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_SizeOfCode
    mov esi,LENGTHOF NT_optional_SizeOfCode
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+1ch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_SizeOfInitializedData
    mov esi,LENGTHOF NT_optional_SizeOfInitializedData
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+20h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_SizeOfUninitializedData
    mov esi,LENGTHOF NT_optional_SizeOfUninitializedData
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+24h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_AddressOfEntryPoint
    mov esi,LENGTHOF NT_optional_AddressOfEntryPoint
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+28h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_BaseOfCode
    mov esi,LENGTHOF NT_optional_BaseOfCode
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+2ch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_BaseOfData
    mov esi,LENGTHOF NT_optional_BaseOfData
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+30h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_ImageBase
    mov esi,LENGTHOF NT_optional_ImageBase
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+34h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_SectionAlignment
    mov esi,LENGTHOF NT_optional_SectionAlignment
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+38h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_FileAlignment
    mov esi,LENGTHOF NT_optional_FileAlignment
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+3ch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_MajorOperatingSystemVersion
    mov esi,LENGTHOF NT_optional_MajorOperatingSystemVersion
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+40h]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_MinorOperatingSystemVersion
    mov esi,LENGTHOF NT_optional_MinorOperatingSystemVersion
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+42h]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_MajorImageVersion
    mov esi,LENGTHOF NT_optional_MajorImageVersion
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+44h]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_MinorImageVersion
    mov esi,LENGTHOF NT_optional_MinorImageVersion
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+46h]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_MajorSubsystemVersion
    mov esi,LENGTHOF NT_optional_MajorSubsystemVersion
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+48h]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_MinorSubsystemVersion
    mov esi,LENGTHOF NT_optional_MinorSubsystemVersion
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+4ah]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_Win32VersionValue
    mov esi,LENGTHOF NT_optional_Win32VersionValue
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+4ch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_SizeOfImage
    mov esi,LENGTHOF NT_optional_SizeOfImage
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+50h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_SizeOfHeaders
    mov esi,LENGTHOF NT_optional_SizeOfHeaders
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+54h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_CheckSum
    mov esi,LENGTHOF NT_optional_CheckSum
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+58h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_Subsystem
    mov esi,LENGTHOF NT_optional_Subsystem
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+5ch]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_DllCharacteristics
    mov esi,LENGTHOF NT_optional_DllCharacteristics
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+5eh]
    xor esi,esi
    and edi,0ffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_SizeOfStackReserve
    mov esi,LENGTHOF NT_optional_SizeOfStackReserve
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+60h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_SizeOfStackCommit
    mov esi,LENGTHOF NT_optional_SizeOfStackCommit
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+64h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_SizeOfHeapReserve
    mov esi,LENGTHOF NT_optional_SizeOfHeapReserve
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+68h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_SizeOfHeapCommit
    mov esi,LENGTHOF NT_optional_SizeOfHeapCommit
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+6ch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_LoaderFlags
    mov esi,LENGTHOF NT_optional_LoaderFlags
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+70h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi,offset NT_optional_NumberOfRvaAndSizes
    mov esi,LENGTHOF NT_optional_NumberOfRvaAndSizes
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+74h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    mov edi, offset ExportDirectory_VA
    mov esi, LENGTHOF ExportDirectory_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+78h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f


    mov edi, offset ExportDirectory_Size
    mov esi, LENGTHOF ExportDirectory_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+7ch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset ImportDirectory_VA
    mov esi, LENGTHOF ImportDirectory_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+80h]
    mov DWORD PTR [ImportDirectory_VA_STORE],edi 
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset ImportDirectory_Size
    mov esi, LENGTHOF ImportDirectory_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+84h]
    mov DWORD PTR [ImportDirectory_SIZE_STORE],edi
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset ResourceDirectory_VA
    mov esi, LENGTHOF ResourceDirectory_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+88h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset ResourceDirectory_Size
    mov esi, LENGTHOF ResourceDirectory_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+8ch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset ExceptionDirectory_VA
    mov esi, LENGTHOF ExceptionDirectory_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+90h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset ExceptionDirectory_Size
    mov esi, LENGTHOF ExceptionDirectory_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+94h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset SecurityDirectory_VA
    mov esi, LENGTHOF SecurityDirectory_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+98h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset SecurityDirectory_Size
    mov esi, LENGTHOF SecurityDirectory_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+9ch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset BaseRelocationTable_VA
    mov esi, LENGTHOF BaseRelocationTable_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0a0h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset BaseRelocationTable_Size
    mov esi, LENGTHOF BaseRelocationTable_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0a4h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset DebugDirectory_VA
    mov esi, LENGTHOF DebugDirectory_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0a8h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset DebugDirectory_Size
    mov esi, LENGTHOF DebugDirectory_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0ach]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset ArchitectureSpecificData_VA
    mov esi, LENGTHOF ArchitectureSpecificData_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0b0h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset ArchitectureSpecificData_Size
    mov esi, LENGTHOF ArchitectureSpecificData_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0b4h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset RVAofGP_VA
    mov esi, LENGTHOF RVAofGP_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0b8h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset RVAofGP_Size
    mov esi, LENGTHOF RVAofGP_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0bch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset TLSDirectory_VA
    mov esi, LENGTHOF TLSDirectory_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0c0h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset TLSDirectory_Size
    mov esi, LENGTHOF TLSDirectory_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0c4h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset LoadConfigurationDirectory_VA
    mov esi, LENGTHOF LoadConfigurationDirectory_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0c8h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset LoadConfigurationDirectory_Size
    mov esi, LENGTHOF LoadConfigurationDirectory_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0cch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset BoundImportDirectoryinheaders_VA
    mov esi, LENGTHOF BoundImportDirectoryinheaders_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0d0h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset BoundImportDirectoryinheaders_Size
    mov esi, LENGTHOF BoundImportDirectoryinheaders_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0d4h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset ImportAddressTable_VA
    mov esi, LENGTHOF ImportAddressTable_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0d8h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset ImportAddressTable_Size
    mov esi, LENGTHOF ImportAddressTable_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0dch]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset DelayLoadImportDescriptors_VA
    mov esi, LENGTHOF DelayLoadImportDescriptors_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0e0h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset DelayLoadImportDescriptors_Size
    mov esi, LENGTHOF DelayLoadImportDescriptors_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0e4h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset COMRuntimedescriptor_VA
    mov esi, LENGTHOF COMRuntimedescriptor_VA
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0e8h]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov edi, offset COMRuntimedescriptor_Size
    mov esi, LENGTHOF COMRuntimedescriptor_Size
    call print_f
    mov eax,DWORD PTR[esp]
    mov edi,DWORD PTR [FullHeader+eax+0ech]
    xor esi,esi
    and edi,0ffffffffh
    call intohex
    mov edi ,offset HexString_rev
    mov esi,LENGTHOF HexString_rev
    call print_f

    mov eax,DWORD PTR [esp]
    mov esp,ebp
    pop ebp
    ret 

NT_HEADER_READ endp

DOS_READ PROC ; edi,esi
    push ebp
    mov ebp,esp 

    mov edi,offset DOSHEADER
    mov esi,LENGTHOF DOSHEADER
    call print_f
    mov edi, offset DOS_e_magic
    mov esi, LENGTHOF DOS_e_magic
    call print_f
    mov edi, DWORD PTR [FullHeader]  ; Load e_magic
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_cblp
    mov esi, LENGTHOF DOS_e_cblp
    call print_f
    mov edi, DWORD PTR [FullHeader + 2]  ; Load e_cblp
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_cp
    mov esi, LENGTHOF DOS_e_cp
    call print_f
    mov edi, DWORD PTR [FullHeader + 4]  ; Load e_cp
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_crlc
    mov esi, LENGTHOF DOS_e_crlc
    call print_f
    mov edi, DWORD PTR [FullHeader + 6]  ; Load e_crlc
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f
    

    mov edi, offset DOS_e_cparhdr
    mov esi, LENGTHOF DOS_e_cparhdr
    call print_f
    mov edi, DWORD PTR [FullHeader + 8]  ; Load e_cparhdr
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_minalloc
    mov esi, LENGTHOF DOS_e_minalloc
    call print_f
    mov edi, DWORD PTR [FullHeader + 0ah]  ; Load e_minalloc
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_maxalloc
    mov esi, LENGTHOF DOS_e_maxalloc
    call print_f
    mov edi, DWORD PTR [FullHeader + 0ch]  ; Load e_maxalloc
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_ss
    mov esi, LENGTHOF DOS_e_ss
    call print_f
    mov edi, DWORD PTR [FullHeader + 0eh]  ; Load e_ss
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_sp
    mov esi, LENGTHOF DOS_e_sp
    call print_f
    mov edi, DWORD PTR [FullHeader + 010h]  ; Load e_sp
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_csum
    mov esi, LENGTHOF DOS_e_csum
    call print_f
    mov edi, DWORD PTR [FullHeader + 012h]  ; Load e_csum
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_ip
    mov esi, LENGTHOF DOS_e_ip
    call print_f
    mov edi, DWORD PTR [FullHeader + 014h]  ; Load e_ip
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_cs
    mov esi, LENGTHOF DOS_e_cs
    call print_f
    mov edi, DWORD PTR [FullHeader + 016h]  ; Load e_cs
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_lfarlc
    mov esi, LENGTHOF DOS_e_lfarlc
    call print_f
    mov edi, DWORD PTR [FullHeader + 018h]  ; Load e_lfarlc
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_ovno
    mov esi, LENGTHOF DOS_e_ovno
    call print_f
    mov edi, DWORD PTR [FullHeader + 01ah]  ; Load e_ovno
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_res
    mov esi, LENGTHOF DOS_e_res
    call print_f
    mov edi, DWORD PTR [FullHeader + 01ch]  ; Load e_res (first word)
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_oemid
    mov esi, LENGTHOF DOS_e_oemid
    call print_f
    mov edi, DWORD PTR [FullHeader + 024h]  ; Load e_oemid
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_oeminfo
    mov esi, LENGTHOF DOS_e_oeminfo
    call print_f
    mov edi, DWORD PTR [FullHeader + 026h]  ; Load e_oeminfo
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_res2
    mov esi, LENGTHOF DOS_e_res2
    call print_f
    mov edi, DWORD PTR [FullHeader + 028h]  ; Load e_res2 (first word)
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi, offset DOS_e_lfanew
    mov esi, LENGTHOF DOS_e_lfanew
    call print_f
    mov edi, DWORD PTR [FullHeader + 03ch]  ; Load e_lfanew
    and edi,0ffffh
    xor esi, esi 
    call intohex 
    mov edi, offset HexString_rev
    mov esi, 10
    call print_f

    mov edi,offset endheader
    mov esi,LENGTHOF endheader
    call print_f
    mov esp,ebp
    pop ebp
    ret 
DOS_READ endp 


intohex PROC ; edi=value,esi = count
    push ebp 
    mov ebp,esp
    xor edx,edx
    mov DWORD PTR[HexString],0
    mov DWORD PTR[HexString_rev],0

    intohex_interanl:
        cmp esi,4
        je intohex_interanl_done
        mov eax,edi 
        mov ecx,esi
        shl ecx,3
        shr eax,cl  
        xor ecx,ecx
        mov cl,al 
        shr cl,4
        and al,0fh
        and cl,0fh

        cmp al,9
        jg character_first 
        add al,30h 
        mov BYTE PTR[HexString+edx],al 
        inc edx 

LABEL_CONTINUE:
        cmp cl,9 
        jg character_second 
        add cl,30h  
        mov BYTE PTR[HexString+edx],cl 
        inc edx 
        inc esi
        jmp intohex_interanl 

        character_first:
            sub al,10
            mov bl,'A' 
            add bl ,al 
            mov BYTE PTR [HexString+edx] ,bl 
            inc edx 
            jmp LABEL_CONTINUE
        
        character_second:
            sub cl,10 
            mov bl,'A'
            add bl,cl 
            mov BYTE PTR[HexString+edx],bl
            inc edx 
            inc esi 
            jmp intohex_interanl

    intohex_interanl_done: 
        xor ecx, ecx 
        mov edx, 7
        reverse:
            cmp ecx,8
            je reverse_done
            mov al,[HexString+ecx]
            mov BYTE PTR [HexString_rev+edx],al
            inc ecx
            dec edx
            jmp reverse
        reverse_done:
            ;mov BYTE PTR[HexString_rev+8],0ah
            mov esp,ebp
            pop ebp 
            ret       
intohex endp


exit PROC
    push 0 
    call ExitProcess
exit endp 

print_f PROC ;edi,esi
    push ebp 
    mov ebp,esp 
    push STD_OUTPUT_HANDLE
    call GetStdHandle
    mov hOutPut, eax

    push 0       ; lpNumberOfCharsWritten (not used in this case)
    push esi     ; nNumberOfCharsToWrite (length of "Hello, World!" including null terminator)
    push edi     ; lpBuffer (address of the message)
    push hOutPut ; hConsoleOutput (handle to the console)
    call WriteConsole
    mov esp,ebp
    pop ebp 
    ret 
print_f endp

read PROC
    push ebp
    mov ebp, esp

    push STD_INPUT_HANDLE
    call GetStdHandle
    mov hOutPut, eax

    push esi  ; Push number of bytes to read (esi)
    push edi  ; Push address of buffer (edi)
    push hOutPut  ; Push handle to console output (hOutPut)
    call ReadConsole
    xor esi,esi 
readcheck:
    mov al,BYTE PTR[edi+esi ]
    cmp al,10
    je readdone 
    inc esi 
    jmp readcheck
readdone:
    mov BYTE PTR [edi+esi-1],0

    mov esp, ebp
    pop ebp
    ret
read ENDP


itoa PROC
    push ebp 
    mov esp,ebp
    sub esp,040h
    mov ebx, 10         ; Set up the divisor for division (base 10)
    mov ebx, 10         ; Set up the base for converting to ASCII

    add edi, 10         ; Move the buffer pointer to the end to leave space for null terminator

    mov byte ptr [edi], 0   ; Null-terminate the string

convert_loop:
    dec edi             ; Move back in the buffer
    xor edx, edx        ; Clear the remainder
    div ebx             ; Divide the number by 10
    add dl, '0'         ; Convert the remainder to ASCII
    mov [edi], dl       ; Store the digit in the buffer
    test eax, eax       ; Check if quotient is zero
    jnz convert_loop    ; If not zero, continue the conversion
    mov esp,ebp
    pop ebp 
    ret
itoa ENDP

readfile PROC
    push ebp
    mov ebp,esp 

    push 0
    push FILE_ATTRIBUTE_NORMAL
    push OPEN_EXISTING
    push 0
    push FILE_SHARE_READ
    push GENERIC_READ
    push offset filepath
    call CreateFile
    mov hFile,eax 

    push 0 
    push offset FullHeader_size
    push 1000h
    push offset FullHeader
    push hFile
    call ReadFile
    mov esp,ebp 
    pop ebp 
    ret
readfile endp 

main PROC 
    push ebp 
    mov ebp,esp



    mov edi,offset filepath
    mov esi,100 
    call read


    call readfile

    call DOS_READ
    mov eax,DWORD PTR[FullHeader+03ch]
    call NT_HEADER_READ
    mov edx,DWORD PTR [FullHeader+eax+06h]
    and edx,0ffffh
    mov ebx,DWORD PTR [FullHeader+eax+014h]
    and ebx,0ffffh
    add eax,ebx 
    add eax,16h 
    call SECTION_HEADER_READ
    
    mov edi ,DWORD PTR [ImportDirectory_VA_STORE]
    sub edi,DWORD PTR [PSECT_VIRTUALADDRESS]
    mov eax,DWORD PTR [PSECT_PointerToRawData]
    add eax,edi 

    call IMPORT_DIRECTORY_READ
    call exit 
    pop ebp 
    ret
main endp 
end main 











