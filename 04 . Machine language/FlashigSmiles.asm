// === КОНСТАНТЫ СМАЙЛА ===
@7224
D=A
@SMILE_LINE1
M=D
@7224  
D=A
@SMILE_LINE2
M=D
@7224
D=A
@SMILE_LINE3
M=D
@0
D=A
@SMILE_LINE4
M=D
@0
D=A
@SMILE_LINE5
M=D
@24582
D=A
@SMILE_LINE6
M=D
@14364
D=A
@SMILE_LINE7
M=D
@4080
D=A
@SMILE_LINE8
M=D

// === АДРЕСА ПОЗИЦИЙ ===
@20362
D=A
@LEFT_ADDR
M=D
@19024
D=A
@UP_ADDR
M=D
@20373
D=A
@RIGHT_ADDR
M=D
@21680
D=A
@DOWN_ADDR
M=D

// === ПЕРЕМЕННЫЕ ===
@0
D=A
@LAST_KEY
M=D
@0
D=A
@NEW_ADDR
M=D






// === ОСНОВНОЙ ЦИКЛ ===
(MAIN)
    @24576
    D=M
    @NEW_KEY
    M=D
    
    // Проверяем изменилась ли клавиша
    @LAST_KEY
    D=D-M
    @MAIN
    D;JEQ
    
    // Стираем предыдущий смайл
    @LAST_KEY
    D=M
    @130
    D=D-A
    @DEL_LEFT
    D;JEQ
    
    @LAST_KEY
    D=M
    @131
    D=D-A
    @DEL_UP
    D;JEQ
    
    @LAST_KEY
    D=M
    @132
    D=D-A
    @DEL_RIGHT
    D;JEQ
    
    @LAST_KEY
    D=M
    @133
    D=D-A
    @DEL_DOWN
    D;JEQ
    
    @DRAW_NEW
    0;JMP

(DEL_LEFT)
    @LEFT_ADDR
    D=M
    @NEW_ADDR
    M=D
    @DEL_SMILE
    0;JMP

(DEL_UP)
    @UP_ADDR
    D=M
    @NEW_ADDR
    M=D
    @DEL_SMILE
    0;JMP

(DEL_RIGHT)
    @RIGHT_ADDR
    D=M
    @NEW_ADDR
    M=D
    @DEL_SMILE
    0;JMP

(DEL_DOWN)
    @DOWN_ADDR
    D=M
    @NEW_ADDR
    M=D
    @DEL_SMILE
    0;JMP

(DRAW_NEW)
    // Рисуем новый смайл
    @NEW_KEY
    D=M
    @130
    D=D-A
    @DRAW_LEFT
    D;JEQ
    
    @NEW_KEY
    D=M
    @131
    D=D-A
    @DRAW_UP
    D;JEQ
    
    @NEW_KEY
    D=M
    @132
    D=D-A
    @DRAW_RIGHT
    D;JEQ
    
    @NEW_KEY
    D=M
    @133
    D=D-A
    @DRAW_DOWN
    D;JEQ
    
    @NEW_LOOP
    0;JMP

(DRAW_LEFT)
    @LEFT_ADDR
    D=M
    @NEW_ADDR
    M=D
    @DRAW_SMILE
    0;JMP

(DRAW_UP)
    @UP_ADDR
    D=M
    @NEW_ADDR
    M=D
    @DRAW_SMILE
    0;JMP

(DRAW_RIGHT)
    @RIGHT_ADDR
    D=M
    @NEW_ADDR
    M=D
    @DRAW_SMILE
    0;JMP

(DRAW_DOWN)
    @DOWN_ADDR
    D=M
    @NEW_ADDR
    M=D
    @DRAW_SMILE
    0;JMP

// === ФУНКЦИЯ СТИРАНИЯ ===
(DEL_SMILE)
    @NEW_ADDR
    D=M
    @R0
    M=D
    
    @0
    D=A
    
    @R0
    A=M
    M=D
    @32
    D=A
    @R0
    M=M+D
    
    @0
    D=A
    @R0
    A=M
    M=D
    @32
    D=A
    @R0
    M=M+D
    
    @0
    D=A
    @R0
    A=M
    M=D
    @32
    D=A
    @R0
    M=M+D
    
    @64
    D=A
    @R0
    M=M+D
    
    @0
    D=A
    @R0
    A=M
    M=D
    @32
    D=A
    @R0
    M=M+D
    
    @0
    D=A
    @R0
    A=M
    M=D
    @32
    D=A
    @R0
    M=M+D
    
    @0
    D=A
    @R0
    A=M
    M=D
    
    @DRAW_NEW
    0;JMP

// === ФУНКЦИЯ РИСОВАНИЯ ===
(DRAW_SMILE)
    @NEW_ADDR
    D=M
    @R0
    M=D
    
    @SMILE_LINE1
    D=M
    @R0
    A=M
    M=D
    @32
    D=A
    @R0
    M=M+D
    
    @SMILE_LINE2
    D=M
    @R0
    A=M
    M=D
    @32
    D=A
    @R0
    M=M+D
    
    @SMILE_LINE3
    D=M
    @R0
    A=M
    M=D
    @32
    D=A
    @R0
    M=M+D
    
    @64
    D=A
    @R0
    M=M+D
    
    @SMILE_LINE6
    D=M
    @R0
    A=M
    M=D
    @32
    D=A
    @R0
    M=M+D
    
    @SMILE_LINE7
    D=M
    @R0
    A=M
    M=D
    @32
    D=A
    @R0
    M=M+D
    
    @SMILE_LINE8
    D=M
    @R0
    A=M
    M=D

(NEW_LOOP)
    // Сохраняем текущую клавишу
    @NEW_KEY
    D=M
    @LAST_KEY
    M=D
    
    @MAIN
    0;JMP
