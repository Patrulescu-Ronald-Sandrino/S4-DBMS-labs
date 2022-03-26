namespace A1
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.coffeeShopDBDataSet = new A1.CoffeeShopDBDataSet();
            this.coffeeShopDBDataSetBindingSource = new System.Windows.Forms.BindingSource(this.components);
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.coffeeShopDBDataSet)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.coffeeShopDBDataSetBindingSource)).BeginInit();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(621, 67);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(131, 53);
            this.button1.TabIndex = 0;
            this.button1.Text = "Connect";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(612, 247);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(148, 64);
            this.button2.TabIndex = 1;
            this.button2.Text = "Update DB";
            this.button2.UseVisualStyleBackColor = true;
            // 
            // dataGridView1
            // 
            this.dataGridView1.AutoGenerateColumns = false;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.DataSource = this.coffeeShopDBDataSetBindingSource;
            this.dataGridView1.Location = new System.Drawing.Point(42, 48);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.Size = new System.Drawing.Size(354, 142);
            this.dataGridView1.TabIndex = 2;
            // 
            // coffeeShopDBDataSet
            // 
            this.coffeeShopDBDataSet.DataSetName = "CoffeeShopDBDataSet";
            this.coffeeShopDBDataSet.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // coffeeShopDBDataSetBindingSource
            // 
            this.coffeeShopDBDataSetBindingSource.DataSource = this.coffeeShopDBDataSet;
            this.coffeeShopDBDataSetBindingSource.Position = 0;
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.dataGridView1);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Name = "Form1";
            this.Text = "Form1";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.coffeeShopDBDataSet)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.coffeeShopDBDataSetBindingSource)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.BindingSource coffeeShopDBDataSetBindingSource;
        private CoffeeShopDBDataSet coffeeShopDBDataSet;
    }
}

