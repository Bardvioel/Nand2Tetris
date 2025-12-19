using System.Collections.Generic;
using System.Linq;
using System;

namespace Assembler
{
    public class HackTranslator
    {
        public string[] TranslateAsmToHack(string[] instructions, Dictionary<string, int> symbolTable)
        {
            string[] codes = new string[instructions.Length];

            for (int i = 0; i< instructions.Length; i++)
            {
                string instructionIn = instructions[i];
                string instructionOut;
                if (instructionIn[0] == '@')
                    instructionOut = AInstructionToCode(instructionIn, symbolTable);
                else
                    instructionOut = CInstructionToCode(instructionIn);
                codes[i] = instructionOut;
            }
            
            return codes;
        }

		public int NextAddr = 16;

        public string AInstructionToCode(string aInstruction, Dictionary<string, int> symbolTable)
        {
            var symbol = aInstruction.Substring(1);

            if (int.TryParse(symbol, out int address))
                return Convert.ToString(address, 2).PadLeft(16, '0');

            if (symbolTable.ContainsKey(symbol))
                return Convert.ToString(symbolTable[symbol], 2).PadLeft(16, '0');

            // если новая переменная
            symbolTable[symbol] = NextAddr;
            NextAddr++;

            return Convert.ToString(symbolTable[symbol], 2).PadLeft(16, '0');
        }

        public string CInstructionToCode(string cInstruction)
		{
			string destPart = "";
			string compPart = "";
			string jumpPart = "";

			// Разделяем по ; (jump часть)
			string[] cInst = cInstruction.Split(';');

			if (cInst.Length == 2)
				jumpPart = cInst[1];

			// Разделяем оставшуюся часть (dest часть)
			string[] left = cInst[0].Split('=');

			if (left.Length == 2)
			{
				destPart = left[0];
				compPart = left[1];
			} else
				compPart = cInst[0];

			// Объединяем: "111" + compCode + destCode + jumpCode
			return "111" + GetCompCode(compPart) + GetDestCode(destPart) + GetJumpCode(jumpPart);
		}

        static string GetDestCode(string dest)
        {
            var destCodes = new Dictionary<string, string>
            {
                ["M"] = "001", ["D"] = "010", ["MD"] = "011", ["A"] = "100",
                ["AM"] = "101", ["AD"] = "110", ["AMD"] = "111", [""] = "000"
            };
            return destCodes[dest];
        }

        static string GetCompCode(string comp)
        { 
            var compCodes = new Dictionary<string, string>
            {
                ["0"] = "0101010", ["1"] = "0111111", ["-1"] = "0111010", ["D"] = "0001100", ["A"] = "0110000",
                ["!D"] = "0001101", ["!A"] = "0110001", ["-D"] = "0001111", ["-A"] = "0110011", ["D+1"] = "0011111",
                ["A+1"] = "0110111", ["D-1"] = "0001110", ["A-1"] = "0110010", ["D+A"] = "0000010", ["D-A"] = "0010011",
                ["A-D"] = "0000111", ["D&A"] = "0000000", ["D|A"] = "0010101",
                ["M"] = "1110000", ["!M"] = "1110001", ["-M"] = "1110011", ["M+1"] = "1110111", ["M-1"] = "1110010",
                ["D+M"] = "1000010", ["D-M"] = "1010011", ["M-D"] = "1000111", ["D&M"] = "1000000", ["D|M"] = "1010101"
            };
            return compCodes[comp];
        }

        static string GetJumpCode(string jump)
        {
            var jumpCodes = new Dictionary<string, string>
            {
                ["JGT"] = "001", ["JEQ"] = "010", ["JGE"] = "011", ["JLT"] = "100",
                ["JNE"] = "101", ["JLE"] = "110", ["JMP"] = "111", [""] = "000" 
            };
            return jumpCodes[jump];
        }
    }
}
