push    ebp
mov     ebp, esp
sub     esp, 11Ch 
mov     byte ptr [ebp-0Ch], 0
xor     eax, eax
mov     [ebp-0Bh], eax
mov     [ebp-7], al
mov     ecx, 1
imul    edx, ecx, 0
mov     byte ptr [ebp+edx-0Ch], 73h ; 's'
mov     eax, 1
shl     eax, 0
mov     byte ptr [ebp+eax-0Ch], 75h ; 'u'
mov     ecx, 1
shl     ecx, 1
mov     byte ptr [ebp+ecx-0Ch], 73h ; 's'
mov     edx, 1
imul    eax, edx, 3
mov     byte ptr [ebp+eax-0Ch], 61h ; 'a'
mov     ecx, 1
shl     ecx, 2
mov     byte ptr [ebp+ecx-0Ch], 6Eh ; 'n'
mov     edx, 1
imul    eax, edx, 5
mov     byte ptr [ebp+eax-0Ch], 0 
mov     ecx, [ebp+10h]
mov     edx, [ecx+4]
mov     [ebp-18h], edx
mov     eax, [ebp+10h]
mov     ecx, [eax+8]
mov     [ebp-1Ch], ecx
lea     edx, [ebp-11Ch]
push    edx
lea     eax, [ebp-0Ch]
push    eax       # buffer = "susan\x00"
call    dword ptr [ebp-18h]
add     esp, 8
mov     ecx, 1
imul    edx, ecx, 0
mov     eax, [ebp+8]
mov     cl, [eax+edx]
mov     [ebp-14h], cl
mov     edx, 1
shl     edx, 0
mov     eax, [ebp+8] # passwd
mov     cl, [eax+edx]
mov     [ebp-13h], cl
mov     edx, 1
shl     edx, 1
mov     eax, [ebp+8]
mov     cl, [eax+edx]
mov     [ebp-12h], cl
mov     edx, 1
imul    eax, edx, 3
mov     ecx, [ebp+8]
mov     dl, [ecx+eax]
mov     [ebp-11h], dl
mov     byte ptr [ebp-10h], 0
mov     eax, [ebp+0Ch]
push    eax
lea     ecx, [ebp-14h]
push    ecx
lea     edx, [ebp-11Ch]
push    edx
call    dword ptr [ebp-1Ch]
add     esp, 0Ch
mov     [ebp-1], al
mov     al, [ebp-1]
mov     esp, ebp
pop     ebp
retn





int __cdecl sub_1670000(char *a1, int a2, int a3)
{
  char v4[256]; // [esp+0h] [ebp-11Ch] BYREF
  int (__cdecl *v5)(char *, char *, int); // [esp+100h] [ebp-1Ch]
  void (__cdecl *v6)(char *, char *); // [esp+104h] [ebp-18h]
  char v7[8]; // [esp+108h] [ebp-14h] BYREF
  char v8[11]; // [esp+110h] [ebp-Ch] BYREF

  strcpy(v8, "susan");
  v6 = *(void (__cdecl **)(char *, char *))(a3 + 4);
  v5 = *(int (__cdecl **)(char *, char *, int))(a3 + 8);
  v6(v8, v4);
  v7[0] = *a1;
  v7[1] = a1[1];
  v7[2] = a1[2];
  v7[3] = a1[3];
  v7[4] = 0;
  return v5(v4, v7, a2);
}




int __cdecl sub_EC0000(const char *a1, int a2)
{
  signed int v2; // kr00_4
  int v4; // [esp+Ch] [ebp-14h]
  int i; // [esp+10h] [ebp-10h]
  int j; // [esp+18h] [ebp-8h]
  char v7; // [esp+1Eh] [ebp-2h]

  v2 = strlen(a1);
  v4 = 0;
  for ( i = 0; i < 256; ++i )
    *(_BYTE *)(i + a2) = i;
  for ( j = 0; j < 256; ++j )
  {
    v4 = (a1[j % v2] + v4 + *(unsigned __int8 *)(j + a2)) % 256;
    v7 = *(_BYTE *)(j + a2);
    *(_BYTE *)(j + a2) = *(_BYTE *)(v4 + a2);
    *(_BYTE *)(v4 + a2) = v7;
  }
  return 0;
}


