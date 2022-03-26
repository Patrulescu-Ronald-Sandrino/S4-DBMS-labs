using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace A1
{
    internal static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());
        }

        public static SqlConnection CreateSqlConnection(String connectionStringFilePath)
        {
            SqlConnection sqlConnection = null;
            try
            {
                using (var streamReader = new StreamReader(connectionStringFilePath)) // https://docs.microsoft.com/en-us/dotnet/api/system.io.streamreader?view=net-6.0
                {
                    var connectionString = "";
                    sqlConnection = (connectionString = streamReader.ReadLine()) == null ?
                                        null : new SqlConnection(connectionString);
                }
            }
            catch (Exception e)
            {
                LogError("[error][MainClass::CreateSqlConnection] Reading the file failed: " + e.Message);
                sqlConnection = null;
            }
            return sqlConnection;
        }

        public static void LogError(String errorMessage)
        {
            //Console.Error.Write("\033[31m" + errorMessage + "\033[0m\n");
            //Console.Error.Write(string.Format("\033[31m{0}\033[0m\n", errorMessage));
            Console.Error.WriteLine(errorMessage); // c# write to stderr -> https://www.programming-idioms.org/idiom/59/write-to-standard-error-stream/2735/csharp
        }
    }
}
