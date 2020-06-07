namespace App
{
    partial class ViewProfile
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
            this.groupBox10 = new System.Windows.Forms.GroupBox();
            this.Unfollow = new System.Windows.Forms.Button();
            this.Follow = new System.Windows.Forms.Button();
            this.NFollowers = new System.Windows.Forms.TextBox();
            this.Username = new System.Windows.Forms.TextBox();
            this.label22 = new System.Windows.Forms.Label();
            this.label23 = new System.Windows.Forms.Label();
            this.label24 = new System.Windows.Forms.Label();
            this.NGames = new System.Windows.Forms.TextBox();
            this.button3 = new System.Windows.Forms.Button();
            this.groupBox10.SuspendLayout();
            this.SuspendLayout();
            // 
            // groupBox10
            // 
            this.groupBox10.Controls.Add(this.Unfollow);
            this.groupBox10.Controls.Add(this.Follow);
            this.groupBox10.Controls.Add(this.NFollowers);
            this.groupBox10.Controls.Add(this.Username);
            this.groupBox10.Controls.Add(this.label22);
            this.groupBox10.Controls.Add(this.label23);
            this.groupBox10.Controls.Add(this.label24);
            this.groupBox10.Controls.Add(this.NGames);
            this.groupBox10.Location = new System.Drawing.Point(12, 12);
            this.groupBox10.Name = "groupBox10";
            this.groupBox10.Size = new System.Drawing.Size(335, 168);
            this.groupBox10.TabIndex = 56;
            this.groupBox10.TabStop = false;
            this.groupBox10.Text = "User Profile";
            // 
            // Unfollow
            // 
            this.Unfollow.Location = new System.Drawing.Point(48, 106);
            this.Unfollow.Name = "Unfollow";
            this.Unfollow.Size = new System.Drawing.Size(100, 23);
            this.Unfollow.TabIndex = 52;
            this.Unfollow.Text = "Unfollow";
            this.Unfollow.UseVisualStyleBackColor = true;
            this.Unfollow.Click += new System.EventHandler(this.unfollow);
            // 
            // Follow
            // 
            this.Follow.Location = new System.Drawing.Point(48, 106);
            this.Follow.Name = "Follow";
            this.Follow.Size = new System.Drawing.Size(100, 23);
            this.Follow.TabIndex = 51;
            this.Follow.Text = "Follow";
            this.Follow.UseVisualStyleBackColor = true;
            this.Follow.Click += new System.EventHandler(this.follow);
            // 
            // NFollowers
            // 
            this.NFollowers.Location = new System.Drawing.Point(221, 49);
            this.NFollowers.Name = "NFollowers";
            this.NFollowers.ReadOnly = true;
            this.NFollowers.Size = new System.Drawing.Size(100, 20);
            this.NFollowers.TabIndex = 43;
            // 
            // Username
            // 
            this.Username.Location = new System.Drawing.Point(16, 49);
            this.Username.Name = "Username";
            this.Username.ReadOnly = true;
            this.Username.Size = new System.Drawing.Size(181, 20);
            this.Username.TabIndex = 36;
            // 
            // label22
            // 
            this.label22.AutoSize = true;
            this.label22.Location = new System.Drawing.Point(16, 30);
            this.label22.Name = "label22";
            this.label22.Size = new System.Drawing.Size(55, 13);
            this.label22.TabIndex = 47;
            this.label22.Text = "Username";
            // 
            // label23
            // 
            this.label23.AutoSize = true;
            this.label23.Location = new System.Drawing.Point(221, 90);
            this.label23.Name = "label23";
            this.label23.Size = new System.Drawing.Size(67, 13);
            this.label23.TabIndex = 46;
            this.label23.Text = "Nº of Games";
            // 
            // label24
            // 
            this.label24.AutoSize = true;
            this.label24.Location = new System.Drawing.Point(221, 30);
            this.label24.Name = "label24";
            this.label24.Size = new System.Drawing.Size(78, 13);
            this.label24.TabIndex = 45;
            this.label24.Text = "Nº of Followers";
            // 
            // NGames
            // 
            this.NGames.Location = new System.Drawing.Point(221, 109);
            this.NGames.Name = "NGames";
            this.NGames.ReadOnly = true;
            this.NGames.Size = new System.Drawing.Size(100, 20);
            this.NGames.TabIndex = 44;
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(149, 186);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(75, 23);
            this.button3.TabIndex = 55;
            this.button3.Text = "Close Profile";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.CloseProfile);
            // 
            // ViewProfile
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(361, 213);
            this.Controls.Add(this.groupBox10);
            this.Controls.Add(this.button3);
            this.Name = "ViewProfile";
            this.Text = "ViewProfile";
            this.groupBox10.ResumeLayout(false);
            this.groupBox10.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox10;
        private System.Windows.Forms.TextBox NFollowers;
        private System.Windows.Forms.TextBox Username;
        private System.Windows.Forms.Label label22;
        private System.Windows.Forms.Label label23;
        private System.Windows.Forms.Label label24;
        private System.Windows.Forms.TextBox NGames;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button Follow;
        private System.Windows.Forms.Button Unfollow;
    }
}