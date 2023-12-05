mystring = "bdnpQai|nufimnug`n{Fafhr"
cypher = [*mystring]
print(cypher)
key = [4 ,8 ,15 , 0x17,0x2a]

flag = ""
for i in range(0,25-2,2):
    flag += chr(ord(cypher[i]) ^ key[i%5])
    flag += chr(ord(cypher[i+1]) ^ key[(i+1)%5])
flag += "}"
print(flag)
