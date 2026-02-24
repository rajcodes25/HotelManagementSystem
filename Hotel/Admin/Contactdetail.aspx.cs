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


public partial class Admin_Contactdetail : System.Web.UI.Page
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
            Bindcondetail();
        }
    }

    private void Bindcondetail()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Select * from Contacttable ORDER by conid   DESC", con);
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


    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        Bindcondetail();
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        Bindcondetail();
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int iddel = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            SqlCommand cmd = new SqlCommand("DELETE FROM Contacttable WHERE conid=@conid", con);
            cmd.Parameters.AddWithValue("@conid", iddel);

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if (res > 0)
            {
                ShowMessage("Data Delete Sucessfully");
                Bindcondetail();
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
            int rowIndex = e.RowIndex;
            DropDownList ddlStatus = (DropDownList)GridView1.Rows[rowIndex].FindControl("ddlStatus");

                using (SqlCommand cmd = new SqlCommand("UPDATE Contacttable SET status = @status WHERE conid = @conid", con))
                {
                    cmd.Parameters.AddWithValue("@status", ddlStatus.SelectedItem.Text); // Use Text property to get the selected item's value
                    cmd.Parameters.AddWithValue("@conid", GridView1.DataKeys[rowIndex].Value);

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ShowMessage("Data updated successfully");
                        GridView1.EditIndex = -1;
                        Bindcondetail();
                    }
                    else
                    {
                        ShowMessage("Data update failed");
                    }
                }
        }
        catch (Exception ex)
        {
            ShowMessage("Error: " + ex.Message);
        }
    }

    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow && GridView1.EditIndex == e.Row.RowIndex)
            {
                DropDownList ddlStatus = (DropDownList)e.Row.FindControl("ddlStatus");

                if (ddlStatus != null)
                {
                    DataRowView drv = e.Row.DataItem as DataRowView;
                    if (drv != null)
                    {
                        string accountvalue = drv["status"].ToString();
                        ListItem selectedItem = ddlStatus.Items.FindByValue(accountvalue);



                        if (selectedItem != null)
                        {
                            selectedItem.Selected = true;

                        }
                        else
                        {
                            ddlStatus.SelectedValue = accountvalue;

                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }
}