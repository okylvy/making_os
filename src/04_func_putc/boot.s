    BOOT_LOAD    equ    0x7C00

    ORG    BOOT_LOAD

; マクロ
%include    "../include/macro.s"

entry:
    jmp     ipl

    ; BPB (BIOS Parameter Block)
    times   90 - ($ -$$) db 0x90

    ; IPL (Initial Program Loader)

ipl:
    cli

    mov     ax, 0x0000
    mov     ds, ax
    mov     es, ax
    mov     ss, ax
    mov     sp, BOOT_LOAD

    sti

    mov     [BOOT.DRIVE], dl

    ; 文字を表示
    cdecl   putc, word 'X'
    cdecl   putc, word 'Y'
    cdecl   putc, word 'Z'


    jmp     $  ; while(1) ; $BL58B%k!<%W(B

ALIGN 2, db 0
BOOT:
.DRIVE: dw 0

; モジュール
%include    "../modules/real/putc.s"

    times    510 - ($ - $$) db 0x00
    db 0x55, 0xAA
