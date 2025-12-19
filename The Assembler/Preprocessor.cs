using System.Collections.Generic;
using System.Linq;
using System;

namespace Assembler
{
    public class Preprocessor
    {
        /// <summary>
        /// Преобразует нестандартные макро-инструкции в инструкции обычного языка ассемблера.
        /// </summary>
        public string[] PreprocessAsm(string[] instructions)
        {
            var asmCode = new List<string>();
            for (int i = 0; i < instructions.Length; i++)
            {
                var instr = instructions[i];
                try
                {
                    TranslateInstruction(instr, asmCode);
                }
                catch (Exception e)
                {
                    throw new FormatException($"Can't parse at line {i + 1}: {instr}", e);
                }
            }

            return asmCode.ToArray();
        }


        public void TranslateInstruction(string instruction, List<string> asmCode)
		{
			int start = instruction.IndexOf('[');
			int end = instruction.IndexOf(']');

			if (start != -1)
			{
				TransInst(instruction, asmCode);
			}
			else
			{
				if (instruction.Contains("J") && !instruction.Contains(";"))
				{
					if (instruction.Contains("JMP"))
						asmCode.Add("0;JMP");
					else
						asmCode.Add("D;" + instruction);
				}
				else
					asmCode.Add(instruction);
			}
		}

		static void TransInst(string instruction, List<string> asmCode)
		{
			string address = "";
			while (instruction.IndexOf('[') != -1)
			{
				int start = instruction.IndexOf('[');
				int end = instruction.IndexOf(']');
				address = instruction.Substring(start + 1, end - start - 1);
				instruction = instruction.Remove(start + 1, end - start - 1).Replace("[]", "");
			}

			asmCode.Add($"@{address}");

			if (instruction.Contains("J"))
			{
				asmCode.Add(instruction.Contains(";") ? instruction
					: (instruction.Contains("JMP") ? "0;JMP" : "D;" + instruction));
			}
			else
			{
				asmCode.Add(instruction);
			}
		}
    }
}
