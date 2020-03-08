    BOOT_LOAD    equ    0x7C00  ; ブートプログラムのロード位置

    ORG    BOOT_LOAD  ; ロードアドレスをアセンブラに指示

; エントリポイント
entry:
    jmp     ipl  ; IPLへジャンプ

    ; BPB (BIOS Parameter Block)
    times   90 - ($ -$$) db 0x90

    ; IPL (Initial Program Loader)

ipl:
    cli  ; 割り込み禁止

    mov     ax, 0x0000
    mov     ds, ax
    mov     es, ax
    mov     ss, ax
    mov     sp, BOOT_LOAD

    sti  ; 割り込み許可 (Set Interrupt Flag)

    mov     [BOOT.DRIVE], dl

    ; 処理の終了
    jmp     $  ; while(1) ; 無限ループ

ALIGN 2, db 0
BOOT:
.DRIVE: dw 0

; ブートフラグ(先頭512バイトの終了)
    times    510 - ($ - $$) db 0x00
    db 0x55, 0xAA


