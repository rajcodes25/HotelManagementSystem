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

public partial class BooknowForm : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection("Data Source=LAPTOP-T1GQ836B;Initial Catalog=Hotel Management;Integrated Security=True");

    private void ShowMessage(String msg)
    {
        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('" + msg + "');</script>");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        lblroomid.Text = Request.QueryString["Roomid"];
        if (!IsPostBack)
        {

            BindReptr();
            txtName.Focus();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string idproofimg = "";
            if (FileUpload1.HasFile)
            {
                idproofimg = FileUpload1.FileName.ToString();
                FileUpload1.PostedFile.SaveAs(Server.MapPath("cimg/") + idproofimg);
            }

            // Check if the check-in date is a future date
            if (DateTime.Parse(txtCheckIn.Text) >= DateTime.Today)
            {
                // Check if there are any existing bookings with overlapping dates
                if (!IsOverlappingBooking(txtCheckIn.Text, txtCheckOut.Text))
                {
                    SqlCommand cmd = new SqlCommand("INSERT INTO Bookdetail (status,name,email,phone,age,adhar,checkin,checkout,roomid,date,noofchild,noofadult,idproof) VALUES (@status,@name,@email,@phone,@age,@adhar,@checkin,@checkout,@roomid,@date,@noofchild,@noofadult,@idproof)", con);
                    cmd.Parameters.AddWithValue("@name", txtName.Text);
                    cmd.Parameters.AddWithValue("@email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@phone", txtPhone.Text);
                    cmd.Parameters.AddWithValue("@age", txtAge.Text);
                    cmd.Parameters.AddWithValue("@adhar", txtAdharCard.Text);
                    cmd.Parameters.AddWithValue("@checkin", txtCheckIn.Text);
                    cmd.Parameters.AddWithValue("@checkout", txtCheckOut.Text);
                    cmd.Parameters.AddWithValue("@roomid", lblroomid.Text);
                    cmd.Parameters.AddWithValue("@date", DateTime.Now.ToString("dd-MM-yyyy"));
                    cmd.Parameters.AddWithValue("@noofchild", txtnc.Text);
                    cmd.Parameters.AddWithValue("@noofadult", txtna.Text);
                    cmd.Parameters.AddWithValue("@idproof", idproofimg);
                    cmd.Parameters.AddWithValue("@status", "Not Accept");

                    con.Open();
                    int res = cmd.ExecuteNonQuery();
                    con.Close();

                    if (res > 0)
                    {
                        ShowMessage("Data Submited Successfully");
                        //Response.Redirect("OurRoom.aspx");
                        ClearFields();
                    }
                    else
                    {
                        ShowMessage("Data Submited Failed");
                    }
                }
                else
                {
                    ShowMessage("There is already a booking with overlapping dates.");
                }
            }
            else
            {
                ShowMessage("Check-in date cannot be a past date.");
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }


    private bool IsOverlappingBooking(string checkin, string checkout)
    {
        bool overlapping = false;
        try
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM Bookdetail WHERE roomid = @roomid AND (checkin <= @checkout AND checkout >= @checkin)", con);
            cmd.Parameters.AddWithValue("@roomid", lblroomid.Text);
            cmd.Parameters.AddWithValue("@checkin", checkin);
            cmd.Parameters.AddWithValue("@checkout", checkout);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            overlapping = reader.HasRows;
            con.Close();
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
        return overlapping;
    }

    private void ClearFields()
    {
        txtName.Text = "";
        txtEmail.Text = "";
        txtPhone.Text = "";
        txtAge.Text = "";
        txtAdharCard.Text = "";
        txtnc.Text = "";
        txtna.Text = "";
        txtCheckIn.Text = "";
        txtCheckOut.Text = "";
    }



    private void BindReptr()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Select * from Addroom where Roomid='"+lblroomid.Text+"'", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                Repeater1.DataSource = dt;
                Repeater1.DataBind();
            }
            else
            {
                Repeater1.DataSource = null;
                Repeater1.DataBind();
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }
}