memcpy:
    ; $B%9%?%C%/%U%l!<%`$N9=C[(B
    push    bp
    mov     bp, sp

    ; $B%l%8%9%?$NJ]B8(B
    push    cx
    push    si
    push    di

    ; $B%P%$%HC10L$G$N%3%T!<(B
    cld
    mov     di, [bp + 4]
    mov     si, [bp + 6]
    mov     cx, [bp + 8]

    rep movsb

    ; $B%l%8%9%?$NI|5"(B
    pop     di
    pop     si
    pop     cx

    ; $B%9%?%C%/%U%l!<%`$NGK4~(B
    mov     sp, bp
    pop     bp

    ret
