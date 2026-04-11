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
public partial class Gallery : System.Web.UI.Page
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
            BindReptr();

        }
    }

    private void BindReptr()
    {
        try
        {
            SqlCommand cmd = new SqlCommand("Select * from Addroom Order by Roomid DESC", con);
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