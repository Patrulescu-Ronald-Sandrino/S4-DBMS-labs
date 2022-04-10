using System;
using System.IO;
using System.Windows.Forms;

namespace MasterDetailFormUsingDataGridViews
{
    internal class Program
    {
        // https://docs.microsoft.com/en-us/dotnet/desktop/winforms/controls/create-a-master-detail-form-using-two-datagridviews?view=netframeworkdesktop-4.8
        // https://docs.microsoft.com/en-us/dotnet/desktop/winforms/controls/creating-a-master-detail-form-using-two-datagridviews?view=netframeworkdesktop-4.8
        public static void Main(string[] args)
        {
            try
            {
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);
                Application.Run(new Form1());
            }
            catch (Exception e)
            {
                Console.WriteLine("[Program.Main()] Caught: " + e.Message);
            }
        }
        
         public static String ReadConnectionStringFromFile(String connectionStringFilePath)
        {
            String connectionString = "";
            try
            {
                using (var streamReader = new StreamReader(connectionStringFilePath)) // https://docs.microsoft.com/en-us/dotnet/api/system.io.streamreader?view=net-6.0
                {
                    connectionString = streamReader.ReadLine();
                }
            }
            catch (Exception exception)
            {
                LogError("[error][MainClass::ReadConnectionStringFromFile] Reading the file failed: " + exception.Message);

            }
            return connectionString;
        }

        public static String getConnectionString()
        {
            Console.WriteLine("[log][Program.getConnectionString()] OSVersion: " + Environment.OSVersion.ToString());
            var connectionString = "";
            if (Environment.OSVersion.ToString().Contains("Microsoft Windows")) // https://www.geeksforgeeks.org/c-sharp-program-to-get-the-operating-system-version-of-computer-using-environment-class/
            {
                connectionString = @"Data Source=WIN10-ACERASPV5\SQLEXPRESS;Initial Catalog=CoffeeShopDB;Integrated Security=True"; // Server Explorer -> Right click on a Data Connection -> Properties -> Connection String
                connectionString = @"Data Source=" + System.Environment.MachineName + @"\SQLEXPRESS;Initial Catalog=CoffeeShopDB;Integrated Security=True"; // first answer from https://stackoverflow.com/questions/1768198/how-do-i-get-the-computer-name-in-net
            }
            else
            {
                Console.WriteLine("[log][Program.getConnectionString()] Run location: " + System.IO.Directory.GetCurrentDirectory()); // c# print pwd-> https://www.codegrepper.com/code-examples/csharp/c%23+pwd
                var connectionStringFilePath = "../../../connectionString.txt";
                //var connectionStringFilePath = "../connectionString.txt";
                connectionString = Program.ReadConnectionStringFromFile(connectionStringFilePath);

            }
            return connectionString;
        }

        public static void LogError(String errorMessage)
        {
            //Console.Error.Write("\033[31m" + errorMessage + "\033[0m\n");
            //Console.Error.Write(string.Format("\033[31m{0}\033[0m\n", errorMessage));
            Console.Error.WriteLine(errorMessage); // c# write to stderr -> https://www.programming-idioms.org/idiom/59/write-to-standard-error-stream/2735/csharp
        }
    }
}