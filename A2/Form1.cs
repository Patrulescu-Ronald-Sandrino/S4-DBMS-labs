using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace A2
{
    public partial class Form1 : Form
    {
        private SqlConnection _sqlConnection;
        private SqlDataAdapter _dataAdapterParent, _dataAdapterChild;
        private DataSet _dataSet;
        private SqlCommandBuilder _sqlCommandBuilderChild;
        private BindingSource _bindingSourceParent, _bindingSourceChild;

        public Form1()
        {
            InitializeComponent();
        }

        private string GetParentTable() => ConfigurationManager.AppSettings["parentTable"];
        private string GetParentTablePK() => ConfigurationManager.AppSettings["parentTablePK"];
        private string GetChildTable() => ConfigurationManager.AppSettings["childTable"];
        private string GetChildTablePK() => ConfigurationManager.AppSettings["childTableFK"];
        private string GetParentQuery() => ConfigurationManager.AppSettings["parentQuery"];
        private string GetChildQuery() => ConfigurationManager.AppSettings["childQuery"];

        private void button1_Click(object sender, EventArgs e)
        {
            var connectionString = Program.getConnectionString();
            if (connectionString == null)
            {
                Program.LogError("[error][Form1.button1_Click()] connectionString is null after reading it from file. ");
                return;
            }
            Console.WriteLine("[log][Form1.button1_Click()] connectionString: " + connectionString);
            if ((_sqlConnection = new SqlConnection(connectionString)) == null)
            {
                Program.LogError("[error][Form1.button1_Click()] creating a SQL Connection failed");
                return;
            }
            Console.WriteLine("[log][Form1.button1_Click()] created SQL Connection");
            
            try
            {
                // open the connection
                _sqlConnection.Open();
                Console.WriteLine("[log][Form1.button1_Click()] Opened the SQL Connection");
                Console.WriteLine("[log][Form1.button1_Click()] The state of the connection: " + _sqlConnection.State);

                // switch to the CoffeeShopDB
                using (SqlCommand sqlCommand = new SqlCommand("USE [CoffeeShopDB]", _sqlConnection))
                {
                    sqlCommand.ExecuteNonQuery();
                    Console.WriteLine("[log][Form1.button1_Click()] Switched to [CoffeeShopDB]");
                }


                _dataAdapterParent = new SqlDataAdapter(GetParentQuery(), _sqlConnection);
                _dataAdapterChild = new SqlDataAdapter(GetChildQuery(), _sqlConnection);
                _sqlCommandBuilderChild = new SqlCommandBuilder(_dataAdapterChild);
                
                _dataSet = new DataSet();
                _dataAdapterParent.Fill(_dataSet, GetParentTable());
                _dataAdapterChild.Fill(_dataSet, GetChildTable());

                _dataSet.Relations.Add(new DataRelation("FK_constraint", 
                    _dataSet.Tables[GetParentTable()].Columns[GetParentTablePK()], 
                    _dataSet.Tables[GetChildTable()].Columns[GetChildTablePK()]));

                _bindingSourceParent = new BindingSource { DataSource = _dataSet, DataMember = GetParentTable() };
                _bindingSourceChild = new BindingSource { DataSource = _bindingSourceParent, DataMember = "FK_constraint" };

                dataGridView1.DataSource = _bindingSourceParent;
                dataGridView2.DataSource = _bindingSourceChild;


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
            if (_dataSet != null)
            {
                try
                {
                    Console.WriteLine("[log][Form1.button2_Click()] Updated " + _dataAdapterChild.Update(_dataSet, GetChildTable()) + " rows");
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
