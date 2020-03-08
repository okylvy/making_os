get_font_adr:
        ; スタックフレームの構築
        push    bp
        mov     bp, sp

        ; レジスタの保存
        push    ax
        push    bx
        push    si
        push    es
        push    bp

        ; 引数を取得
        mov     si

        ; フォントアドレスの取得