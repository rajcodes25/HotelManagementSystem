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

public partial class AdminDefault_AddRoom : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection("Data Source=LAPTOP-T1GQ836B;Initial Catalog=Hotel Management;Integrated Security=True");
    private void ShowMessage(String msg)
    {
        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('" + msg + "');</script>");
    }
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    
    //string vdo;

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        
        try
        {
            string img = "";
            if(FileUpload1.HasFile)
            {
               img= FileUpload1.FileName.ToString();
                FileUpload1.PostedFile.SaveAs(Server.MapPath("Roomimg/") + img);
            }

            // Check if room number already exists
            SqlCommand checkCmd = new SqlCommand("SELECT COUNT(*) FROM Addroom WHERE rnum = @rnum", con);
            checkCmd.Parameters.AddWithValue("@rnum", txtrno.Text);
            con.Open();
            int roomCount = (int)checkCmd.ExecuteScalar();
            con.Close();

            if (roomCount > 0)
            {
                ShowMessage("Room number already exists.");
                txtrno.Focus();
                return; // Exit the method
            }

            SqlCommand cmd = new SqlCommand("INSERT INTO Addroom (rnum,rprice,rtype,bedtype,rcatg,rdesc,rdate,room_image,bookingstatus) VALUES (@rnum,@rprice,@rtype,@bedtype,@rcatg,@rdesc,@rdate,@room_image,@bookingstatus)", con);

            //cmd.Parameters.AddWithValue("@Roomvideo", vdo);
            cmd.Parameters.AddWithValue("@rnum", txtrno.Text);
            cmd.Parameters.AddWithValue("@rprice", txtrprice.Text);
            cmd.Parameters.AddWithValue("@rtype", ddlrtype.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@bedtype", ddlbedtype.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@rcatg", ddlrcatg.SelectedValue.ToString());
            cmd.Parameters.AddWithValue("@rdesc", txtrdesc.Text);
            cmd.Parameters.AddWithValue("@rdate", txtdate.Text);
            cmd.Parameters.AddWithValue("@room_image", img);
            cmd.Parameters.AddWithValue("@bookingstatus", "Vacant");

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if (res > 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Successfully Add');window.location='AddRoom.aspx';", true);
                //ShowMessage("Room Added Successfully");

                //txtrno.Text = "";
                //txtrprice.Text = "";
                //ddlrtype.Text = "";
                //ddlbedtype.Text = "";
                //ddlrcatg.Text = "";
                //txtrdesc.Text = "";
                //txtdate.Text = "";
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