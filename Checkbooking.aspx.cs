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


public partial class Checkbooking : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection("Data Source=DESKTOP-9LQNF0D\\SQLEXPRESS;Initial Catalog=hotel;Integrated Security=True");

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            BindGridData();
        }
    }

    private void ShowMessage(String msg)
    {
        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('" + msg + "');</script>");
    }

    private void BindGridData()
    {
        try
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SELECT bd.*, ar.Roomid, ar.rnum, ar.rprice, ar.rtype, ar.bedtype, ar.rcatg, ar.room_image " +
                                             "FROM Bookdetail bd INNER JOIN Addroom ar ON bd.roomid = ar.Roomid", con);
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
        finally
        {
            con.Close();
        }
    }

    private void BindDataSearchEdit(string bookid)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("SELECT bd.*, ar.Roomid, ar.rnum, ar.rprice, ar.rtype, ar.bedtype, ar.rcatg, ar.room_image " +
                                             "FROM Bookdetail bd INNER JOIN Addroom ar ON bd.roomid = ar.Roomid " +
                                             "WHERE bd.bookid=@bookid", con);
            cmd.Parameters.AddWithValue("@bookid", bookid);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                GridView1.DataSource = FilterDataByStatus(dt);
                GridView1.DataBind();
                GridView1.Visible = true;
            }
            else
            {
                GridView1.DataSource = null;
                GridView1.DataBind();
                ShowMessage("No Booking found with the provided Booking ID.");
                txtsearch.Text = "";
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }

    private DataTable FilterDataByStatus(DataTable originalDataTable)
    {
        // Define status values to filter
        string[] allowedStatuses = { "Not Verified", "Accept", "CANCELLED BOOKING" };

        // Create a new DataTable to store filtered rows
        DataTable filteredDataTable = originalDataTable.Clone(); // Copy structure (columns) of original table

        // Iterate through originalDataTable and add rows with allowed statuses to filteredDataTable
        foreach (DataRow row in originalDataTable.Rows)
        {
            string status = row["status"].ToString();
            if (allowedStatuses.Contains(status))
            {
                filteredDataTable.ImportRow(row); // Add row to filteredDataTable
            }
        }

        return filteredDataTable;
    }



    protected void btnsearch_Click(object sender, EventArgs e)
    {
        try
        {
            string bookid = txtsearch.Text.Trim();
            BindDataSearchEdit(bookid);
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
            GridView1.EditIndex = e.NewEditIndex;
            if (txtsearch.Text == "")
            {
                BindGridData();
            }
            else
            {
                BindDataSearchEdit(txtsearch.Text.Trim());
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
            BindDataSearchEdit(txtsearch.Text.Trim());
        }
    }

    //protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    //{
    //     try
    //    {
    //        int idd = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

    //        SqlCommand cmd = new SqlCommand("DELETE FROM Bookdetail WHERE bookid=@bookid", con);
    //        cmd.Parameters.AddWithValue("@bookid", idd);

    //        con.Open();
    //        int res = cmd.ExecuteNonQuery();
    //        con.Close();

    //        if (res > 0)
    //        {
    //            ShowMessage("Data Delete Sucessfully");
    //            BindGridData();
    //        }
    //        else
    //        {
    //            ShowMessage("Data delete failed!");
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        ShowMessage(ex.Message);
    //    }
    //}

    protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int idup = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

            DropDownList ddlupstts = (DropDownList)GridView1.Rows[0].FindControl("ddlupstts");

            SqlCommand cmd = new SqlCommand("Update Bookdetail SET status=@status WHERE bookid=@bookid",con);
            cmd.Parameters.AddWithValue("@status", ddlupstts.SelectedValue);
            cmd.Parameters.AddWithValue("@bookid", idup);

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if(res>0)
            {
                ShowMessage("Your Order is CANCELED SUCCESSFULLY");
                GridView1.EditIndex = -1;
            }

        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }
}

//SqlCommand cmd = new SqlCommand("SELECT bd.*,ar.Roomid,ar.rnum,ar.rprice,ar.rtype,ar.bedtype,ar.rcatg,ar.room_image FROM Bookdetail bd INNER JOIN Addroom ar ON bd.roomid = ar.Roomid WHERE bookid=@bookid", con);
//cmd.Parameters.AddWithValue("@bookid", txtsearch.Text);
//SqlDataAdapter da = new SqlDataAdapter(cmd);
//DataTable dt = new DataTable();
//da.Fill(dt);

//if (dt.Rows.Count > 0)
//{

//    GridView1.DataSource = dt;
//    GridView1.DataBind();

//    GridView1.Visible = true;
//    txtsearch.Text = "";
//}
//else
//{
//    ShowMessage("No Booking");
//    txtsearch.Text = "";
//}