namespace Assembler
{
    public class Parser
    {
        /// <summary>
        /// Удаляет все комментарии и пустые строки из программы. Удаляет все пробелы из команд.
        /// </summary>
        /// <param name="asmLines">Строки ассемблерного кода</param>
        /// <returns>Только значащие строки строки ассемблерного кода без комментариев и лишних пробелов</returns>
        public string[] RemoveWhitespacesAndComments(string[] asmLines)
        {
            var res = new List<string>();
            for (int i = 0; i < asmLines.Length; i++)
            {
                string a = asmLines[i].Replace(" ", "");
                a = a.Split("//")[0];
                if (!string.IsNullOrEmpty(a))
                    res.Add(a);
            }

            return res.ToArray();
        }
    }
}
