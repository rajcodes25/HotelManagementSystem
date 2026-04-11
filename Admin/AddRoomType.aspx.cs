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

public partial class Admin_AddRoomType : System.Web.UI.Page
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
             SqlCommand cmd = new SqlCommand("INSERT into Addroomtype (Roomtype,date) VALUES (@Roomtype,@date)", con);
           
            cmd.Parameters.AddWithValue("@Roomtype", txtrtype.Text);
           
            cmd.Parameters.AddWithValue("@date", DateTime.Now.ToString("dd-MM-yyyy"));

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if(res>0)
            {
                ShowMessage("Room Added Successfully");
                txtrtype.Text = "";
                txtdate.Text = "";

            }
            else
            {
                ShowMessage("Room Added Failed");
            }
        }
        catch (Exception ex) 
        {
            ShowMessage(ex.Message);
        }
    }
}