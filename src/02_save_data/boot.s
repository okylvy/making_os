    BOOT_LOAD    equ    0x7C00  ; $B%V!<%H%W%m%0%i%`$N%m!<%I0LCV(B

    ORG    BOOT_LOAD  ; $B%m!<%I%"%I%l%9$r%"%;%s%V%i$K;X<((B

; $B%(%s%H%j%]%$%s%H(B
entry:
    jmp     ipl  ; IPL$B$X%8%c%s%W(B

    ; BPB (BIOS Parameter Block)
    times   90 - ($ -$$) db 0x90

    ; IPL (Initial Program Loader)

ipl:
    cli  ; $B3d$j9~$_6X;_(B

    mov     ax, 0x0000
    mov     ds, ax
    mov     es, ax
    mov     ss, ax
    mov     sp, BOOT_LOAD

    sti  ; $B3d$j9~$_5v2D(B (Set Interrupt Flag)

    mov     [BOOT.DRIVE], dl

    ; $B=hM}$N=*N;(B
    jmp     $  ; while(1) ; $BL58B%k!<%W(B

ALIGN 2, db 0
BOOT:
.DRIVE: dw 0

; $B%V!<%H%U%i%0(B($B@hF,(B512$B%P%$%H$N=*N;(B)
    times    510 - ($ - $$) db 0x00
    db 0x55, 0xAA


