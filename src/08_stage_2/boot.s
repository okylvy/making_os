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

        ; 次の512バイトを読み込む
        mov     ah, 0x02
        mov     al, 1
        mov     cx, 0x0002
        mov     dh, 0x00
        mov     dl, [BOOT.DRIVE]
        mov     bx, 0x7C00 + 512
        int     0x13
.10Q:   jnc     .10E
.10T:   cdecl   puts, .e0
        call    reboot
.10E:
        ; 次のステージへ移行
        jmp     stage_2

        ; データ
.s0     db "Booting...", 0x0A, 0x0D, 0
.e0     db "Error:sector read", 0

ALIGN 2, db 0
BOOT:
.DRIVE: dw 0

; モジュール
%include    "../modules/real/puts.s"
%include    "../modules/real/itoa.s"
%include    "../modules/real/reboot.s"

; ブートフラグ (先頭512バイトの終了)
        times    510 - ($ - $$) db 0x00
        db 0x55, 0xAA

; ブート処理の第2ステージ
stage_2:
        ; 文字列を表示
        cdecl   puts, .s0

        ; 処理の終了
        jmp     $

        ; データ
.s0     db "2nd stage...", 0x0A, 0x0D, 0

; パディング
        times (1024 * 8) - ($ - $$) db 0    ; 8K bytes
