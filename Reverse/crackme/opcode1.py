bool __cdecl sub_B70000(char *passwd, unsigned __int8 *cypher)
{
  char v2; // cl

  v2 = *passwd % 2;
  if ( !v2 && (*passwd ^ 0x20) == *a2 )
    return 1;
  return v2 == 1 && (*passwd ^ 0x52) == *a2;
}

for i in data1:
    if( (i[2] ^ 0x20) % 2 == 0 )
        payload[i[1]] = i[2] ^ 0x20 
    else:
        payload[i[1]] = i[2] ^ 0x52
