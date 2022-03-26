using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace A1
{
    public partial class Form1 : Form
    {
        SqlConnection sqlConnection;
        private SqlDataAdapter dataAdapterPosition, dataAdapterSalary;
        private DataSet dataSet;
        private BindingSource bindingSourcePosition, bindingSourceSalary;


        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Console.WriteLine("[log] Run location: " + System.IO.Directory.GetCurrentDirectory()); // c# print pwd-> https://www.codegrepper.com/code-examples/csharp/c%23+pwd
            var connectionStringFilePath = "../../../connectionString.txt";
            //var connectionStringFilePath = "../connectionString.txt";
            using (sqlConnection = Program.CreateSqlConnection(connectionStringFilePath))
            {
                if (sqlConnection == null)
                {
                    Program.LogError("[error][Form1.Test] creating a SQL Connection failed");
                }
                else
                {
                    Console.WriteLine("[log] created SQL Connection");
                    try
                    {
                        // open the connection
                        sqlConnection.Open();
                        Console.WriteLine("[log] Opened the SQL Connection");
                        Console.WriteLine("[log] The state of the connection: " + sqlConnection.State);

                        // switch to the CoffeeShopDB
                        using (SqlCommand sqlCommand = new SqlCommand("USE [CoffeeShopDB]", sqlConnection))
                        {
                            sqlCommand.ExecuteNonQuery();
                            Console.WriteLine("[log] Switched to [CoffeeShopDB]");
                        }


                        // TODO: implementation
                        dataAdapterPosition = new SqlDataAdapter("select * from Position", sqlConnection);
                        dataAdapterSalary = new SqlDataAdapter("select * from Salary", sqlConnection);

                        dataSet = new DataSet();
                        dataAdapterPosition.Fill(dataSet, "Position");
                        dataAdapterSalary.Fill(dataSet, "Salary");

                        dataSet.Relations.Add(new DataRelation("FK_pid_Position_to_Salary", dataSet.Tables["Position"].Columns["pid"], dataSet.Tables["Salary"].Columns["pidfk"]));

                        bindingSourcePosition = new BindingSource { DataSource = dataSet, DataMember = "Position" };
                        bindingSourceSalary = new BindingSource { DataSource = dataSet, DataMember = "Salary" };

                        dataGridView1.DataSource = bindingSourcePosition;
                        dataGridView2.DataSource = bindingSourceSalary;


                        // END: free resources
                        sqlConnection.Close();
                    }
                    catch (Exception exception)
                    {
                        Console.WriteLine(exception);
                    }
                }
            }
        }
        private void button2_Click(object sender, EventArgs e)
        {
            if (dataSet != null)
            {
                dataAdapterSalary.Update(dataSet, "Salary");
            }
            else
            {
                Program.LogError("[error][Form1.button2_Click()] dataSet is null");
            }
        }
    }
}
