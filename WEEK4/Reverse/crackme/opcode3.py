push    ebp
mov     ebp, esp
sub     esp, 64h
mov     dword ptr [ebp-0Ch], 0 
mov     dword ptr [ebp-10h], 0
mov     dword ptr [ebp-14h], 3
mov     dword ptr [ebp-1Ch], 0
mov     dword ptr [ebp-20h], 0
mov     eax, 1
imul    ecx, eax, 0
mov     byte ptr [ebp+ecx-64h], 41h ; 'A'
mov     edx, 1
shl     edx, 0
mov     byte ptr [ebp+edx-64h], 42h ; 'B'
mov     eax, 1
shl     eax, 1
mov     byte ptr [ebp+eax-64h], 44h ; 'D'
mov     ecx, 1
imul    edx, ecx, 3
mov     byte ptr [ebp+edx-64h], 43h ; 'C'
mov     eax, 1
shl     eax, 2
mov     byte ptr [ebp+eax-64h], 45h ; 'E'
mov     ecx, 1
imul    edx, ecx, 5
mov     byte ptr [ebp+edx-64h], 48h ; 'H'
mov     eax, 1
imul    ecx, eax, 6
mov     byte ptr [ebp+ecx-64h], 47h ; 'G'
mov     edx, 1
imul    eax, edx, 7
mov     byte ptr [ebp+eax-64h], 46h ; 'F'
mov     ecx, 1
shl     ecx, 3
mov     byte ptr [ebp+ecx-64h], 49h ; 'I'
mov     edx, 1
imul    eax, edx, 9
mov     byte ptr [ebp+eax-64h], 4Ah ; 'J'
mov     ecx, 1
imul    edx, ecx, 0Ah
mov     byte ptr [ebp+edx-64h], 4Bh ; 'K'
mov     eax, 1
imul    ecx, eax, 0Bh
mov     byte ptr [ebp+ecx-64h], 4Ch ; 'L'
mov     edx, 1
imul    eax, edx, 0Ch
mov     byte ptr [ebp+eax-64h], 55h ; 'U'
mov     ecx, 1
imul    edx, ecx, 0Dh
mov     byte ptr [ebp+edx-64h], 4Eh ; 'N'
mov     eax, 1
imul    ecx, eax, 0Eh
mov     byte ptr [ebp+ecx-64h], 4Fh ; 'O'
mov     edx, 1
imul    eax, edx, 0Fh
mov     byte ptr [ebp+eax-64h], 50h ; 'P'
mov     ecx, 1
shl     ecx, 4
mov     byte ptr [ebp+ecx-64h], 59h ; 'Y'
mov     edx, 1
imul    eax, edx, 11h
mov     byte ptr [ebp+eax-64h], 52h ; 'R'
mov     ecx, 1
imul    edx, ecx, 12h
mov     byte ptr [ebp+edx-64h], 54h ; 'T'
mov     eax, 1
imul    ecx, eax, 13h
mov     byte ptr [ebp+ecx-64h], 53h ; 'S'
mov     edx, 1
imul    eax, edx, 14h
mov     byte ptr [ebp+eax-64h], 4Dh ; 'M'
mov     ecx, 1
imul    edx, ecx, 15h
mov     byte ptr [ebp+edx-64h], 56h ; 'V'
mov     eax, 1
imul    ecx, eax, 16h
mov     byte ptr [ebp+ecx-64h], 57h ; 'W'
mov     edx, 1
imul    eax, edx, 17h
mov     byte ptr [ebp+eax-64h], 58h ; 'X'
mov     ecx, 1
imul    edx, ecx, 18h
mov     byte ptr [ebp+edx-64h], 51h ; 'Q'
mov     eax, 1
imul    ecx, eax, 19h
mov     byte ptr [ebp+ecx-64h], 5Ah ; 'Z'
mov     edx, 1
imul    eax, edx, 1Ah
mov     byte ptr [ebp+eax-64h], 61h ; 'a'
mov     ecx, 1
imul    edx, ecx, 1Bh
mov     byte ptr [ebp+edx-64h], 6Ah ; 'j'
mov     eax, 1
imul    ecx, eax, 1Ch
mov     byte ptr [ebp+ecx-64h], 63h ; 'c'
mov     edx, 1
imul    eax, edx, 1Dh
mov     byte ptr [ebp+eax-64h], 64h ; 'd'
mov     ecx, 1
imul    edx, ecx, 1Eh
mov     byte ptr [ebp+edx-64h], 65h ; 'e'
mov     eax, 1
imul    ecx, eax, 1Fh
mov     byte ptr [ebp+ecx-64h], 66h ; 'f'
mov     edx, 1
shl     edx, 5
mov     byte ptr [ebp+edx-64h], 6Fh ; 'o'
mov     eax, 1
imul    ecx, eax, 21h ; '!'
mov     byte ptr [ebp+ecx-64h], 68h ; 'h'
mov     edx, 1
imul    eax, edx, 22h ; '"'
mov     byte ptr [ebp+eax-64h], 69h ; 'i'
mov     ecx, 1
imul    edx, ecx, 23h ; '#'
mov     byte ptr [ebp+edx-64h], 62h ; 'b'
mov     eax, 1
imul    ecx, eax, 24h ; '$'
mov     byte ptr [ebp+ecx-64h], 6Bh ; 'k'
mov     edx, 1
imul    eax, edx, 25h ; '%'
mov     byte ptr [ebp+eax-64h], 6Dh ; 'm'
mov     ecx, 1
imul    edx, ecx, 26h ; '&'
mov     byte ptr [ebp+edx-64h], 6Ch ; 'l'
mov     eax, 1
imul    ecx, eax, 27h 
mov     byte ptr [ebp+ecx-64h], 6Eh ; 'n'
mov     edx, 1
imul    eax, edx, 28h ; '('
mov     byte ptr [ebp+eax-64h], 67h ; 'g'
mov     ecx, 1
imul    edx, ecx, 29h ; ')'
mov     byte ptr [ebp+edx-64h], 70h ; 'p'
mov     eax, 1
imul    ecx, eax, 2Ah ; '*'
mov     byte ptr [ebp+ecx-64h], 71h ; 'q'
mov     edx, 1
imul    eax, edx, 2Bh ; '+'
mov     byte ptr [ebp+eax-64h], 72h ; 'r'
mov     ecx, 1
imul    edx, ecx, 2Ch ; ','
mov     byte ptr [ebp+edx-64h], 73h ; 's'
mov     eax, 1
imul    ecx, eax, 2Dh ; '-'
mov     byte ptr [ebp+ecx-64h], 74h ; 't'
mov     edx, 1
imul    eax, edx, 2Eh ; '.'
mov     byte ptr [ebp+eax-64h], 75h ; 'u'
mov     ecx, 1
imul    edx, ecx, 2Fh ; '/'
mov     byte ptr [ebp+edx-64h], 76h ; 'v'
mov     eax, 1
imul    ecx, eax, 30h ; '0'
mov     byte ptr [ebp+ecx-64h], 34h ; '4'
mov     edx, 1
imul    eax, edx, 31h ; '1'
mov     byte ptr [ebp+eax-64h], 78h ; 'x'
mov     ecx, 1
imul    edx, ecx, 32h ; '2'
mov     byte ptr [ebp+edx-64h], 7Ah ; 'z'
mov     eax, 1
imul    ecx, eax, 33h ; '3'
mov     byte ptr [ebp+ecx-64h], 79h ; 'y'
mov     edx, 1
imul    eax, edx, 34h ; '4'
mov     byte ptr [ebp+eax-64h], 38h ; '8'
mov     ecx, 1
imul    edx, ecx, 35h ; '5'
mov     byte ptr [ebp+edx-64h], 31h ; '1'
mov     eax, 1
imul    ecx, eax, 36h ; '6'
mov     byte ptr [ebp+ecx-64h], 32h ; '2'
mov     edx, 1
imul    eax, edx, 37h ; '7'
mov     byte ptr [ebp+eax-64h], 33h ; '3'
mov     ecx, 1
imul    edx, ecx, 38h ; '8'
mov     byte ptr [ebp+edx-64h], 77h ; 'w'
mov     eax, 1
imul    ecx, eax, 39h ; '9'
mov     byte ptr [ebp+ecx-64h], 35h ; '5'
mov     edx, 1
imul    eax, edx, 3Ah ; ':'
mov     byte ptr [ebp+eax-64h], 36h ; '6'
mov     ecx, 1
imul    edx, ecx, 3Bh ; ';'
mov     byte ptr [ebp+edx-64h], 37h ; '7'
mov     eax, 1
imul    ecx, eax, 3Ch ; '<'
mov     byte ptr [ebp+ecx-64h], 30h ; '0'
mov     edx, 1
imul    eax, edx, 3Dh ; '='
mov     byte ptr [ebp+eax-64h], 39h ; '9'
mov     ecx, 1
imul    edx, ecx, 3Eh ; '>'
mov     byte ptr [ebp+edx-64h], 2Bh ; '+'
mov     eax, 1
imul    ecx, eax, 3Fh ; '?'
mov     byte ptr [ebp+ecx-64h], 2Fh ; '/'
mov     edx, 1
imul    eax, edx, 3Fh ; '?'
mov     byte ptr [ebp+eax-64h], 30h ; '0'
loc_A30375:                             
    mov     ecx, [ebp-14h] # [ebp - 0x14] = 3  2  1  0
    mov     [ebp-18h], ecx
    mov     edx, [ebp-14h]
    sub     edx, 1
    mov     [ebp-14h], edx
    cmp     dword ptr [ebp-18h], 0
    jz      loc_A30516
    mov     eax, [ebp-0Ch] # [ebp - 0xc] = 0 1 2 3
    mov     ecx, [ebp+8] # [ebp + 8] == passwd  
    mov     dl, [ecx]
    mov     [ebp+eax-4], dl
    mov     eax, [ebp-0Ch]
    add     eax, 1
    mov     [ebp-0Ch], eax
    mov     ecx, [ebp+8]
    add     ecx, 1
    mov     [ebp+8], ecx
    cmp     dword ptr [ebp-0Ch], 3
    jnz     loc_A30511 # jmp     loc_A30375
    mov     edx, 1
    imul    eax, edx, 0
    movzx   ecx, byte ptr [ebp+eax-4]
    and     ecx, 0FCh
    sar     ecx, 2
    mov     edx, 1
    imul    eax, edx, 0
    mov     [ebp+eax-8], cl
    mov     ecx, 1
    imul    edx, ecx, 0
    movzx   eax, byte ptr [ebp+edx-8]
    movsx   ecx, byte ptr [ebp+eax-64h]
    mov     edx, 1
    imul    eax, edx, 0
    mov     edx, [ebp+0Ch]
    movzx   eax, byte ptr [edx+eax]
    cmp     ecx, eax
    jz      short loc_A30404
    xor     al, al
    jmp     loc_A30691

