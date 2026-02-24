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

public partial class _Default : System.Web.UI.Page
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
            BindReptrourroom();
            BindReptgallery();
            bindblogrpt();
            VBindcrousel();
        }
    }
    //for Room
    private void BindReptrourroom()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("SELECT TOP 6 * FROM Addroom ORDER BY Roomid DESC", con);
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
    
    //for Gallery
    private void BindReptgallery()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("SELECT TOP 8 * FROM Addroom", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                Repeater2.DataSource = dt;
                Repeater2.DataBind();
            }
            else
            {
                Repeater2.DataSource = null;
                Repeater2.DataBind();
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }

    //for Blog
    private void bindblogrpt()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("SELECT Top 3 * FROM Addblog ORDER BY blogid DESC", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                Repeater3.DataSource = dt;
                Repeater3.DataBind();
            }
            else
            {
                Repeater3.DataSource = null;
                Repeater3.DataBind();
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        try
        {
            SqlCommand cmd = new SqlCommand("INSERT INTO contacttable (conname,conemail,conphone,conmsg,condate,status) VALUES (@conname,@conemail,@conphone,@conmsg,@condate,@status)", con);
            cmd.Parameters.AddWithValue("@conname", txtName.Text);
            cmd.Parameters.AddWithValue("@conemail", txtEmail.Text);
            cmd.Parameters.AddWithValue("@conphone", txtPhoneNumber.Text);
            cmd.Parameters.AddWithValue("@conmsg", txtMessage.Text);
            cmd.Parameters.AddWithValue("@condate", DateTime.Now.ToString("dd-MM-yyyy"));
            cmd.Parameters.AddWithValue("@status", "Pending...");

            con.Open();
            int res = cmd.ExecuteNonQuery();
            con.Close();

            if(res>0)
            {
                // Show success message using JavaScript
               // ScriptManager.RegisterStartupScript(this, GetType(), "showSuccessMessage", "showSuccess();", true);
                ShowMessage("Contact Send Successfuly Thank You");
            }
            else{
                ShowMessage("Contact Failed Please Try again");
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }

    // FOR Crousel========================
    private void VBindcrousel()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("SELECT * FROM Addcrousel", con);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            if (dt.Rows.Count > 0)
            {
                rptcrousel.DataSource = dt;
                rptcrousel.DataBind();
            }
            else
            {
                rptcrousel.DataSource = null;
                rptcrousel.DataBind();
            }
        }
        catch (Exception ex)
        {
            ShowMessage(ex.Message);
        }
    }

    // Code-behind:
    public string GetShortDescription(object description)
    {
        if (description == null) return "";

        string desc = description.ToString();
        string[] words = desc.Split(' ');

        if (words.Length <= 6)
        {
            return desc;
        }
        else
        {
            return string.Join(" ", words.Take(6)) + " ...";
        }
    }

}