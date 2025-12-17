using System.Collections.Generic;

namespace Assembler
{
    public class SymbolAnalyzer
    {
        /// <summary>
        /// Находит все метки в ассемблерном коде, удаляет их из кода и вносит их адреса в таблицу символов.
        /// </summary>
        /// <param name="instWithLabels">Ассемблерный код, возможно, содержащий метки</param>
        /// <param name="instWithoutLabels">Ассемблерный код без меток</param>
        /// <returns>
        /// Таблица символов, содержащая все стандартные предопределенные символы (R0−R15, SCREEN, ...),
        /// а также все найденные в программе метки.
        /// </returns>
        public Dictionary<string, int> CreateSymbolsTable(string[] instWithLabels,
    out string[] instWithoutLabels)
        {
            var symbolsTable = CreateDictionary();
            var instList = new List<string>();
            int instCount = 0;

            for (int i = 0; i < instWithLabels.Length; i++)
            {
                if (instWithLabels[i][0] == '(')                
                    symbolsTable[instWithLabels[i].Substring(1, instWithLabels[i].Length - 2)] = instCount;
                else
                {
                    instList.Add(instWithLabels[i]);
                    instCount++;
                }
            }

            instWithoutLabels = instList.ToArray();
            return symbolsTable;
        }

        static Dictionary<string, int> CreateDictionary()
        {
            var symbolsTable = new Dictionary<string, int>();

            for (int i = 0; i < 16; i++)
            {
                symbolsTable[$"R{i}"] = i;
            }
            symbolsTable["SCREEN"] = 16384;
            symbolsTable["KBD"] = 24576;
            symbolsTable["SP"] = 0;
            symbolsTable["LCL"] = 1;
            symbolsTable["ARG"] = 2;
            symbolsTable["THIS"] = 3;
            symbolsTable["THAT"] = 4;

            return symbolsTable;
        }
    }
}
