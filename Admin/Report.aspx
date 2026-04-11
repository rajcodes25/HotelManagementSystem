<%@ Page Title="" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="Admin_Report" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <center style="margin-top:70px">
        <h1>VIEW REPORT</h1>
    </center>
    <div class="container" style="border:2px solid white; margin-top:50px">
        <div class="row" style="border:2px solid red">
           
                <div class="col-md-6" style="border:2px solid yellow">
                    <asp:Label ID="lblbrtm" runat="server" Text="Label"></asp:Label>
                </div>
                 <div class="col-md-6" style="border:2px solid orange">
                    hello
                </div>
            </div>
    </div>
</asp:Content>

