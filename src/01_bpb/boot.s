entry:
    jmp     ipl  ; jump to JPL
   
    ; BPB (BIOS Parameter Block)
    times   90 - ($ -$$) db 0x90

    ; IPL (Initial Program Loader)
ipl:

    ; End of the process.
    jmp     $  ; while (1)

; Boot flag (End of head 512 byte)
    times   510 - ($ - $$) db 0x00
    db 0x55, 0xAA
