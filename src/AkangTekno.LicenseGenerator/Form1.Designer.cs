namespace AkangTekno.LicenseGenerator
{
    partial class FrmLicenseGenerator
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
            this.gbAktivasi = new System.Windows.Forms.GroupBox();
            this.btnGenerate = new System.Windows.Forms.Button();
            this.rbPermanent = new System.Windows.Forms.RadioButton();
            this.rb1Tahun = new System.Windows.Forms.RadioButton();
            this.txtNamaCustomer = new System.Windows.Forms.TextBox();
            this.txtMachineId = new System.Windows.Forms.TextBox();
            this.label8 = new System.Windows.Forms.Label();
            this.lblCustomer = new System.Windows.Forms.Label();
            this.lblExpired = new System.Windows.Forms.Label();
            this.label4 = new System.Windows.Forms.Label();
            this.lblJenisLisensi = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.lblMachineId = new System.Windows.Forms.Label();
            this.gbHasil = new System.Windows.Forms.GroupBox();
            this.btnCopy = new System.Windows.Forms.Button();
            this.txtPayload = new System.Windows.Forms.TextBox();
            this.txtLicenseKey = new System.Windows.Forms.TextBox();
            this.lblPayload = new System.Windows.Forms.Label();
            this.lblLicenseKey = new System.Windows.Forms.Label();
            this.rb2Tahun = new System.Windows.Forms.RadioButton();
            this.gbAktivasi.SuspendLayout();
            this.gbHasil.SuspendLayout();
            this.SuspendLayout();
            // 
            // gbAktivasi
            // 
            this.gbAktivasi.Controls.Add(this.rb2Tahun);
            this.gbAktivasi.Controls.Add(this.btnGenerate);
            this.gbAktivasi.Controls.Add(this.rbPermanent);
            this.gbAktivasi.Controls.Add(this.rb1Tahun);
            this.gbAktivasi.Controls.Add(this.txtNamaCustomer);
            this.gbAktivasi.Controls.Add(this.txtMachineId);
            this.gbAktivasi.Controls.Add(this.label8);
            this.gbAktivasi.Controls.Add(this.lblCustomer);
            this.gbAktivasi.Controls.Add(this.lblExpired);
            this.gbAktivasi.Controls.Add(this.label4);
            this.gbAktivasi.Controls.Add(this.lblJenisLisensi);
            this.gbAktivasi.Controls.Add(this.label2);
            this.gbAktivasi.Controls.Add(this.lblMachineId);
            this.gbAktivasi.Location = new System.Drawing.Point(12, 12);
            this.gbAktivasi.Name = "gbAktivasi";
            this.gbAktivasi.Size = new System.Drawing.Size(764, 195);
            this.gbAktivasi.TabIndex = 0;
            this.gbAktivasi.TabStop = false;
            this.gbAktivasi.Text = "Aktivasi Generate";
            // 
            // btnGenerate
            // 
            this.btnGenerate.Location = new System.Drawing.Point(36, 158);
            this.btnGenerate.Name = "btnGenerate";
            this.btnGenerate.Size = new System.Drawing.Size(142, 23);
            this.btnGenerate.TabIndex = 13;
            this.btnGenerate.Text = "Generate Key";
            this.btnGenerate.UseVisualStyleBackColor = true;
            this.btnGenerate.Click += new System.EventHandler(this.btnGenerate_Click);
            // 
            // rbPermanent
            // 
            this.rbPermanent.AutoSize = true;
            this.rbPermanent.Location = new System.Drawing.Point(273, 65);
            this.rbPermanent.Name = "rbPermanent";
            this.rbPermanent.Size = new System.Drawing.Size(76, 17);
            this.rbPermanent.TabIndex = 11;
            this.rbPermanent.Text = "Permanent";
            this.rbPermanent.UseVisualStyleBackColor = true;
            // 
            // rb1Tahun
            // 
            this.rb1Tahun.AutoSize = true;
            this.rb1Tahun.Checked = true;
            this.rb1Tahun.Location = new System.Drawing.Point(106, 65);
            this.rb1Tahun.Name = "rb1Tahun";
            this.rb1Tahun.Size = new System.Drawing.Size(72, 17);
            this.rb1Tahun.TabIndex = 10;
            this.rb1Tahun.TabStop = true;
            this.rb1Tahun.Text = "1 TAHUN";
            this.rb1Tahun.UseVisualStyleBackColor = true;
            // 
            // txtNamaCustomer
            // 
            this.txtNamaCustomer.Location = new System.Drawing.Point(106, 132);
            this.txtNamaCustomer.Name = "txtNamaCustomer";
            this.txtNamaCustomer.Size = new System.Drawing.Size(203, 20);
            this.txtNamaCustomer.TabIndex = 9;
            // 
            // txtMachineId
            // 
            this.txtMachineId.Location = new System.Drawing.Point(106, 26);
            this.txtMachineId.Name = "txtMachineId";
            this.txtMachineId.Size = new System.Drawing.Size(641, 20);
            this.txtMachineId.TabIndex = 8;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(89, 132);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(10, 13);
            this.label8.TabIndex = 7;
            this.label8.Text = ":";
            this.label8.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // lblCustomer
            // 
            this.lblCustomer.AutoSize = true;
            this.lblCustomer.Location = new System.Drawing.Point(6, 132);
            this.lblCustomer.Name = "lblCustomer";
            this.lblCustomer.Size = new System.Drawing.Size(82, 13);
            this.lblCustomer.TabIndex = 6;
            this.lblCustomer.Text = "Nama Customer";
            this.lblCustomer.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // lblExpired
            // 
            this.lblExpired.AutoSize = true;
            this.lblExpired.Location = new System.Drawing.Point(15, 98);
            this.lblExpired.Name = "lblExpired";
            this.lblExpired.Size = new System.Drawing.Size(10, 13);
            this.lblExpired.TabIndex = 5;
            this.lblExpired.Text = "-";
            this.lblExpired.TextAlign = System.Drawing.ContentAlignment.MiddleRight;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(89, 61);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(10, 13);
            this.label4.TabIndex = 3;
            this.label4.Text = ":";
            // 
            // lblJenisLisensi
            // 
            this.lblJenisLisensi.AutoSize = true;
            this.lblJenisLisensi.Location = new System.Drawing.Point(6, 61);
            this.lblJenisLisensi.Name = "lblJenisLisensi";
            this.lblJenisLisensi.Size = new System.Drawing.Size(66, 13);
            this.lblJenisLisensi.TabIndex = 2;
            this.lblJenisLisensi.Text = "Jenis Lisensi";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(89, 26);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(10, 13);
            this.label2.TabIndex = 1;
            this.label2.Text = ":";
            // 
            // lblMachineId
            // 
            this.lblMachineId.AutoSize = true;
            this.lblMachineId.Location = new System.Drawing.Point(6, 26);
            this.lblMachineId.Name = "lblMachineId";
            this.lblMachineId.Size = new System.Drawing.Size(62, 13);
            this.lblMachineId.TabIndex = 0;
            this.lblMachineId.Text = "Machine ID";
            // 
            // gbHasil
            // 
            this.gbHasil.Controls.Add(this.btnCopy);
            this.gbHasil.Controls.Add(this.txtPayload);
            this.gbHasil.Controls.Add(this.txtLicenseKey);
            this.gbHasil.Controls.Add(this.lblPayload);
            this.gbHasil.Controls.Add(this.lblLicenseKey);
            this.gbHasil.Location = new System.Drawing.Point(12, 224);
            this.gbHasil.Name = "gbHasil";
            this.gbHasil.Size = new System.Drawing.Size(764, 214);
            this.gbHasil.TabIndex = 1;
            this.gbHasil.TabStop = false;
            this.gbHasil.Text = "Hasil";
            // 
            // btnCopy
            // 
            this.btnCopy.Location = new System.Drawing.Point(113, 99);
            this.btnCopy.Name = "btnCopy";
            this.btnCopy.Size = new System.Drawing.Size(128, 23);
            this.btnCopy.TabIndex = 4;
            this.btnCopy.Text = "Copy License Key";
            this.btnCopy.UseVisualStyleBackColor = true;
            // 
            // txtPayload
            // 
            this.txtPayload.Location = new System.Drawing.Point(113, 64);
            this.txtPayload.Multiline = true;
            this.txtPayload.Name = "txtPayload";
            this.txtPayload.ReadOnly = true;
            this.txtPayload.Size = new System.Drawing.Size(180, 20);
            this.txtPayload.TabIndex = 3;
            // 
            // txtLicenseKey
            // 
            this.txtLicenseKey.Location = new System.Drawing.Point(113, 26);
            this.txtLicenseKey.Name = "txtLicenseKey";
            this.txtLicenseKey.ReadOnly = true;
            this.txtLicenseKey.Size = new System.Drawing.Size(418, 20);
            this.txtLicenseKey.TabIndex = 2;
            // 
            // lblPayload
            // 
            this.lblPayload.AutoSize = true;
            this.lblPayload.Location = new System.Drawing.Point(6, 60);
            this.lblPayload.Name = "lblPayload";
            this.lblPayload.Size = new System.Drawing.Size(45, 13);
            this.lblPayload.TabIndex = 1;
            this.lblPayload.Text = "Payload";
            // 
            // lblLicenseKey
            // 
            this.lblLicenseKey.AutoSize = true;
            this.lblLicenseKey.Location = new System.Drawing.Point(6, 26);
            this.lblLicenseKey.Name = "lblLicenseKey";
            this.lblLicenseKey.Size = new System.Drawing.Size(65, 13);
            this.lblLicenseKey.TabIndex = 0;
            this.lblLicenseKey.Text = "License Key";
            // 
            // rb2Tahun
            // 
            this.rb2Tahun.AutoSize = true;
            this.rb2Tahun.Location = new System.Drawing.Point(195, 65);
            this.rb2Tahun.Name = "rb2Tahun";
            this.rb2Tahun.Size = new System.Drawing.Size(72, 17);
            this.rb2Tahun.TabIndex = 14;
            this.rb2Tahun.TabStop = true;
            this.rb2Tahun.Text = "2 TAHUN";
            this.rb2Tahun.UseVisualStyleBackColor = true;
            // 
            // FrmLicenseGenerator
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.gbHasil);
            this.Controls.Add(this.gbAktivasi);
            this.Name = "FrmLicenseGenerator";
            this.Text = "Akang Tekno Generate";
            this.gbAktivasi.ResumeLayout(false);
            this.gbAktivasi.PerformLayout();
            this.gbHasil.ResumeLayout(false);
            this.gbHasil.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox gbAktivasi;
        private System.Windows.Forms.TextBox txtNamaCustomer;
        private System.Windows.Forms.TextBox txtMachineId;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.Label lblCustomer;
        private System.Windows.Forms.Label lblExpired;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label lblJenisLisensi;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label lblMachineId;
        private System.Windows.Forms.RadioButton rbPermanent;
        private System.Windows.Forms.RadioButton rb1Tahun;
        private System.Windows.Forms.Button btnGenerate;
        private System.Windows.Forms.GroupBox gbHasil;
        private System.Windows.Forms.TextBox txtPayload;
        private System.Windows.Forms.TextBox txtLicenseKey;
        private System.Windows.Forms.Label lblPayload;
        private System.Windows.Forms.Label lblLicenseKey;
        private System.Windows.Forms.Button btnCopy;
        private System.Windows.Forms.RadioButton rb2Tahun;
    }
}

