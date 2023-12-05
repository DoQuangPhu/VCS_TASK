f = open("inside-the-mind-of-a-hacker-memory.bmp", "rb") 
data = f.read()
imagesdata = data[54::]
sinature  =  19778
Reserved =  56
DataOffset =  54
Size =  40
Width =  938
Height =  580
Planes =  1572865
BitCount =  0
Compression =  3959422976
ImageSize =  185794584
XPixelsPerM =  185794560
YPixelsPerM =  0
ColorUsed =  0
ColorImportant =  0
Red =  268500992
Green =  7
Blue =  0
Reserved =  16
order = []
v19 = 0 
for j in  range(312 - 72) :
    v21 = v19 + j
    order.append(imagesdata[v21 * 2 + v21])
message = ""
for i in range(0,len(order),8):
    l = (order[i:i+8])[::-1]
    x = [str(i) for i in l]
    char = int("".join(x),2)
    message += chr(char)
    print(message)
flag = "flag{dont_forget_the_treasure}"

    

