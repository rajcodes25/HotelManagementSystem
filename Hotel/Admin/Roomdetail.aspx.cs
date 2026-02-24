using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Configuration;
using System.Data;

public partial class Admin_Roomdetail : System.Web.UI.Page
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
            BindGridData();
            // BindgridView();
        }
    }



    private void BindGridData()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("select * from Addroom", con);
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
        //try
        //{
        //    // Select data from Addroom table along with status from Bookdetail table
        //    SqlCommand cmd = new SqlCommand("SELECT ar.*, bd.status FROM Addroom ar LEFT JOIN Bookdetail bd ON ar.Roomid = bd.roomid ORDER BY ar.Roomid DESC", con);
        //    SqlDataAdapter da = new SqlDataAdapter(cmd);
        //    DataTable dt = new DataTable();
        //    da.Fill(dt);

        //    if (dt.Rows.Count > 0)
        //    {
        //        // Update bookingstatus based on status from Bookdetail table
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            if (!row.IsNull("status"))
        //            {
        //                string status = row["status"].ToString();
        //                if (status == "CHECK IN")
        //                {
        //                    row["bookingstatus"] = "CHECK IN";
        //                }
        //                else if (status == "CHECK OUT")
        //                {
        //                    row["bookingstatus"] = "Vacant";
        //                }
        //            }
        //        }

        //        // Update the database with the changes
        //        SqlCommand updateCmd = new SqlCommand("UPDATE Addroom SET bookingstatus = @bookingstatus WHERE Roomid = @Roomid", con);
        //        updateCmd.Parameters.Add("@bookingstatus", SqlDbType.VarChar); // Assuming bookingstatus is of type VARCHAR
        //        updateCmd.Parameters.Add("@Roomid", SqlDbType.Int);

        //        con.Open();
        //        foreach (DataRow row in dt.Rows)
        //        {
        //            updateCmd.Parameters["@bookingstatus"].Value = row["bookingstatus"];
        //            updateCmd.Parameters["@Roomid"].Value = row["Roomid"];
        //            updateCmd.ExecuteNonQuery();
        //        }
        //        con.Close();

        //        // Bind the updated data to the GridView
        //        GridView1.DataSource = dt;
        //        GridView1.DataBind();
        //    }
        //    else
        //    {
        //        GridView1.DataSource = null;
        //        GridView1.DataBind();
        //    }
        //}
        //catch (Exception ex)
        //{
        //    ShowMessage(ex.Message);
        //}
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        BindGridData();
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        BindGridData();
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int iddel = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            SqlCommand cmd = new SqlCommand("Delete from Addroom Where Roomid=@Roomid", con);
            cmd.Parameters.AddWithValue("@Roomid", iddel);

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if(res>0)
            {
                ShowMessage("Room Data Successfully Deleted");
                BindGridData();
            }
            else
            {
                ShowMessage("Room Data Delete Failed !!!.....");
                BindGridData();
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

                int rowIndex = e.RowIndex;
                FileUpload FileUpload1 = (FileUpload)GridView1.Rows[rowIndex].FindControl("FileUpload1");
            

                TextBox uprnum  = (TextBox)GridView1.Rows[rowIndex].FindControl("uprnum");
                TextBox uprprice = (TextBox)GridView1.Rows[rowIndex].FindControl("uprprice");
                DropDownList ddluprtype = (DropDownList)GridView1.Rows[rowIndex].FindControl("ddluprtype");
                DropDownList ddlupbedtype = (DropDownList)GridView1.Rows[rowIndex].FindControl("ddlupbedtype");
                DropDownList ddluprcatg = (DropDownList)GridView1.Rows[rowIndex].FindControl("ddluprcatg");

                TextBox uprdesc = (TextBox)GridView1.Rows[rowIndex].FindControl("uprdesc");
                TextBox uprdate = (TextBox)GridView1.Rows[rowIndex].FindControl("uprdate");

                if (FileUpload1.HasFile == false)
                {

                    SqlCommand cmd = new SqlCommand("Update Addroom SET rnum=@rnum,rprice=@rprice,rtype=@rtype,bedtype=@bedtype,rcatg=@rcatg,rdesc=@rdesc,rdate=@rdate WHERE Roomid=@Roomid", con);
                    // cmd.Parameters.AddWithValue("@room_image", upimg);
                    cmd.Parameters.AddWithValue("@rnum", uprnum.Text);
                    cmd.Parameters.AddWithValue("@rprice", uprprice.Text);
                    cmd.Parameters.AddWithValue("@rtype", ddluprtype.SelectedValue);
                    cmd.Parameters.AddWithValue("@bedtype", ddlupbedtype.SelectedValue);
                    cmd.Parameters.AddWithValue("@rcatg", ddluprcatg.SelectedValue);

                    cmd.Parameters.AddWithValue("@rdesc", uprdesc.Text);
                    cmd.Parameters.AddWithValue("@rdate", uprdate.Text);
                    cmd.Parameters.AddWithValue("@Roomid", GridView1.DataKeys[rowIndex].Value);

                    con.Open();
                    int res = cmd.ExecuteNonQuery();
                    con.Close();

                    if (res > 0)
                    {
                        ShowMessage("Room Data Update Successfully");
                        GridView1.EditIndex = -1;
                        BindGridData();
                    }
                    else
                    {
                        ShowMessage("Data Update Fail");
                        BindGridData();
                    }
                }
                else
                {
                    string upimg = FileUpload1.FileName.ToString();
                    FileUpload1.PostedFile.SaveAs(Server.MapPath("Roomimg/") + upimg);


                    SqlCommand cmd = new SqlCommand("Update Addroom SET room_image=@room_image,rnum=@rnum,rprice=@rprice,rtype=@rtype,bedtype=@bedtype,rcatg=@rcatg,rdesc=@rdesc,rdate=@rdate WHERE Roomid=@Roomid", con);
                     cmd.Parameters.AddWithValue("@room_image", upimg);
                    cmd.Parameters.AddWithValue("@rnum", uprnum.Text);
                    cmd.Parameters.AddWithValue("@rprice", uprprice.Text);
                    cmd.Parameters.AddWithValue("@rtype", ddluprtype.SelectedValue);
                    cmd.Parameters.AddWithValue("@bedtype", ddlupbedtype.SelectedValue);
                    cmd.Parameters.AddWithValue("@rcatg", ddluprcatg.SelectedValue);

                    cmd.Parameters.AddWithValue("@rdesc", uprdesc.Text);
                    cmd.Parameters.AddWithValue("@rdate", uprdate.Text);
                    cmd.Parameters.AddWithValue("@Roomid", GridView1.DataKeys[rowIndex].Value);

                    con.Open();
                    int res = cmd.ExecuteNonQuery();
                    con.Close();

                    if (res > 0)
                    {
                        ShowMessage("Data Update Successfully");
                        GridView1.EditIndex = -1;
                        BindGridData();
                    }
                    else
                    {
                        ShowMessage("Data Update Fail");
                        BindGridData();
                    }
                }

            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message);
            }
        }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow && (e.Row.RowState & DataControlRowState.Edit) > 0)
            {
                // Get data item
                DataRowView drv = (DataRowView)e.Row.DataItem;

                // Room Type
                DropDownList ddluprtype = (DropDownList)e.Row.FindControl("ddluprtype");
                if (ddluprtype != null)
                {
                    string currentValue = drv["rtype"].ToString();
                    ddluprtype.SelectedValue = currentValue;
                }

                // Bed Type
                DropDownList ddlupbedtype = (DropDownList)e.Row.FindControl("ddlupbedtype");
                if (ddlupbedtype != null)
                {
                    string currentValue = drv["bedtype"].ToString();
                    ddlupbedtype.SelectedValue = currentValue;
                }

                // Room Category
                DropDownList ddluprcatg = (DropDownList)e.Row.FindControl("ddluprcatg");
                if (ddluprcatg != null)
                {
                    string currentValue = drv["rcatg"].ToString();
                    ddluprcatg.SelectedValue = currentValue;
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }
}

           