loc_A30404:                            
    mov     ecx, 1
    imul    edx, ecx, 0
    movzx   eax, byte ptr [ebp+edx-4]
    and     eax, 3
    shl     eax, 4
    mov     ecx, 1
    shl     ecx, 0
    movzx   edx, byte ptr [ebp+ecx-4]
    and     edx, 0F0h
    sar     edx, 4
    add     eax, edx
    mov     ecx, 1
    shl     ecx, 0
    mov     [ebp+ecx-8], al
    mov     edx, 1
    shl     edx, 0
    movzx   eax, byte ptr [ebp+edx-8]
    movsx   ecx, byte ptr [ebp+eax-64h]
    mov     edx, 1
    shl     edx, 0
    mov     eax, [ebp+0Ch]
    movzx   edx, byte ptr [eax+edx]
    cmp     ecx, edx
    jz      short loc_A30467
    xor     al, al
    jmp     loc_A30691

loc_A30467:                             
    mov     eax, 1
    shl     eax, 0
    movzx   ecx, byte ptr [ebp+eax-4]
    and     ecx, 0Fh
    mov     edx, 1
    shl     edx, 1
    movzx   eax, byte ptr [ebp+edx-4]
    and     eax, 0C0h
    sar     eax, 6
    lea     ecx, [eax+ecx*4]
    mov     edx, 1
    shl     edx, 1
    mov     [ebp+edx-8], cl
    mov     eax, 1
    shl     eax, 1
    movzx   ecx, byte ptr [ebp+eax-8]
    movsx   edx, byte ptr [ebp+ecx-64h]
    mov     eax, 1
    shl     eax, 1
    mov     ecx, [ebp+0Ch]
    movzx   eax, byte ptr [ecx+eax]
    cmp     edx, eax
    jz      short loc_A304C3
    xor     al, al
    jmp     loc_A30691
