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


public partial class Admin_Boolkdetail : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection("Data Source=LAPTOP-T1GQ836B;Initial Catalog=Hotel Management;Integrated Security=True");

    //private void ShowMessage(String msg)
    //{
    //    ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('" + msg + "');</script>");
    //}

    private void ShowMessage(string msg)
    {
        string script = "ShowPopupMessage('" + msg + "');";
        ScriptManager.RegisterStartupScript(this, this.GetType(), "Popup", script, true);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGridData();
        }
    }
    private void BindGridData()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("SELECT bd.*,ar.Roomid,ar.rnum,ar.rprice,ar.rtype,ar.bedtype,ar.rcatg,ar.room_image FROM Bookdetail bd INNER JOIN Addroom ar ON bd.roomid = ar.Roomid", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = dt;
                GridView1.DataBind();
                
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }

    private void BindDataSearchEdit(string name, string phone)
    {
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM Bookdetail WHERE name = @name OR phone=@phone ", con);
            cmd.Parameters.AddWithValue("@name", name);
            cmd.Parameters.AddWithValue("@phone", phone);
           

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                // ShowMessage("DATA FOUNDED");
                GridView1.DataSource = dt;
                GridView1.DataBind();
            }
            else
            {
                // ShowMessage(" no any data !!!");
                GridView1.DataSource = null;
                GridView1.DataBind();
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }

    }


    protected void txtsearch_TextChanged(object sender, EventArgs e)
    {
        try
        {
            //string searchKeyword = txtsearch.Text.Trim();

            //if (!string.IsNullOrEmpty(searchKeyword))
            //{
            //    SqlCommand cmd = new SqlCommand("SELECT bd.*,ar.Roomid,ar.rnum,ar.rprice,ar.rtype,ar.bedtype,ar.rcatg,ar.room_image FROM Bookdetail bd INNER JOIN Addroom ar ON bd.roomid = ar.Roomid WHERE bd.name LIKE '%' + @search + '%' OR bd.phone LIKE '%' + @search + '%' OR bd.checkin LIKE '%' + @search + '%'", con);
            //    cmd.Parameters.AddWithValue("@search", searchKeyword);
            //    SqlDataAdapter da = new SqlDataAdapter(cmd);
            //    DataTable dt = new DataTable();
            //    da.Fill(dt);

            //    if (dt.Rows.Count > 0)
            //    {
            //        GridView1.DataSource = dt;
            //        GridView1.DataBind();
            //    }
            //    else
            //    {
            //        // No data found, display message
            //        ShowMessage("Data not found.");
            //        GridView1.DataSource = null;
            //        GridView1.DataBind();
            //    }
            //}
            //else
            //{
            //}

            string cname = txtsearch.Text.Trim();
            string phone = txtsearch.Text.Trim();

            BindDataSearchEdit(cname, phone);
            
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }

    }



    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        try
        {
           if(txtsearch.Text=="")
            {
                GridView1.EditIndex = e.NewEditIndex;
                BindGridData();
            }
            else
            {
                GridView1.EditIndex = e.NewEditIndex;
                BindDataSearchEdit(txtsearch.Text.Trim(), txtsearch.Text.Trim());
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        if (txtsearch.Text == "")
        {
            GridView1.EditIndex = -1;
            BindGridData();
        }
        else
        {
            GridView1.EditIndex = -1;
            BindDataSearchEdit(txtsearch.Text.Trim(), txtsearch.Text.Trim());
        }
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int idd = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            SqlCommand cmd = new SqlCommand("DELETE FROM Bookdetail WHERE bookid=@bookid", con);
            cmd.Parameters.AddWithValue("@bookid", idd);

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if (res > 0)
            {
                ShowMessage("Data Delete Sucessfully");
                BindGridData();
            }
            else
            {
                ShowMessage("Data delete failed!");
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }


    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int idup = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            // Find the DropDownList in the row being edited
            DropDownList ddlupstts = (DropDownList)GridView1.Rows[e.RowIndex].FindControl("ddlupstts");

            if (ddlupstts != null)
            {
                SqlCommand cmd = new SqlCommand("UPDATE Bookdetail SET status=@status WHERE bookid=@bookid", con);
                cmd.Parameters.AddWithValue("@status", ddlupstts.SelectedValue);
                cmd.Parameters.AddWithValue("@bookid", idup);

                con.Open();
                int res = cmd.ExecuteNonQuery();
                con.Close();

                if (res > 0)
                {
                    if(ddlupstts.SelectedValue=="REJECT")
                    {
                        ShowMessage("Booking Rejected");
                    }
                    ShowMessage("BOOKING ACCEPTED");
                    GridView1.EditIndex = -1;
                    BindGridData();
                }
                else
                {
                    ShowMessage("BOOKING FAILED");
                }
            }
            else
            {
                ShowMessage("DropDownList 'ddlupstts' not found in the GridView row.");
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }

}