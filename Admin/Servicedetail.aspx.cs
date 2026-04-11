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

public partial class Admin_Servicedetail : System.Web.UI.Page
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
        }
    }

    private void BindGridData()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Select * from Addservice ORDER by serviceid DESC", con);
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

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        BindGridData();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        BindGridData();
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int iddel = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            SqlCommand cmd = new SqlCommand("DELETE FROM Addservice WHERE serviceid=@serviceid", con);
            cmd.Parameters.AddWithValue("@serviceid", iddel);

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

            int rowIndex = e.RowIndex;
            FileUpload FileUpload1 = (FileUpload)GridView1.Rows[rowIndex].FindControl("FileUpload1");
            TextBox upsname = (TextBox)GridView1.Rows[rowIndex].FindControl("upsname");
            TextBox upsdesc = (TextBox)GridView1.Rows[rowIndex].FindControl("upsdesc");
            TextBox upsdate = (TextBox)GridView1.Rows[rowIndex].FindControl("upsdate");
          

            if (FileUpload1.HasFile == false)
            {

                SqlCommand cmd = new SqlCommand("Update Addservice SET servicename=@servicename,servicedesc=@servicedesc,date=@date WHERE serviceid=@serviceid", con);
                // cmd.Parameters.AddWithValue("@room_image", upimg);
                cmd.Parameters.AddWithValue("@servicename", upsname.Text);
                cmd.Parameters.AddWithValue("@servicedesc", upsdesc.Text);
             
                cmd.Parameters.AddWithValue("@date", upsdate.Text);
                cmd.Parameters.AddWithValue("@serviceid", GridView1.DataKeys[rowIndex].Value);

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
            else
            {
                string upimg = FileUpload1.FileName.ToString();
                FileUpload1.PostedFile.SaveAs(Server.MapPath("Serviceimg/") + upimg);

                SqlCommand cmd = new SqlCommand("Update Addservice SET serviceimg=@serviceimg,servicename=@servicename,servicedesc=@servicedesc,date=@date WHERE serviceid=@serviceid", con);
                cmd.Parameters.AddWithValue("@serviceimg", upimg);
                cmd.Parameters.AddWithValue("@servicename", upsname.Text);
                cmd.Parameters.AddWithValue("@servicedesc", upsdesc.Text);
                cmd.Parameters.AddWithValue("@date", upsdate.Text);
                cmd.Parameters.AddWithValue("@serviceid", GridView1.DataKeys[rowIndex].Value);

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
}