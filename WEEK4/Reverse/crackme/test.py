rbp3 = [
    65, 66, 68, 67, 69, 72, 71, 70, 73, 74, 75, 76, 85, 
    78, 79, 80, 89, 82, 84, 83, 77, 86, 87, 88, 81, 90, 
    97, 106, 99, 100, 101, 102, 111, 104, 105, 98, 107, 
    109, 108, 110, 103, 112, 113, 114, 115, 116, 117, 118, 
    52, 120, 122, 121, 56, 49, 50, 51, 119, 53, 54, 55, 48, 
    57, 43, 48]


def decrypt3(index,target):
    for i in range(256):
        if(rbp3[(i & 0xfc) >> 2 ] == (target & 0xff) ):
            for j in range(256):
                if(  rbp3[(((j & 0xf0) >> 4) + ((i & 3) * 16)) & 0xff ] == ((target >> 8) & 0xff)):
                    for k in range(256):
                        if( rbp3[((j & 0xf)*4  +  ((k & 0xC0) >> 6)) & 0xff] == (target >> 16 ) & 0xff ):
                            if( rbp3[k & 0x3f] ==((target >> 24) & 0xff)):
                                g = rbp3[k & 0x3f]
                                payload[index] = i 
                                payload[index + 1] = j 
                                payload[index + 2] = k 
                                print("data3:",hex(i),hex(j),hex(k),hex(target))                 
                                return 1




payload = [0,0,0,0]
decrypt3(0,0x6f593363)
