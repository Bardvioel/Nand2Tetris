// Программа должна умножать числа из R0 и R1 и сохранять результат в R2.


@R2
M=0

@R1
D=M
@ZERO
D;JEQ

@R0
D=M
@ZERO
D;JEQ

//УМНОЖЕНИЕ
(POS)
@R1
D=M
@END
D;JEQ

@R0
D=M
@R2
M=D+M
@R1
M=M-1

@POS
0;JMP

//УМНОЖЕНИЕ НА 0
(ZERO)
@R2
M=0

(END)
@END
0;JMP