char __cdecl sub_1070000(int a1, const char *a2, int a3)
{
  unsigned int v4; // [esp+4h] [ebp-20h]
  unsigned int v5; // [esp+10h] [ebp-14h]
  int v6; // [esp+14h] [ebp-10h]
  int v7; // [esp+1Ch] [ebp-8h]
  char v8; // [esp+22h] [ebp-2h]

  v7 = 0;
  v6 = 0;
  v5 = 0;
  v4 = strlen(a2);
  while ( v5 < v4 )
  {
    v7 = (v7 + 1) % 256;
    v6 = (v6 + *(unsigned __int8 *)(v7 + a1)) % 256;
    v8 = *(_BYTE *)(v7 + a1);
    *(_BYTE *)(v7 + a1) = *(_BYTE *)(v6 + a1);
    *(_BYTE *)(v6 + a1) = v8;
    if ( *(unsigned __int8 *)(v5 + a3) != (*(unsigned __int8 *)(a1
                                                              + (*(unsigned __int8 *)(v6 + a1)
                                                               + *(unsigned __int8 *)(v7 + a1))
                                                              % 256) ^ a2[v5]) )
      return 0;
    ++v5;
  }
  return 1;
}


dword [ebp-18h] :
    push    ebp
    mov     ebp, esp
    sub     esp, 20h
    mov     eax, [ebp+8] # susan
    mov     [ebp-0Ch], eax
    mov     ecx, [ebp-0Ch]
    add     ecx, 1
    mov     [ebp-18h], ecx #usan
    loc_12C0015:                            
    mov     edx, [ebp-0Ch]
    mov     al, [edx]
    mov     [ebp-1], al
    add     dword ptr [ebp-0Ch], 1 #usan
    cmp     byte ptr [ebp-1], 0
    jnz     short loc_12C0015
    mov     ecx, [ebp-0Ch]
    sub     ecx, [ebp-18h]
    mov     [ebp-1Ch], ecx
    mov     edx, [ebp-1Ch]
    mov     [ebp-20h], edx
    mov     dword ptr [ebp-14h], 0
    mov     dword ptr [ebp-10h], 0
    jmp     short loc_12C004F

    loc_12C0046:                           
    mov     eax, [ebp-10h]
    add     eax, 1
    mov     [ebp-10h], eax
    loc_12C004F:                           
    cmp     dword ptr [ebp-10h], 100h
    jge     short loc_12C0065
    mov     ecx, [ebp+0Ch]
    add     ecx, [ebp-10h]
    mov     dl, [ebp-10h]
    mov     [ecx], dl
    jmp     short loc_12C0046

    loc_12C0065:                            
    mov     dword ptr [ebp-8], 0
    jmp     short loc_12C0077

    loc_12C006E:                           
    mov     eax, [ebp-8]
    add     eax, 1
    mov     [ebp-8], eax
    loc_12C0077:                            
    cmp     dword ptr [ebp-8], 100h
    jge     short loc_12C00D7
    mov     ecx, [ebp+0Ch]
    add     ecx, [ebp-8]
    movzx   ecx, byte ptr [ecx]
    add     ecx, [ebp-14h]
    mov     eax, [ebp-8]
    cdq
    idiv    dword ptr [ebp-20h]
    mov     eax, [ebp+8]
    movsx   edx, byte ptr [eax+edx]
    add     ecx, edx
    and     ecx, 800000FFh
    jns     short loc_12C00AC
    dec     ecx
    or      ecx, 0FFFFFF00h
    inc     ecx
    loc_12C00AC:                            
    mov     [ebp-14h], ecx
    mov     eax, [ebp+0Ch]
    add     eax, [ebp-8]
    mov     cl, [eax]
    mov     [ebp-2], cl
    mov     edx, [ebp+0Ch]
    add     edx, [ebp-8]
    mov     eax, [ebp+0Ch]
    add     eax, [ebp-14h]
    mov     cl, [eax]
    mov     [edx], cl
    mov     edx, [ebp+0Ch]
    add     edx, [ebp-14h]
    mov     al, [ebp-2]
    mov     [edx], al
    jmp     short loc_12C006E

    loc_12C00D7:                           
    xor     eax, eax
    mov     esp, ebp
    pop     ebp
    retn





