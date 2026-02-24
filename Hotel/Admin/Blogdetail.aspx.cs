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


public partial class Admin_Blogdetail : System.Web.UI.Page
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
            BindGridData();
        }
    }
    private void BindGridData()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Select * from Addblog ORDER by blogid   DESC", con);
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
            SqlCommand cmd = new SqlCommand("DELETE FROM Addblog WHERE blogid=@blogid", con);
            cmd.Parameters.AddWithValue("@blogid", iddel);

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
            FileUpload FileUpload2 = (FileUpload)GridView1.Rows[rowIndex].FindControl("FileUpload2");
            FileUpload FileUpload3 = (FileUpload)GridView1.Rows[rowIndex].FindControl("FileUpload3");

            TextBox upbname = (TextBox)GridView1.Rows[rowIndex].FindControl("upbname");
            TextBox upbtitle = (TextBox)GridView1.Rows[rowIndex].FindControl("upbtitle");
       
            TextBox upbdesc = (TextBox)GridView1.Rows[rowIndex].FindControl("upbdesc");
            TextBox upbdate = (TextBox)GridView1.Rows[rowIndex].FindControl("upbdate");

            if (FileUpload1.HasFile == false && FileUpload2.HasFile==false && FileUpload3.HasFile==false)
            {

                SqlCommand cmd = new SqlCommand("Update Addblog SET blogname=@blogname,blogtitle=@blogtitle,blogdesc=@blogdesc,blogdate=@blogdate WHERE blogid=@blogid", con);
                // cmd.Parameters.AddWithValue("@room_image", upimg);
                cmd.Parameters.AddWithValue("@blogname", upbname.Text);
                cmd.Parameters.AddWithValue("@blogtitle", upbtitle.Text);
            
                cmd.Parameters.AddWithValue("@blogdesc", upbdesc.Text);
                cmd.Parameters.AddWithValue("@blogdate", upbdate.Text);
                cmd.Parameters.AddWithValue("@blogid", GridView1.DataKeys[rowIndex].Value);

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
                FileUpload1.PostedFile.SaveAs(Server.MapPath("Blogimg/") + upimg);
                
                string upimg2 = FileUpload2.FileName.ToString();
                FileUpload2.PostedFile.SaveAs(Server.MapPath("Blogimg/") + upimg2);
                
                string upimg3 = FileUpload3.FileName.ToString();
                FileUpload3.PostedFile.SaveAs(Server.MapPath("Blogimg/") + upimg3);

              
                SqlCommand cmd = new SqlCommand("Update Addblog SET blogimg=@blogimg,blogimg2=@blogimg2,blogimg3=@blogimg3,blogname=@blogname,blogtitle=@blogtitle,blogdesc=@blogdesc,blogdate=@blogdate WHERE blogid=@blogid", con);
                // cmd.Parameters.AddWithValue("@room_image", upimg);
                cmd.Parameters.AddWithValue("@blogimg", upimg);
                cmd.Parameters.AddWithValue("@blogimg2", upimg2);
                cmd.Parameters.AddWithValue("@blogimg3", upimg3);
                cmd.Parameters.AddWithValue("@blogname", upbname.Text);
                cmd.Parameters.AddWithValue("@blogtitle", upbtitle.Text);

                cmd.Parameters.AddWithValue("@blogdesc", upbdesc.Text);
                cmd.Parameters.AddWithValue("@blogdate", upbdate.Text);
                cmd.Parameters.AddWithValue("@blogid", GridView1.DataKeys[rowIndex].Value);

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