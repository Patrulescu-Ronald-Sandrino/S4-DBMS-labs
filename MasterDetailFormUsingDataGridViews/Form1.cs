using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Windows.Forms;

namespace MasterDetailFormUsingDataGridViews
{
    public class Form1 : System.Windows.Forms.Form
    {
        private DataGridView masterDataGridView = new DataGridView();
        private BindingSource masterBindingSource = new BindingSource();
        private DataGridView detailsDataGridView = new DataGridView();
        private BindingSource detailsBindingSource = new BindingSource();
        
        private string GetParentTable() => ConfigurationManager.AppSettings["parentTable"];
        private string GetParentTablePK() => ConfigurationManager.AppSettings["parentTablePK"];
        private string GetChildTable() => ConfigurationManager.AppSettings["childTable"];
        private string GetChildTablePK() => ConfigurationManager.AppSettings["childTableFK"];
        private string GetParentQuery() => ConfigurationManager.AppSettings["parentQuery"];
        private string GetChildQuery() => ConfigurationManager.AppSettings["childQuery"];
        
        public Form1()
        {
            masterDataGridView.Dock = DockStyle.Fill;
            detailsDataGridView.Dock = DockStyle.Fill;

            SplitContainer splitContainer1 = new SplitContainer();
            splitContainer1.Dock = DockStyle.Fill;
            splitContainer1.Orientation = Orientation.Horizontal;
            splitContainer1.Panel1.Controls.Add(masterDataGridView);
            splitContainer1.Panel2.Controls.Add(detailsDataGridView);

            this.Controls.Add(splitContainer1);
            this.Load += new System.EventHandler(Form1_Load);
            this.Text = "DataGridView master/detail demo";
        }
        
        private void Form1_Load(object sender, System.EventArgs e)
        {
            // Bind the DataGridView controls to the BindingSource
            // components and load the data from the database.
            masterDataGridView.DataSource = masterBindingSource;
            detailsDataGridView.DataSource = detailsBindingSource;
            GetData();

            // Resize the master DataGridView columns to fit the newly loaded data.
            masterDataGridView.AutoResizeColumns();

            // Configure the details DataGridView so that its columns automatically
            // adjust their widths when the data changes.
            detailsDataGridView.AutoSizeColumnsMode =
                DataGridViewAutoSizeColumnsMode.AllCells;
        }
        
        private void GetData()
        {

            
            try
            {
                var connectionString = Program.getConnectionString();
                if (connectionString == null)
                {
                    Program.LogError("[error][Form1.button1_Click()] connectionString is null after reading it from file. ");
                    return;
                }
                Console.WriteLine("[log][Form1.button1_Click()] connectionString: " + connectionString);
                var connection = new SqlConnection(connectionString);
                Console.WriteLine("[log][Form1.button1_Click()] created SQL Connection");
                
                // open the connection
                connection.Open();
                Console.WriteLine("[log][Form1.button1_Click()] Opened the SQL Connection. It's state is: " + connection.State);
                
                // switch to the CoffeeShopDB
                using (SqlCommand sqlCommand = new SqlCommand("USE [CoffeeShopDB]", connection))
                {
                    sqlCommand.ExecuteNonQuery();
                    Console.WriteLine("[log][Form1.button1_Click()] Switched to [CoffeeShopDB]");
                }
                
                Console.WriteLine(GetParentTable());

                // Create a DataSet.
                DataSet data = new DataSet();
                data.Locale = System.Globalization.CultureInfo.InvariantCulture;

                // Add data from the Customers table to the DataSet.
                SqlDataAdapter masterDataAdapter = new
                    SqlDataAdapter(GetParentQuery(), connection);
                masterDataAdapter.Fill(data, GetParentTable());

                // Add data from the Orders table to the DataSet.
                SqlDataAdapter detailsDataAdapter = new
                    SqlDataAdapter(GetChildQuery(), connection);
                detailsDataAdapter.Fill(data, GetChildTable());

                // Establish a relationship between the two tables.
                DataRelation relation = new DataRelation("CustomersOrders",
                    data.Tables[GetParentTable()].Columns[GetParentTablePK()],
                    data.Tables[GetChildTable()].Columns[GetChildTablePK()]);
                data.Relations.Add(relation);

                // Bind the master data connector to the Customers table.
                masterBindingSource.DataSource = data;
                masterBindingSource.DataMember = GetParentTable();

                // Bind the details data connector to the master data connector,
                // using the DataRelation name to filter the information in the
                // details table based on the current row in the master table.
                detailsBindingSource.DataSource = masterBindingSource;
                detailsBindingSource.DataMember = "CustomersOrders";
            }
            catch (Exception e)
            {
                MessageBox.Show("To run this example, replace the value of the " +
                    "connectionString variable with a connection string that is " +
                    "valid for your system.");
                Console.Error.WriteLine("[Form1.GetData()] Caught: " + e.Message);
            }
        }
    }
}