loc_A304C3:                             
    mov     ecx, 1
    shl     ecx, 1
    movzx   edx, byte ptr [ebp+ecx-4]
    and     edx, 3Fh
    mov     eax, 1
    imul    ecx, eax, 3
    mov     [ebp+ecx-8], dl
    mov     edx, 1
    imul    eax, edx, 3
    movzx   ecx, byte ptr [ebp+eax-8]
    movsx   edx, byte ptr [ebp+ecx-64h]
    mov     eax, 1
    imul    ecx, eax, 3
    mov     eax, [ebp+0Ch]
    movzx   ecx, byte ptr [eax+ecx]
    cmp     edx, ecx
    jz      short loc_A3050A
    xor     al, al
    jmp     loc_A30691

loc_A3050A:                            
    mov     dword ptr [ebp-0Ch], 0
loc_A30511:                             
    jmp     loc_A30375

loc_A30516:                             
    cmp     dword ptr [ebp-0Ch], 0
    jle     loc_A3068F
    mov     edx, [ebp-0Ch]
    mov     [ebp-10h], edx
    jmp     short loc_A30531

loc_A30528:                             
    mov     eax, [ebp-10h]
    add     eax, 1
    mov     [ebp-10h], eax
    loc_A30531:                             
    cmp     dword ptr [ebp-10h], 3
    jge     short loc_A30541
    mov     ecx, [ebp-10h]
    mov     byte ptr [ebp+ecx-4], 0
    jmp     short loc_A30528

