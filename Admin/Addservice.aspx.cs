using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;


public partial class Admin_Addservice : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection("Data Source=LAPTOP-T1GQ836B;Initial Catalog=Hotel Management;Integrated Security=True");

    private void ShowMessage(String msg)
    {
        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('" + msg + "');</script>");
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string img = "";
            if (FileUpload1.HasFile)
            {
                img = FileUpload1.FileName.ToString();
                FileUpload1.PostedFile.SaveAs(Server.MapPath("Serviceimg/") + img);
            }

            SqlCommand cmd = new SqlCommand("INSERT INTO Addservice (servicename,serviceimg,servicedesc,date) VALUES (@servicename,@serviceimg,@servicedesc,@date)", con);
            cmd.Parameters.AddWithValue("@servicename", txtsname.Text);
            cmd.Parameters.AddWithValue("@servicedesc", txtsdesc.Text);
            cmd.Parameters.AddWithValue("@serviceimg", img);
            cmd.Parameters.AddWithValue("@date", DateTime.Now.ToString("dd-MM-yyyy"));

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Successfully send');window.location='Addservice.aspx';", true);
            }
            else
            {
                ShowMessage("Room Add Failed");
            }
        }
        catch (Exception ex)
        {

            ShowMessage(ex.Message);
        }
    }
}