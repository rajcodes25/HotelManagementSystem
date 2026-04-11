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
public partial class Admin_Addcrousel : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection("Data Source=LAPTOP-T1GQ836B;Initial Catalog=Hotel Management;Integrated Security=True");
    private void ShowMessage(String msg)
    {
        ClientScript.RegisterStartupScript(Page.GetType(), "validation", "<script language='javascript'>alert('" + msg + "');</script>");
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            BindCrouselGrid();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string crouselimg = FileUpload1.FileName.ToString();
            FileUpload1.PostedFile.SaveAs(Server.MapPath("crouselimg/") + crouselimg);

            SqlCommand cmd = new SqlCommand("Insert Into Addcrousel (crouselimage,date) VALUES (@crouselimage,@date)", con);
            cmd.Parameters.AddWithValue("@crouselimage", crouselimg);
            cmd.Parameters.AddWithValue("@date", txtcdate.Text);

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if(res>0)
            {
                ShowMessage("CROUSEL ADDED Successfully");
                txtcdate.Text = "";
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }

    private void BindCrouselGrid()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("SELECT * from Addcrousel ORDER BY id DESC",con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if(dt.Rows.Count>0)
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
        BindCrouselGrid();
    }

    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GridView1.EditIndex = -1;
        BindCrouselGrid();
    }

    protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int iddel = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);
            SqlCommand cmd = new SqlCommand("DELETE FROM Addcrousel WHERE id=@id", con);
            cmd.Parameters.AddWithValue("@id", iddel);

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if (res > 0)
            {
                ShowMessage("Data Delete Sucessfully");
                BindCrouselGrid();
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
            TextBox upcdate = (TextBox)GridView1.Rows[rowIndex].FindControl("upcdate");

            if (FileUpload1.HasFile == false)
            {

                SqlCommand cmd = new SqlCommand("Update Addcrousel SET date=@date WHERE id=@id", con);
                // cmd.Parameters.AddWithValue("@room_image", upimg);
                cmd.Parameters.AddWithValue("@date", upcdate.Text);
                cmd.Parameters.AddWithValue("@id", GridView1.DataKeys[rowIndex].Value);

                con.Open();
                int res = cmd.ExecuteNonQuery();
                con.Close();

                if (res > 0)
                {
                    ShowMessage("Data Update Successfully");
                    GridView1.EditIndex = -1;
                    BindCrouselGrid();
                }
                else
                {
                    ShowMessage("Data Update Fail");
                    BindCrouselGrid();
                }
            }
            else
            {
                string upimg = FileUpload1.FileName.ToString();
                FileUpload1.PostedFile.SaveAs(Server.MapPath("crouselimg/") + upimg);

                SqlCommand cmd = new SqlCommand("Update Addcrousel SET crouselimage=@crouselimage,date=@date WHERE id=@id", con);
                cmd.Parameters.AddWithValue("@crouselimage", upimg);
                cmd.Parameters.AddWithValue("@date", upcdate.Text);
                cmd.Parameters.AddWithValue("@id", GridView1.DataKeys[rowIndex].Value);

                con.Open();
                int res = cmd.ExecuteNonQuery();
                con.Close();

                if (res > 0)
                {
                    ShowMessage("Data Update Successfully");
                    GridView1.EditIndex = -1;
                    BindCrouselGrid();
                }
                else
                {
                    ShowMessage("Data Update Fail");
                    BindCrouselGrid();
                }
            }

        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }
}