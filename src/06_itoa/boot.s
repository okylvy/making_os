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
    cli                         ; 割り込み禁止

    mov     ax, 0x0000
    mov     ds, ax
    mov     es, ax
    mov     ss, ax
    mov     sp, BOOT_LOAD

    sti                         ; 割り込み許可

    mov     [BOOT.DRIVE], dl

    ; 文字列を表示
    cdecl   puts,   .s0

    ; 数値を表示
    cdecl   itoa,   8086,   .s1,    8,  10,     0b0001      ; "8086"
    cdecl   puts,   .s1

    cdecl   itoa,   8086,   .s1,    8,  10,     0b0011      ; "+8086"
    cdecl   puts,   .s1

    cdecl   itoa,   -8086,  .s1,    8,  10,     0b0001      ; "-8086"
    cdecl   puts,   .s1

    cdecl   itoa,   -1,     .s1,    8,  10,     0b0001      ; "-1"
    cdecl   puts,   .s1

    cdecl   itoa,   -1,     .s1,    8,  10,     0b0000      ; "65535"
    cdecl   puts,   .s1

    cdecl   itoa,   -1,     .s1,    8,  16,     0b0000      ; "FFFF"
    cdecl   puts,   .s1

    cdecl   itoa,   12,     .s1,    8,  2,      0b0100      ; "00001100"
    cdecl   puts,   .s1

    jmp     $               ; while(1) ; 無限ループ

    ; データ
.s0 db "Booting...", 0x0A, 0x0D, 0
.s1 db "----------", 0x0A, 0x0D, 0

ALIGN 2, db 0
BOOT:
.DRIVE: dw 0

; モジュール
%include    "../modules/real/puts.s"
%include    "../modules/real/itoa.s"

    times    510 - ($ - $$) db 0x00
    db 0x55, 0xAA
