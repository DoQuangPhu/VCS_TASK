

int main()
{
    if ( lpBaseAddress->Signature == 'MB' && FileSize >= lpBaseAddress->FileSize )
            {
                v14 = lpBaseAddress->DataOffset;
                if ( v14 < FileSize && buferlenmulby8 < *(int *)((char *)&lpBaseAddress->Compression + 2) )
                {
                    bufercurrentIndex = 0;
                    width = lpBaseAddress->width;
                    height = lpBaseAddress->height;
                    imageData = (char *)lpBaseAddress + v14;
                    heightcnt = 0;
                    v25 = width;
                    savedImageData = imageData;
                    LOWORD(lpBaseAddress->reserved) = buferlenmulby8;
                    v33 = 0;
                if ( buferlenmulby8 )
                {
                    v19 = 0;
                    v31 = 0;
                    do
                    {
                        if ( heightcnt >= height )
                            break;
                        withcnt = 0;
                        if ( bufercurrentIndex < buferlenmulby8 )
                        {
                            do
                            {
                                if ( withcnt >= width )
                                    break;
                                v21 = v19 + withcnt++;
                                character1 = buffercpy[bufercurrentIndex++];
                                savedImageData[2 * v21 + v21] = character1;
                                v19 = v31;
                                width = v25;
                            }
                            while ( bufercurrentIndex < buferlenmulby8 );
                            heightcnt = v33;
                        }
                        ++heightcnt;
                        v19 += 3 * width;
                        v33 = heightcnt;
                        v31 = v19;
                    }
                    while ( bufercurrentIndex < buferlenmulby8 );
                    v13 = lpBaseAddress;
                }
                buffer = buffercpy;
                }
            }
}