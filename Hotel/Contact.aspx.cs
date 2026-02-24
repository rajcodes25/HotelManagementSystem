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

public partial class Contact : System.Web.UI.Page
{

    SqlConnection con = new SqlConnection("Data Source=LAPTOP-T1GQ836B;Initial Catalog=Hotel Management;Integrated Security=True");
    private void ShowMessage(String msg)
    {
        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('" + msg + "');</script>");
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("INSERT INTO contacttable (conname,conemail,conphone,conmsg,condate,status) VALUES (@conname,@conemail,@conphone,@conmsg,@condate,@status)", con);
            cmd.Parameters.AddWithValue("@conname", txtName.Text);
            cmd.Parameters.AddWithValue("@conemail", txtEmail.Text);
            cmd.Parameters.AddWithValue("@conphone", txtPhoneNumber.Text);
            cmd.Parameters.AddWithValue("@conmsg", txtMessage.Text);
            cmd.Parameters.AddWithValue("@condate", DateTime.Now.ToString("dd-MM-yyyy"));
            cmd.Parameters.AddWithValue("@status","Pending..." );

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if (res > 0)
            {
                // Show success message using JavaScript
                // ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "showSuccess();", true);
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Contact Send Successfuly Thank You');window.location='Contact.aspx';", true);

            }
            else
            {
                ShowMessage("Contact Failed Please Try again");
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }
}