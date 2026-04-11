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

public partial class Admin_Checkout : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection("Data Source=LAPTOP-T1GQ836B;Initial Catalog=Hotel Management;Integrated Security=True");

    private void ShowMessage(String msg)
    {
        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('" + msg + "');</script>");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // By default, hide the image
            idimage.Visible = false;
        }
    }

    protected void txtbid_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string name = txtbid.Text.Trim();
            con.Open();
            // Check if the Customer ID exists in the database
            SqlCommand cmd = new SqlCommand("SELECT b.*, a.rnum,a.rprice,a.rtype,a.bedtype,a.rcatg FROM Bookdetail b INNER JOIN Addroom a ON b.[roomid] = a.[Roomid] WHERE b.bookid = '" + name + "' AND status='CHECK IN'", con);

            SqlCommand cmd1 = new SqlCommand("SELECT idproof FROM Bookdetail WHERE bookid = @name", con);
            cmd.Parameters.AddWithValue("@BookingId", name);

            object result = cmd.ExecuteScalar();
            if (result != null)
            {
                // If a record with the provided booking ID exists, set the visibility of idimage to true
                idimage.Visible = true;
                //idimage.ImageUrl = "/cimg/" + result.ToString();
            }
            else
            {
                // If no record with the provided booking ID exists, hide the imagex
                idimage.Visible = false;
                ShowMessage("No Any Data");
                txtbid.Text = "";
               
            }


            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblcname.Text = ds.Tables[0].Rows[0]["name"].ToString();
                lblphone.Text = ds.Tables[0].Rows[0]["phone"].ToString();
                lbladhar.Text = ds.Tables[0].Rows[0]["adhar"].ToString();
                lblemail.Text = ds.Tables[0].Rows[0]["email"].ToString();
                lblnc.Text = ds.Tables[0].Rows[0]["noofchild"].ToString();
                lblna.Text = ds.Tables[0].Rows[0]["noofadult"].ToString();

                idimage.ImageUrl = "../cimg/" + ds.Tables[0].Rows[0]["idproof"].ToString();
                lblrtype.Text= ds.Tables[0].Rows[0]["rtype"].ToString();
                lblbedtype.Text= ds.Tables[0].Rows[0]["bedtype"].ToString();
                lblrcatg.Text= ds.Tables[0].Rows[0]["rcatg"].ToString();
                //ddlrtype.SelectedValue = ds.Tables[0].Rows[0]["rtype"].ToString();
                // ddlbedtype.SelectedValue = ds.Tables[0].Rows[0]["bedtype"].ToString();
                //ddlrcatg.SelectedValue = ds.Tables[0].Rows[0]["rcatg"].ToString();
                lblrno.Text = ds.Tables[0].Rows[0]["rnum"].ToString();
                lbltpay.Text = ds.Tables[0].Rows[0]["rprice"].ToString();
                lblcindate.Text = ds.Tables[0].Rows[0]["checkin"].ToString();
                lblcoutdate.Text = ds.Tables[0].Rows[0]["checkout"].ToString();
            }
            else
            {
                // If the Customer ID does not exist, clear the fields
                lblcname.Text = "";
                lblphone.Text = "";
                lbladhar.Text = "";
                lblemail.Text = "";
                lblnc.Text = "";
                lblna.Text = "";
                // Clear the FileUpload control if the Customer ID is not found
                //FileUpload1.FileName = "";
                // Similarly, clear other fields as needed
            }
            con.Close();
        }
        catch (Exception ex)
        {
            // Handle the exception
            ShowMessage(ex.Message);
        }
        finally
        {
            con.Close();
        }
    }

    protected void btnupdate_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("UPDATE Bookdetail SET status=@status WHERE bookid=@bookid", con);
            cmd.Parameters.AddWithValue("@status", ddlstatus.SelectedItem.Text); // Use SelectedItem.Text to get the text of the selected item
            cmd.Parameters.AddWithValue("@bookid", txtbid.Text);

            con.Open();
            int rowsAffected = cmd.ExecuteNonQuery();
            con.Close();

            if (rowsAffected > 0)
            {
                ShowMessage("Check OUT Successfully");
                txtbid.Text = "";
                lblcname.Text = "";
                idimage.Visible = false;
                lblphone.Text = "";
                lbladhar.Text = "";
                lblemail.Text = "";
                lblnc.Text = "";
                lblna.Text = "";
                lblrtype.Text = "";
                lblbedtype.Text = "";
                lblrcatg.Text = "";
                lblrno.Text = "";
                lbltpay.Text = "";
                lblcindate.Text = "";
                lblcoutdate.Text = "";
                ddlstatus.SelectedValue = "";
            }
            else
            {
                ShowMessage("Check In Failed!!");
            }
        }
        catch (Exception ex)
        {
            ShowMessage("An error occurred: " + ex.Message);
        }
        finally
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
    }
}