dword [ebp - 01Ch]:
    push    ebp
    mov     ebp, esp
    sub     esp, 24h
    mov     dword ptr [ebp-8], 0
    mov     dword ptr [ebp-10h], 0
    mov     dword ptr [ebp-14h], 0
    mov     eax, [ebp+0Ch]
    mov     [ebp-0Ch], eax
    mov     ecx, [ebp-0Ch]
    add     ecx, 1
    mov     [ebp-18h], ecx
    loc_12D002A:                            
    mov     edx, [ebp-0Ch]
    mov     al, [edx]
    mov     [ebp-1], al
    add     dword ptr [ebp-0Ch], 1
    cmp     byte ptr [ebp-1], 0
    jnz     short loc_12D002A
    mov     ecx, [ebp-0Ch]
    sub     ecx, [ebp-18h]
    mov     [ebp-1Ch], ecx
    mov     edx, [ebp-1Ch]
    mov     [ebp-20h], edx
    jmp     short loc_12D0056

    loc_12D004D:                            
    mov     eax, [ebp-14h]
    add     eax, 1
    mov     [ebp-14h], eax
    loc_12D0056:                            
    mov     ecx, [ebp-14h]
    cmp     ecx, [ebp-20h]
    jnb     loc_12D0110
    mov     edx, [ebp-8]
    add     edx, 1
    and     edx, 800000FFh
    jns     short loc_12D0078
    dec     edx
    or      edx, 0FFFFFF00h
    inc     edx
    loc_12D0078:                            
    mov     [ebp-8], edx
    mov     eax, [ebp+8]
    add     eax, [ebp-8]
    movzx   ecx, byte ptr [eax]
    add     ecx, [ebp-10h]
    and     ecx, 800000FFh
    jns     short loc_12D0097
    dec     ecx
    or      ecx, 0FFFFFF00h
    inc     ecx
    loc_12D0097:                            
    mov     [ebp-10h], ecx
    mov     edx, [ebp+8]
    add     edx, [ebp-8]
    mov     al, [edx]
    mov     [ebp-2], al
    mov     ecx, [ebp+8]
    add     ecx, [ebp-8]
    mov     edx, [ebp+8]
    add     edx, [ebp-10h]
    mov     al, [edx]
    mov     [ecx], al
    mov     ecx, [ebp+8]
    add     ecx, [ebp-10h]
    mov     dl, [ebp-2]
    mov     [ecx], dl
    mov     eax, [ebp+8]
    add     eax, [ebp-8]
    movzx   ecx, byte ptr [eax]
    mov     edx, [ebp+8]
    add     edx, [ebp-10h]
    movzx   eax, byte ptr [edx]
    add     ecx, eax
    and     ecx, 800000FFh
    jns     short loc_12D00E4
    dec     ecx
    or      ecx, 0FFFFFF00h
    inc     ecx
    loc_12D00E4:                            
    mov     edx, [ebp+8]
    movzx   eax, byte ptr [edx+ecx]
    mov     [ebp-24h], eax
    mov     ecx, [ebp+10h]
    add     ecx, [ebp-14h]
    movzx   edx, byte ptr [ecx]
    mov     eax, [ebp+0Ch]
    add     eax, [ebp-14h]
    movsx   ecx, byte ptr [eax]
    xor     ecx, [ebp-24h]
    cmp     edx, ecx
    jz      short loc_12D010B
    xor     al, al
    jmp     short loc_12D0112

    loc_12D010B:                            
    jmp     loc_12D004D

    loc_12D0110:                            
    mov     al, 1
    loc_12D0112:                           
    mov     esp, ebp
    pop     ebp
    retn