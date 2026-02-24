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
public partial class Admin_Roombooking : System.Web.UI.Page
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
            SqlCommand cmd = new SqlCommand("SELECT b.*, a.rnum,a.rnum,a.rprice,a.rtype,a.bedtype,a.rcatg FROM Bookdetail b INNER JOIN Addroom a ON b.[roomid] = a.[Roomid] WHERE b.bookid = '" + name + "'", con);

            SqlCommand cmd1 = new SqlCommand("SELECT idproof FROM Bookdetail WHERE bookid = @name", con);
            cmd.Parameters.AddWithValue("@BookingId", name);

            object result = cmd.ExecuteScalar();
            if (result != null)
            {
                // If a record with the provided booking ID exists, set the visibility of idimage to true
                idimage.Visible = true;
                ddlstatus.Visible = true;
                lblstts.Visible = true;
                

                ddlroomno.Visible = false;
                txtrno.Visible = true;
                //idimage.ImageUrl = "/cimg/" + result.ToString();
            }
            else
            {
                // If no record with the provided booking ID exists, hide the imagex
                idimage.Visible = false;
                ddlstatus.Visible = false;
                lblstts.Visible = false;

                ddlroomno.Visible = true;
                txtrno.Visible = false;
            }


            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblcancelorder.Text = ds.Tables[0].Rows[0]["status"].ToString();
                if(lblcancelorder.Text=="CANCELLED BOOKING")
                {
                    ShowMessage("This Person has cancelled his booking");
                   // btnadd.Visible = false;
                    btnupdate.Visible = false;
                }
                else
                {
                    btnupdate.Visible = true;
                }
                txtcname.Text = ds.Tables[0].Rows[0]["name"].ToString();
                txtphone.Text = ds.Tables[0].Rows[0]["phone"].ToString();
                txtadhar.Text = ds.Tables[0].Rows[0]["adhar"].ToString();
                txtemail.Text = ds.Tables[0].Rows[0]["email"].ToString();
                txtnc.Text = ds.Tables[0].Rows[0]["noofchild"].ToString();
                txtna.Text = ds.Tables[0].Rows[0]["noofadult"].ToString();
                txtage.Text = ds.Tables[0].Rows[0]["age"].ToString();

                idimage.ImageUrl = "/cimg/" + ds.Tables[0].Rows[0]["idproof"].ToString();

                ddlrtype.SelectedValue = ds.Tables[0].Rows[0]["rtype"].ToString();
                ddlbedtype.SelectedValue = ds.Tables[0].Rows[0]["bedtype"].ToString();
                ddlrcatg.SelectedValue = ds.Tables[0].Rows[0]["rcatg"].ToString();

                txtrno.Text = ds.Tables[0].Rows[0]["rnum"].ToString();

                txtpay.Text = ds.Tables[0].Rows[0]["rprice"].ToString();
                txtcheckin.Text = ds.Tables[0].Rows[0]["checkin"].ToString();
                txtcheckout.Text = ds.Tables[0].Rows[0]["checkout"].ToString();
            }
            else
            {
                // If the Customer ID does not exist, clear the fields
                txtcname.Text = "";
                txtphone.Text = "";
                txtadhar.Text = "";
                txtemail.Text = "";
                txtage.Text = "";
                txtnc.Text = "";
                txtna.Text = "";
                txtrno.Text = "";
                ddlrtype.SelectedIndex = -1;
                ddlbedtype.SelectedIndex = -1;
                ddlrcatg.SelectedIndex = -1;

                txtpay.Text = "";
                txtcheckin.Text = "";
                txtcheckout.Text = "";
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

                if(ddlstatus.SelectedValue=="REJECT")
                {
                    ShowMessage("REJECTED SUCCESSFULLY");
                }
                ShowMessage("Check In Successfully");
                txtbid.Text = "";
                txtcname.Text = "";
                idimage.Visible=false;
                txtphone.Text = "";
                txtadhar.Text = "";
                txtemail.Text = "";
                txtnc.Text = "";
                txtna.Text = "";
                ddlrtype.SelectedValue = "0";
                ddlbedtype.SelectedValue = "0";
                ddlrcatg.SelectedValue = "0";
                txtrno.Text= "";
                txtpay.Text = "";
                txtcheckin.Text = "";
                txtcheckout.Text = "";
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



    //protected void txtrno_TextChanged(object sender, EventArgs e)
    //{
    //    try
    //    {
    //        string roomnum = txtrno.Text.Trim();
    //        //SqlCommand cmd = new SqlCommand("SELECT b.*,a.rprice,a.rtype,a.bedtype,a.rcatg FROM Bookdetail b INNER JOIN Addroom a ON b.[roomid] = a.[Roomid] WHERE b.bookid = '" + roomnum + "'", con);
    //        SqlCommand cmd = new SqlCommand("select rtype,bedtype,rcatg,rprice from Addroom Where rnum='"+roomnum+"'",con);
    //        SqlDataAdapter da = new SqlDataAdapter(cmd);
    //        DataSet ds = new DataSet();
    //        da.Fill(ds);
    //        if (ds.Tables[0].Rows.Count > 0)
    //        {
    //            ddlrtype.SelectedValue = ds.Tables[0].Rows[0]["rtype"].ToString();
    //            ddlbedtype.SelectedValue = ds.Tables[0].Rows[0]["bedtype"].ToString();
    //            ddlrcatg.SelectedValue = ds.Tables[0].Rows[0]["rcatg"].ToString();
    //            txtpay.Text = ds.Tables[0].Rows[0]["rprice"].ToString();
    //        }
    //        else
    //        {

    //        }
    //    }
    //    catch (Exception ex)
    //    {

    //        ShowMessage(ex.Message);
    //    }
    //}

    protected void btnadd_Click(object sender, EventArgs e)
    {
        try
        {
            string custimg = FileUpload1.FileName.ToString();
            FileUpload1.PostedFile.SaveAs(Server.MapPath("/cimg/") + custimg);
            
            //// Get the values from the form controls
            //string name = txtcname.Text.Trim();
            //string email = txtemail.Text.Trim();
            //string phone = txtphone.Text.Trim();
            //string adhar = txtaddress.Text.Trim();
            //string checkin = txtcheckin.Text.Trim();
            //string checkout = txtcheckout.Text.Trim();
            //string roomid = ddlroomno.SelectedValue; // Assuming you want to get the selected room ID
            //string date = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"); // Assuming you want to insert the current date/time
            //string noofchild = txtnc.Text.Trim();
            //string noofadult = txtna.Text.Trim();
            //string idproof = custimg; // You may need to handle the file upload to get the ID proof filename
            //string status = ddlstatus.SelectedValue;

            //// Construct the SQL INSERT statement
            //string insertQuery = "INSERT INTO Bookdetail (name, email, phone, adhar, checkin, checkout, roomid, date, noofchild, noofadult, idproof, status) " +
            //                     "VALUES (@name, @email, @phone, @adhar, @checkin, @checkout, @roomid, @date, @noofchild, @noofadult, @idproof, @status)";

            //// Create a new SqlCommand object with the insert query and connection
            //SqlCommand cmd = new SqlCommand(insertQuery, con);

            //// Add parameters to the command to prevent SQL injection and improve security
            //cmd.Parameters.AddWithValue("@name", name);
            //cmd.Parameters.AddWithValue("@email", email);
            //cmd.Parameters.AddWithValue("@phone", phone);
            //cmd.Parameters.AddWithValue("@adhar", adhar);
            //cmd.Parameters.AddWithValue("@checkin", checkin);
            //cmd.Parameters.AddWithValue("@checkout", checkout);
            //cmd.Parameters.AddWithValue("@roomid", roomid);
            //cmd.Parameters.AddWithValue("@date", date);
            //cmd.Parameters.AddWithValue("@noofchild", noofchild);
            //cmd.Parameters.AddWithValue("@noofadult", noofadult);
            //cmd.Parameters.AddWithValue("@idproof", idproof);
            //cmd.Parameters.AddWithValue("@status", status);

            //// Open the connection
            //con.Open();

            //// Execute the insert query
            //int rowsAffected = cmd.ExecuteNonQuery();

            //// Close the connection
            //con.Close();

            //// Check if the insert operation was successful
            //if (rowsAffected > 0)
            //{
            //    // Show a success message
            //    ShowMessage("Booking added successfully!");
            //}
            //else
            //{
            //    // Show an error message
            //    ShowMessage("Failed to add booking!");
            //}

            SqlCommand cmd = new SqlCommand("INSERT INTO Bookdetail (name,phone,adhar,email,age,checkin,checkout,roomid,date,noofchild,noofadult,idproof,status) VALUES(@name,@phone,@adhar,@email,@age,@checkin,@checkout,@roomid,@date,@noofchild,@noofadult,@idproof,@status)", con);
            cmd.Parameters.AddWithValue("@name", txtcname.Text);

            cmd.Parameters.AddWithValue("@phone", txtphone.Text);
            cmd.Parameters.AddWithValue("@adhar", txtadhar.Text);
            cmd.Parameters.AddWithValue("@email", txtemail.Text);
            
            cmd.Parameters.AddWithValue("@age", txtage.Text);
            cmd.Parameters.AddWithValue("@noofchild", txtnc.Text);
            cmd.Parameters.AddWithValue("@noofadult", txtna.Text);

            cmd.Parameters.AddWithValue("@checkin", txtcheckin.Text);
            cmd.Parameters.AddWithValue("@checkout", txtcheckout.Text);
            cmd.Parameters.AddWithValue("@roomid", lblroomid.Text);


            cmd.Parameters.AddWithValue("@date", DateTime.Now.ToString("dd-MM-yyyy"));

            //cmd.Parameters.AddWithValue("@noofchild", txtnc.Text);
            //cmd.Parameters.AddWithValue("@noofadult", txtna.Text);

            cmd.Parameters.AddWithValue("@idproof", custimg);
            cmd.Parameters.AddWithValue("@status", ddlstatus.SelectedValue);

            con.Open();
            int res=cmd.ExecuteNonQuery();
            con.Close();

            if(res>0)
            {
                ShowMessage("Room Book Successfully");

                txtbid.Text = "";
                txtcname.Text = "";
                txtphone.Text = "";
                txtadhar.Text = "";
                txtemail.Text = "";
                txtage.Text = "";
                txtnc.Text ="";
                txtna.Text="";
                txtcheckin .Text= "";
                txtcheckout.Text= "";
                ddlroomno.SelectedIndex = -1;
                ddlrtype.SelectedIndex = -1;
                ddlbedtype.SelectedIndex = -1;
                ddlrcatg.SelectedIndex = -1;
                txtpay.Text = "";

                txtcheckin.Text = "";
                txtcheckout.Text = "";
                ddlstatus.SelectedIndex = -1;
                
            }
            else
            {
                ShowMessage("Failed!!!!!");
            }



        }
        catch (Exception ex)
        {
            // Handle any exceptions and show an error message
            ShowMessage("An error occurred: " + ex.Message);
        }
    }

    //string custimg = FileUpload1.FileName.ToString();
    //FileUpload1.PostedFile.SaveAs(Server.MapPath("cimg/") + custimg);

        

    protected void BookingType_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            if (rdb1.Checked)
            {
                txtbid.Enabled = true;
                // Enable other input fields similarly
                string nextBookingId = GetNextBookingIdFromDatabase();
                txtbid.Text = nextBookingId;
                txtbid.ReadOnly = true;
                txtrno.Visible = false;
                ddlroomno.Visible = true;


                txtcname.Text = "";
                idimage.Visible = false;

                txtphone.Text = "";
                txtadhar.Text = "";
                txtemail.Text = "";

                txtnc.Text = "";
                txtna.Text = "";
                txtage.Text = "";

                ddlroomno.SelectedIndex = -1;
                ddlrtype.SelectedIndex = -1;
                ddlbedtype.SelectedIndex = -1;

                ddlrcatg.SelectedIndex = -1;
                txtpay.Text = "";

                txtcheckin.Text = "";
                txtcheckout.Text = "";

                FileUpload1.Visible = true;

                btnadd.Visible = true;
                btnupdate.Visible = false;

                SqlCommand cmd = new SqlCommand("SELECT rnum from Addroom WHERE bookingstatus='Vacant'", con);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    ddlroomno.DataSource = dt;
                    ddlroomno.DataTextField = "rnum";
                    ddlroomno.DataValueField = "rnum";
                    ddlroomno.DataBind();
                    ddlroomno.Items.Insert(0, new ListItem("Select room no", "0"));
                    ddlroomno.SelectedIndex = 0;
                }
            }
            else if (rdb2.Checked)
            {
                //  txtbid.Text = string.Empty; // Clear the txtbid textbox for Online Booking
                txtbid.Text = "";
                txtbid.ReadOnly = false;
                txtrno.Visible = true;
                ddlroomno.Visible = false;

                FileUpload1.Visible = false;

                btnadd.Visible = false;
                btnupdate.Visible = true;
            }
            else
            {
                ShowMessage("SOMETHING WRONG");
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }

    private string GetNextBookingIdFromDatabase()
    {
        string nextBookingId = string.Empty;
        SqlCommand cmd=new SqlCommand("SELECT TOP 1 bookid FROM Bookdetail ORDER BY bookid DESC",con);
        con.Open();
                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.Read())
                    {
                        int lastBookingId = reader.GetInt32(0);
                        nextBookingId = (lastBookingId + 1).ToString();
                    }
                    else
                    {
                        nextBookingId = "1";
                    }
                }
            return nextBookingId;
    }

    protected void ddlroomno_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("SELECT rtype,bedtype,rcatg,rprice,Roomid FROM Addroom WHERE rnum='"+ddlroomno.SelectedValue+"'",con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            da.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                lblroomid.Text = ds.Tables[0].Rows[0]["Roomid"].ToString();
                ddlrtype.SelectedValue = ds.Tables[0].Rows[0]["rtype"].ToString();
                ddlbedtype.SelectedValue = ds.Tables[0].Rows[0]["bedtype"].ToString();
                ddlrcatg.SelectedValue = ds.Tables[0].Rows[0]["rcatg"].ToString();
                txtpay.Text = ds.Tables[0].Rows[0]["rprice"].ToString();
                divstatus.Focus();
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);

        }
    }
}