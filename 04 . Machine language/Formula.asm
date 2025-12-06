// RAM[4] = (RAM[0] * 3 + (RAM[1] | RAM[2])) & !RAM[3] + 11



//D = RAM[1] | RAM[2]
@1
D=M
@2
D=D|M

//D * 3
@0 
D=D+M
D=D+M
D=D+M

//D & !RAM[3]
@3
M=!M
D=D&M
M=!M

//D + 11
@11
D=D+A

//M = D
@4
M=D
