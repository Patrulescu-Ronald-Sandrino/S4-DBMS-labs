using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace A1
{
    public partial class Form1 : Form
    {
        SqlConnection sqlConnection;
        SqlDataAdapter dataAdapterPosition, dataAdapterSalary;
        DataSet dataSet;
        SqlCommandBuilder sqlCommandBuilderSalary;
        BindingSource bindingSourcePosition, bindingSourceSalary;

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            var connectionString = Program.getConnectionString();
            if (connectionString == null)
            {
                Program.LogError("[error][Form1.button1_Click()] connectionString is null after reading it from file. ");
                return;
            }
            Console.WriteLine("[log][Form1.button1_Click()] connectionString: " + connectionString);
            if ((sqlConnection = new SqlConnection(connectionString)) == null)
            {
                Program.LogError("[error][Form1.button1_Click()] creating a SQL Connection failed");
                return;
            }
            Console.WriteLine("[log][Form1.button1_Click()] created SQL Connection");
            
            try
            {
                // open the connection
                sqlConnection.Open();
                Console.WriteLine("[log][Form1.button1_Click()] Opened the SQL Connection");
                Console.WriteLine("[log][Form1.button1_Click()] The state of the connection: " + sqlConnection.State);

                // switch to the CoffeeShopDB
                using (SqlCommand sqlCommand = new SqlCommand("USE [CoffeeShopDB]", sqlConnection))
                {
                    sqlCommand.ExecuteNonQuery();
                    Console.WriteLine("[log][Form1.button1_Click()] Switched to [CoffeeShopDB]");
                }


                dataAdapterPosition = new SqlDataAdapter("select * from Position", sqlConnection);
                dataAdapterSalary = new SqlDataAdapter("select * from Salary", sqlConnection);
                sqlCommandBuilderSalary = new SqlCommandBuilder(dataAdapterSalary);
                
                dataSet = new DataSet();
                dataAdapterPosition.Fill(dataSet, "Position");
                dataAdapterSalary.Fill(dataSet, "Salary");

                dataSet.Relations.Add(new DataRelation("FK_pid_Position_to_Salary", dataSet.Tables["Position"].Columns["pid"], dataSet.Tables["Salary"].Columns["pidfk"]));

                bindingSourcePosition = new BindingSource { DataSource = dataSet, DataMember = "Position" };
                bindingSourceSalary = new BindingSource { DataSource = bindingSourcePosition, DataMember = "FK_pid_Position_to_Salary" };

                dataGridView1.DataSource = bindingSourcePosition;
                dataGridView2.DataSource = bindingSourceSalary;


                // END: free resources
                //sqlConnection.Close();
            }
            catch (Exception exception)
            {
                Console.WriteLine(exception);
            }
        }
        private void button2_Click(object sender, EventArgs e)
        {
            if (dataSet != null)
            {
                try
                {
                    Console.WriteLine("[log][Form1.button2_Click()] Updated " + dataAdapterSalary.Update(dataSet, "Salary") + " rows");
                }
                catch (Exception exception)
                {
                    Program.LogError("[error][Form1.button2_Click()] Exception caught: " + exception.Message);
                }
            }
            else
            {
                Program.LogError("[error][Form1.button2_Click()] dataSet is null");
            }
        }
    }
}
