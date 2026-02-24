<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Checkout.aspx.cs" Inherits="Admin_Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <style>
        /* Add custom CSS styles here */
        .container {
            margin-top: 80px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        label {
            font-weight: bold;
            font-size: larger;
            margin-bottom: 5px;
            display: block;
        }
        input[type="text"],
        input[type="email"],
        input[type="number"] {
            width: 100%;
            height: 40px;
            font-size: 16px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        .file-upload {
            margin-top: 25px;
        }
        .row {
            display: flex;
            flex-wrap: wrap;
        }
        .col {
            flex: 1;
            padding: 0 10px;
        }
        .form-title {
            text-align: center;
            margin-bottom: 30px;
        }
        .form-section {
            padding-left: 50px;
            margin-top: 40px;
        }
        @media (max-width: 768px) {
            .col {
                flex: 1 100%;
                padding: 0;
            }
        }

         /* Add custom CSS styles here */
    .styled-button {
        background-color: darkred; /* Green */
        border: none;
        color: white;
        padding: 15px 32px;
        text-align: center;
        text-decoration: none;
        display: inline-block;
        font-size: 16px;
        margin: 4px 2px;
        transition-duration: 0.4s;
        cursor: pointer;
        border-radius: 8px;
    }

    .styled-button:hover {
        background-color: #45a049; /* Darker Green */
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div class="container">
        <h1 class="form-title">CHECK OUT FORM</h1>
        <div class="form-section">
            <h4>CUSTOMER</h4>
             <div class="col">
                    <div class="form-group">
                         <asp:Image ID="idimage" style="float:right;border:2px solid white" runat="server" ImageUrl='<%# Eval("idproof", "/cimg/{0}") %>' Height="120px" Width="120px" />
  
                    </div>
                </div>
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label for="txtbid">Booking ID</label>
                        <asp:TextBox ID="txtbid" AutoPostBack="true" OnTextChanged="txtbid_TextChanged" runat="server" CssClass="form-control" placeholder="Booking ID"></asp:TextBox>
                    </div>
                </div>
               <%-- <div class="col">
                    <div class="form-group">
                        <label for="txtsid">SI ID</label>
                        <asp:TextBox ID="txtsid" runat="server" CssClass="form-control" placeholder="SI ID"></asp:TextBox>
                    </div>
                </div>--%>
                <div class="col">
                    <div class="form-group">
                        <label for="txtcname">Customer Name</label>
                        <%--<asp:TextBox ID="txtcname" runat="server" CssClass="form-control" placeholder="Customer Name"></asp:TextBox>--%>
                        <asp:Label ID="lblcname" Width="300px" Height="40px" runat="server" ForeColor="black" CssClass="form-control"/>
                
                    </div>
                </div>

               
            </div>
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label for="txtphone">Phone No.</label>
                        <%--<asp:TextBox ID="txtphone" runat="server" CssClass="form-control" placeholder="Phone No."></asp:TextBox>--%>
                       <asp:Label ID="lblphone" Height="40px" runat="server" ForeColor="black" CssClass="form-control"/>
                
                    </div>
                </div>
                <div class="col">
                    <div class="form-group">
                        <label for="txtaddress">Aadhar</label>
                        <%--<asp:TextBox ID="txtaddress" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox>--%>
                    <asp:Label ID="lbladhar" Height="40px" runat="server" ForeColor="black" CssClass="form-control"/>
                
                    </div>
                </div>
                <div class="col">
                    <div class="form-group">
                        <label for="txtemail">Email</label>
                        <%--<asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>--%>
                    <asp:Label ID="lblemail" Height="40px" runat="server" ForeColor="black" CssClass="form-control"/>
                
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label for="txtnc">No Of Child</label>
                        <%--<asp:TextBox ID="txtnc" runat="server" CssClass="form-control" placeholder="No Of Child"></asp:TextBox>--%>
                    <asp:Label ID="lblnc" Height="40px" runat="server" ForeColor="black" CssClass="form-control"/>
                
                    </div>
                </div>
                <div class="col">
                    <div class="form-group">
                        <label for="txtna">No Of Adult</label>
                        <%--<asp:TextBox ID="txtna" runat="server" CssClass="form-control" placeholder="No Of Adult"></asp:TextBox>--%>
                   <asp:Label ID="lblna" Height="40px" runat="server" ForeColor="black" CssClass="form-control"/>
                
                        </div>
                </div>
            </div>
        </div>
        <div class="form-section">
            <h4>ROOM</h4>

            <div class="row">

                <div class="col">
                    <div class="form-group">
                        <label for="txtrtype">Room Type</label>
                        <asp:Label ID="lblrtype" Text="" runat="server" ForeColor="black" CssClass="form-control"/>
                    </div>
                </div>
                
                <div class="col">
                    <div class="form-group">
                        <label for="txtbedtype">Bed Type</label>
                        <%--<asp:TextBox ID="txtbedtype" runat="server" CssClass="form-control" placeholder="Bed Type"></asp:TextBox>--%>
                        <asp:Label ID="lblbedtype" Text="" runat="server"  ForeColor="black" CssClass="form-control"/>
                        </div>
                </div>
                
                <div class="col">
                    <div class="form-group">
                        <label for="txtrctg">Room Catg..</label>
                        <asp:Label ID="lblrcatg" Text="" runat="server" ForeColor="black" CssClass="form-control" />
                    </div>
                </div>

        </div>
            
            <div class="row">

                <div class="col">
                    <div class="form-group">
                        <label for="txtrno">Room No..</label>
                        <%--<asp:TextBox ID="txtrno" runat="server" CssClass="form-control" placeholder="Room No."></asp:TextBox>--%>
                    <asp:Label ID="lblrno"  Height="40px" runat="server" ForeColor="black" CssClass="form-control"/>
                
                    </div>
                </div>
                
               <%-- <div class="col">
                    <div class="form-group">
                        <label for="txtcost">Cost</label>
                        <asp:TextBox ID="txtcost" runat="server" CssClass="form-control" placeholder="Cost"></asp:TextBox>
                    </div>--%>
                 <div class="col">
                    <div class="form-group">
                        <label for="txtpay">Total Payment</label>
                        <%--<asp:TextBox ID="txtpay" runat="server" CssClass="form-control" placeholder="Total Payment"></asp:TextBox>--%>
                    <asp:Label ID="lbltpay" Height="40px" runat="server" ForeColor="black" CssClass="form-control"/>
                
                    </div>
                </div>

        </div>


            <div class="row">
                  <div class="col">
                    <div class="form-group">
                        <label for="txtcheckin">Check In Date</label>
                        <%--<asp:TextBox ID="txtcheckin" runat="server" CssClass="form-control" placeholder="Check In Date"></asp:TextBox>--%>
                   <asp:Label ID="lblcindate" Height="40px" runat="server" ForeColor="black" CssClass="form-control"/>
                        </div>
                </div>
                
                    <div class="col">
                    <div class="form-group">
                        <label for="txtcheckout">Check Out Date</label>
                        <%--<asp:TextBox ID="txtcheckout" runat="server" CssClass="form-control" placeholder="Check Out Date"></asp:TextBox>--%>
                    <asp:Label ID="lblcoutdate" Height="40px" runat="server" ForeColor="black" CssClass="form-control"/>
                    </div>
                </div>
                   
                </div>
                
                  <div>
                      <asp:Label ID="lblstts" Text="STATUS" runat="server" />
                      <asp:DropDownList ID="ddlstatus" runat="server" CssClass="form-control" Width="25%">
                          <asp:ListItem>----SELECT-----</asp:ListItem>
                          <asp:ListItem>CHECK OUT</asp:ListItem>
                      </asp:DropDownList>
                  </div>

                </div>
                <center>
            <asp:Button ID="btnupdate" runat="server" Text="CHECK OUT" CssClass="styled-button" OnClick="btnupdate_Click"/>
        </center>
              </div>
</asp:Content>

