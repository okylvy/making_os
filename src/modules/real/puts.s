puts:
    ; スタックフレームの構築
    push    bp  ; bp + 4: 文字列へのアドレス
    mov     bp, sp

    ; レジスタの保存
    push    ax
    push    bx
    push    si

    ; 引数を取得
    mov     si, [bp + 4]  ; 文字列へのアドレスを SI にセット。

    ; 処理の開始
    mov     ah, 0x0E
    mov     bx, 0x0000
    cld
.10L:
    lodsb  ; Load String. 'b' stands for byte.

    cmp     al, 0
    je      .10E

    int     0x10
    jmp     .10L
.10E:

    ; レジスタの復帰
    pop     si
    pop     bx
    pop     ax

    ; スタックフレームの破棄
    mov     sp, bp
    pop     bp

    ret