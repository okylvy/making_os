get_drive_param:
        ; スタックフレームの構築
        push    bp
        mov     bp, sp

        ; レジスタの保存
        push    bx
        push    cx
        push    es
        push    si
        push    di

        ; 処理の開始
        mov     si, [bp + 4]    ; バッファ

        mov     ax, 0           ; Disk Base Table Pointer の初期化
        mov     es, ax          ; ES = 0;
        mov     di, ax          ; DI = 0;

        mov     ah, 8           ; // get drive parameters
        mov     dl, [si + drive.no] ; DL =ドライブ番号
        int     0x13            ; CF = BIOS(0x13, 8)
.10Q:   JC      .10F
.10T:
        mov     al, cl
        and     ax, 0x3F

        shr     cl, 6
        ror     cx, 8
        inc     cx

        movzx   bx, bh
        inc     bx

        mov     [si + drive.cyln], cx
        mov     [si + drive.head], bx
        mov     [si + drive.sect], ax

        jmp     .10E
.10F:
        mov     ax, 0
.10E:

        ; レジスタの復帰
        pop     di
        pop     si
        pop     es
        pop     cx
        pop     bx

        ; スタックフレームの破棄
        mov     sp, bp
        pop     bp

        ret