f = open("inside-the-mind-of-a-hacker-memory.bmp", "rb") 

data = f.read()

Signature  = int.from_bytes(data[0:2],"little")
FileSize  = int.from_bytes(data[2:6],"little")
reserved  = int.from_bytes(data[6:10],"little")
DataOffset  = int.from_bytes(data[10:14],"little")
Size  = int.from_bytes(data[14:18],"little")
width  = int.from_bytes(data[18:22],"little")
height  = int.from_bytes(data[22:26],"little")
planes  = int.from_bytes(data[26:30],"little")
Bigcount  = int.from_bytes(data[30:32],"little")
Compression  = int.from_bytes(data[32:36],"little")
ImageSize  = int.from_bytes(data[36:40],"little")
XpixelsPerM  = int.from_bytes(data[40:44],"little")
YpixelsPerM  = int.from_bytes(data[44:48],"little")
ColorUsed  = int.from_bytes(data[48:52],"little")
ColorImportant  = int.from_bytes(data[52:56],"little")
Red  = int(data[56])
green  = int(data[57])
blue  = int(data[58])
reserv  = int(data[59])


'''
Reserved: 56
DataOffset: 54
Size: 40
Width: 938
Height: 580
Planes: 1572865
BitCount: 0
Compression: 3959422976
ImageSize: 185794584
XPixelsPerM: 185794560
YPixelsPerM: 0
ColorUsed: 0
ColorImportant: 0
Red: 268500992
Green: 7
Blue: 0
Reserved: 16
'''

