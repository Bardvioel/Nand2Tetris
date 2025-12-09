// =============================================
// ШАХМАТНОЕ ПОЛО 512x256 (16x16 пикселей на клетку)
// =============================================

// Переменные

    @BLACK
    M=-1
    @WHITE
    M=0
    @16384
    D=A
    @SCR_START
    M=D // SCR_START = 16384 (начало экрана)
    @24575
    D=A
    @SCR_END
    M=D // SCR_END = 24575 (конец экрана)
    @256
    D=A
    @Y
    M=D // Y = 256 (пикселей в клетке по вертикали)
    @X
    M=D // X = 256 (клеток в строке)

(MAIN_LOOP)
    // Достигли ли конца экрана
    @SCR_END
    D=M
    @SCR_START
    D=D-M
    @END
    D;JEQ

    // Есть ли еще клетки в текущей строке
    @X
    D=M
    @SWAP_COLORS_AND_RESET
    D;JLE // Меняем цвета и сбрасываем счетчики

    // Есть ли еще пиксели в текущей клетке?
    @Y
    D=M
    @NEXT_CELL
    D;JLE // Переходим к следующей клетке

    // ОТРИСОВКА ПИКСЕЛЕЙ
    @BLACK
    D=M
    @SCR_END
    A=M
    M=D
    @SCR_END
    M=M-1

    // Достигли ли начала экрана
    @SCR_END
    D=M
    @SCR_START
    D=D-M
    @END
    D;JEQ

    @WHITE
    D=M
    @SCR_END
    A=M
    M=D
    
    @SCR_END
    M=M-1

    // Уменьшаем счетчик пикселей в клетке
    @Y
    M=M-1

    @MAIN_LOOP
    0;JMP

(NEXT_CELL)
    // Переходим к следующей клетке в строке
    @X
    M=M-1
    @MAIN_LOOP
    0;JMP

(SWAP_COLORS_AND_RESET)
    // Меняем цвета местами
    @WHITE
    D=M
    @TEMP
    M=D
    @BLACK
    D=M
    @WHITE
    M=D
    @TEMP
    D=M
    @BLACK
    M=D

    // Сбрасываем счетчики
    @256
    D=A
    @Y
    M=D
    @256
    D=A
    @X
    M=D

    @MAIN_LOOP
    0;JMP

(END)
    @END
    0;JMP
