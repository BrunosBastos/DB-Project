namespace App
{
    partial class ViewReviews
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
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.UsernameRev = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.button2 = new System.Windows.Forms.Button();
            this.listBox1 = new System.Windows.Forms.ListBox();
            this.NumOfReviews = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.GameRev = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.UsernameRev);
            this.groupBox1.Controls.Add(this.label3);
            this.groupBox1.Controls.Add(this.button2);
            this.groupBox1.Controls.Add(this.listBox1);
            this.groupBox1.Controls.Add(this.NumOfReviews);
            this.groupBox1.Controls.Add(this.label2);
            this.groupBox1.Controls.Add(this.GameRev);
            this.groupBox1.Controls.Add(this.label1);
            this.groupBox1.Location = new System.Drawing.Point(13, 13);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(509, 395);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Reviews List";
            // 
            // UsernameRev
            // 
            this.UsernameRev.Location = new System.Drawing.Point(31, 181);
            this.UsernameRev.Name = "UsernameRev";
            this.UsernameRev.ReadOnly = true;
            this.UsernameRev.Size = new System.Drawing.Size(100, 20);
            this.UsernameRev.TabIndex = 7;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(28, 165);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(55, 13);
            this.label3.TabIndex = 6;
            this.label3.Text = "Username";
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(171, 326);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(314, 39);
            this.button2.TabIndex = 5;
            this.button2.Text = "View Selected Review Details";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.goToReviewDetails);
            // 
            // listBox1
            // 
            this.listBox1.FormattingEnabled = true;
            this.listBox1.Location = new System.Drawing.Point(171, 30);
            this.listBox1.Name = "listBox1";
            this.listBox1.Size = new System.Drawing.Size(314, 277);
            this.listBox1.TabIndex = 4;
            this.listBox1.SelectedIndexChanged += new System.EventHandler(this.changeReview);
            // 
            // NumOfReviews
            // 
            this.NumOfReviews.Location = new System.Drawing.Point(31, 125);
            this.NumOfReviews.Name = "NumOfReviews";
            this.NumOfReviews.ReadOnly = true;
            this.NumOfReviews.Size = new System.Drawing.Size(100, 20);
            this.NumOfReviews.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(31, 97);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(100, 13);
            this.label2.TabIndex = 2;
            this.label2.Text = "Number of Reviews";
            // 
            // GameRev
            // 
            this.GameRev.Location = new System.Drawing.Point(31, 58);
            this.GameRev.Name = "GameRev";
            this.GameRev.ReadOnly = true;
            this.GameRev.Size = new System.Drawing.Size(100, 20);
            this.GameRev.TabIndex = 1;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(28, 30);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(35, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Game";
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(196, 414);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(118, 23);
            this.button1.TabIndex = 1;
            this.button1.Text = "Close Reviews List";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.Close);
            // 
            // ViewReviews
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(539, 446);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.groupBox1);
            this.Name = "ViewReviews";
            this.Text = "ViewReviews";
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.ListBox listBox1;
        private System.Windows.Forms.TextBox NumOfReviews;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox GameRev;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.TextBox UsernameRev;
        private System.Windows.Forms.Label label3;
    }
}