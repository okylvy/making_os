entry:
    jmp    $    ; while (1) ; // Endless loop.

    times  510 - ($ - $$) db 0x00
    db     0x55, 0xAA
