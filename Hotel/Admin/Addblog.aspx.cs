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

public partial class Admin_Addblog : System.Web.UI.Page
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
            string img2 = "";
            string img3 = "";

            if (FileUpload1.HasFile && FileUpload2.HasFile && FileUpload3.HasFile)
            {
                img = FileUpload1.FileName.ToString();
                FileUpload1.PostedFile.SaveAs(Server.MapPath("Blogimg/") + img);

                img2 = FileUpload2.FileName.ToString();
                FileUpload2.PostedFile.SaveAs(Server.MapPath("Blogimg/") + img2);

                img3 = FileUpload3.FileName.ToString();
                FileUpload3.PostedFile.SaveAs(Server.MapPath("Blogimg/") + img3);
            }

            SqlCommand cmd = new SqlCommand("INSERT INTO Addblog (blogimg,blogimg2,blogimg3,blogname,blogtitle,blogdesc,blogdate) VALUES (@blogimg,@blogimg2,@blogimg3,@blogname,@blogtitle,@blogdesc,@blogdate)", con);

           
            cmd.Parameters.AddWithValue("@blogimg", img);
            cmd.Parameters.AddWithValue("@blogimg2", img2);
            cmd.Parameters.AddWithValue("@blogimg3", img3);
            cmd.Parameters.AddWithValue("@blogname", txtbname.Text);
            cmd.Parameters.AddWithValue("@blogtitle", txtbtitle.Text);
            cmd.Parameters.AddWithValue("@blogdesc", txtbdesc.Text);
            cmd.Parameters.AddWithValue("@blogdate", txtbdate.Text);
            
            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Successfully send');window.location='Addblog.aspx';", true);
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