loc_A30541:                            
    mov     edx, 1
    imul    eax, edx, 0
    movzx   ecx, byte ptr [ebp+eax-4]
    and     ecx, 0FCh
    sar     ecx, 2
    mov     edx, 1
    imul    eax, edx, 0
    mov     [ebp+eax-8], cl
    mov     ecx, 1
    imul    edx, ecx, 0
    movzx   eax, byte ptr [ebp+edx-8]
    movsx   ecx, byte ptr [ebp+eax-64h]
    mov     edx, 1
    imul    eax, edx, 0
    mov     edx, [ebp+0Ch]
    movzx   eax, byte ptr [edx+eax]
    cmp     ecx, eax
    jz      short loc_A3058F
    xor     al, al
    jmp     loc_A30691

loc_A3058F:                             
    mov     ecx, 1
    imul    edx, ecx, 0
    movzx   eax, byte ptr [ebp+edx-4]
    and     eax, 3
    shl     eax, 4
    mov     ecx, 1
    shl     ecx, 0
    movzx   edx, byte ptr [ebp+ecx-4]
    and     edx, 0F0h
    sar     edx, 4
    add     eax, edx
    mov     ecx, 1
    shl     ecx, 0
    mov     [ebp+ecx-8], al
    mov     edx, 1
    shl     edx, 0
    movzx   eax, byte ptr [ebp+edx-8]
    movsx   ecx, byte ptr [ebp+eax-64h]
    mov     edx, 1
    shl     edx, 0
    mov     eax, [ebp+0Ch]
    movzx   edx, byte ptr [eax+edx]
    cmp     ecx, edx
    jz      short loc_A305F2
    xor     al, al
    jmp     loc_A30691

