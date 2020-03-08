    BOOT_LOAD    equ    0x7C00  ; ブートプログラムのロード位置

    ORG    BOOT_LOAD            ; ロードアドレスをアセンブラに指示

; マクロ
%include    "../include/macro.s"

; エントリポイント
entry:
    ; BPB (BIOS Parameter Block)
    jmp     ipl
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

    ; 文字列を表示
    cdecl   puts, .s0

    jmp     $               ; while(1) ; 無限ループ

    ; データ
.s0 db  "Booting...", 0x0A, 0x0D, 0

ALIGN 2, db 0
BOOT:
.DRIVE: dw 0

; モジュール
%include    "../modules/real/puts.s"

    times    510 - ($ - $$) db 0x00
    db 0x55, 0xAA