loc_A305F2:                            
    mov     eax, 1
    shl     eax, 0
    movzx   ecx, byte ptr [ebp+eax-4]
    and     ecx, 0Fh
    mov     edx, 1
    shl     edx, 1
    movzx   eax, byte ptr [ebp+edx-4]
    and     eax, 0C0h
    sar     eax, 6
    lea     ecx, [eax+ecx*4]
    mov     edx, 1
    shl     edx, 1
    mov     [ebp+edx-8], cl
    mov     eax, 1
    shl     eax, 1
    movzx   ecx, byte ptr [ebp+eax-8]
    movsx   edx, byte ptr [ebp+ecx-64h]
    mov     eax, 1
    shl     eax, 1
    mov     ecx, [ebp+0Ch]
    movzx   eax, byte ptr [ecx+eax]
    cmp     edx, eax
    jz      short loc_A3064B
    xor     al, al
    jmp     short loc_A30691

loc_A3064B:                             
    mov     ecx, 1
    shl     ecx, 1
    movzx   edx, byte ptr [ebp+ecx-4]
    and     edx, 3Fh
    mov     eax, 1
    imul    ecx, eax, 3
    mov     [ebp+ecx-8], dl
    mov     edx, 1
    imul    eax, edx, 3
    movzx   ecx, byte ptr [ebp+eax-8]
    movsx   edx, byte ptr [ebp+ecx-64h]
    mov     eax, 1
    imul    ecx, eax, 3
    mov     eax, [ebp+0Ch]
    movzx   ecx, byte ptr [eax+ecx]
    cmp     edx, ecx
    jz      short loc_A3068F
    xor     al, al
    jmp     short loc_A30691

loc_A3068F:                             
                                        
    mov     al, 1
loc_A30691:                    

mov     esp, ebp
pop     ebp
retn





bool __cdecl sub_15E0000(char *passwd, unsigned __int8 *cypher)
{
  char v3[68]; // [esp+0h] [ebp-64h] BYREF
  int v4; // [esp+44h] [ebp-20h]
  int v5; // [esp+48h] [ebp-1Ch]
  int index; // [esp+50h] [ebp-14h]
  int i; // [esp+54h] [ebp-10h]
  int v9; // [esp+58h] [ebp-Ch]
  unsigned __int8 v10; // [esp+5Ch] [ebp-8h]
  unsigned __int8 v11; // [esp+5Dh] [ebp-7h]
  unsigned __int8 v12; // [esp+5Eh] [ebp-6h]
  char v13; // [esp+5Fh] [ebp-5h]
  char first; // [esp+60h] [ebp-4h]
  char second; // [esp+61h] [ebp-3h]
  char third; // [esp+62h] [ebp-2h]

  v9 = 0;
  i = 0;
  index = 3;
  v5 = 0;
  v4 = 0;
  qmemcpy(v3, "ABDCEHGFIJKLUNOPYRTSMVWXQZajcdefohibkmlngpqrstuv4xzy8123w56709+0", 64);
  while ( index-- )
  {
    *(&first + v9++) = *passwd++;
    if ( v9 == 3 )
    {
      v10 = (first & 0xFC) >> 2;
      if ( v3[v10] != *cypher )
        return 0;
      v11 = ((second & 0xF0) >> 4) + 16 * (first & 3);
      if ( v3[v11] != cypher[1] )
        return 0;
      v12 = ((third & 0xC0) >> 6) + 4 * (second & 0xF);
      if ( v3[v12] != cypher[2] )
        return 0;
      v13 = third & 0x3F;
      if ( v3[third & 0x3F] != cypher[3] )
        return 0;
      v9 = 0;
    }
  }
  if ( v9 <= 0 )
    return 1;
  for ( i = v9; i < 3; ++i )
    *(&first + i) = 0;
  v10 = (first & 0xFC) >> 2;
  if ( v3[v10] != *cypher )
    return 0;
  v11 = ((second & 0xF0) >> 4) + 16 * (first & 3);
  if ( v3[v11] != cypher[1] )
    return 0;
  v12 = ((third & 0xC0) >> 6) + 4 * (second & 0xF);
  if ( v3[v12] != cypher[2] )
    return 0;
  v13 = third & 0x3F;
  return v3[third & 0x3F] == cypher[3];
}

