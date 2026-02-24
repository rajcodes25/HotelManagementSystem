<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Checkbooking.aspx.cs" Inherits="Checkbooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <style>
        /* Optional: Add custom styles for responsiveness */
        .col {
            text-align: center;
        }

        .send_btn {
            background-color: #007bff; /* Blue background */
            color: #fff; /* White text */
            border: none; /* Remove border */
            padding: 10px 20px; /* Padding inside button */
            font-size: 16px; /* Font size */
            cursor: pointer; /* Cursor on hover */
            border-radius: 5px; /* Rounded corners */
            transition: background-color 0.3s; /* Smooth color transition */
        }

        .send_btn:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        /* Adjustments for smaller screens */
        @media (max-width: 768px) {
            .send_btn {
                font-size: 14px;
                padding: 8px 16px;
            }
        }


          /* Style for gridview */
        #GridView1 {
            border-collapse: collapse;
            width: 100%;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        /* Style for gridview header */
        #GridView1 th {
            background-color: #f2f2f2;
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        /* Style for gridview rows */
        #GridView1 td {
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }

        /* Style for alternating gridview rows */
        #GridView1 tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        /* Style for image column */
        .room-image {
            width: 150px;
            height: 110px;
            object-fit: cover;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <div class="back_re">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="title">
                        <h2>CHECK YOUR OWN ROOM</h2>
                        <p class="margin_0">See Your Booking and Perform the action for Editing Booking</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br />
    <div class="container">
        <div class="row">
            <div class="col">
            <h1>Search Your Booking Here</h1>
            
                <asp:TextBox ID="txtsearch" runat="server" placeholder="Enter Booking Id"></asp:TextBox>
                <asp:Button ID="btnsearch" runat="server" Text="SEARCH" CssClass="send_btn" OnClick="btnsearch_Click"/>
            </div>
        </div>
    </div>
    <br />

    <div class="container">
        <div class="row">
            <div class="col" style="overflow:scroll">
              
                 <asp:GridView ID="GridView1" runat="server" Visible="false" AutoGenerateColumns="False" DataKeyNames="bookid" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateEditButton="True" OnRowCancelingEdit="GridView1_RowCancelingEdit"  OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating"  >
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>


                    <asp:TemplateField HeaderText=" BookID">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("bookid") %>' Width="70px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText=" STATUS">
                        <ItemTemplate>
                            <asp:Label ID="lblstts" runat="server" Text='<%# Eval("status") %>' Width="120px"></asp:Label>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlupstts" runat="server">
                                <asp:ListItem>SELECT</asp:ListItem>
                                <asp:ListItem>CANCELLED BOOKING</asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                    </asp:TemplateField>



                     <asp:TemplateField HeaderText="Customer Image">
                        <ItemTemplate>
                            <asp:Image ID="Image2" class="clickable-image" runat="server" ImageUrl='<%# Eval("idproof","../cimg/{0}") %>' CssClass="room-image"/>
                        </ItemTemplate>

                       <%-- <EditItemTemplate>
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                        </EditItemTemplate>--%>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Name">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("name") %>' Width="120px"></asp:Label>
                        </ItemTemplate>

                       <%-- <EditItemTemplate>
                            <asp:TextBox ID="upbname" runat="server"  Text='<%# Eval("blogname") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 

                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Eval("email") %>' Width="150px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField>
                    
                    
                    <asp:TemplateField HeaderText="Phone">
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Eval("phone") %>' Width="110px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    
                     
                    <asp:TemplateField HeaderText="Age">
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Eval("age") %>' Width="80px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    

                    <asp:TemplateField HeaderText="Adhar">
                        <ItemTemplate>
                            <asp:Label ID="Label6" runat="server" Text='<%# Eval("adhar") %>' Width="110px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    
                    <asp:TemplateField HeaderText="No. of Child">
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("noofchild") %>' Width="110px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    
                    <asp:TemplateField HeaderText="No. of Adult">
                        <ItemTemplate>
                            <asp:Label ID="Label8" runat="server" Text='<%# Eval("noofadult") %>' Width="110px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    
                    <asp:TemplateField HeaderText="Check In">
                        <ItemTemplate>
                            <asp:Label ID="Label9" runat="server" Text='<%# Eval("checkin") %>' Width="150px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    
                    <asp:TemplateField HeaderText="Check Out">
                        <ItemTemplate>
                            <asp:Label ID="Label10" runat="server" Text='<%# Eval("checkout") %>' Width="150px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 


                    <asp:TemplateField HeaderText="Room Image">
                        <ItemTemplate>
                            <asp:Image ID="Image1" class="clickable-image" runat="server" ImageUrl='<%# Eval("room_image","Roomimg/{0}") %>' CssClass="room-image"/> 
                        </ItemTemplate>

                       <%-- <EditItemTemplate>
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                        </EditItemTemplate>--%>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Room No.">
                        <ItemTemplate>
                             <asp:Label ID="lblrnum" runat="server" Text='<%# Eval("rnum") %>' Width="110px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Room Price">
                        <ItemTemplate>
                             <asp:Label ID="Label11" runat="server" Text='<%# Eval("rprice") %>' Width="110px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Room Type">
                        <ItemTemplate>
                             <asp:Label ID="Label12" runat="server" Text='<%# Eval("rtype") %>' Width="110px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Bed Type">
                        <ItemTemplate>
                             <asp:Label ID="Label13" runat="server" Text='<%# Eval("bedtype") %>' Width="110px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    

                     <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="Label14" runat="server" Text='<%# Eval("date") %>' Width="110px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbdate" TextMode="Date" runat="server" Text='<%# Eval("blogdate") %>'></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </div>
        </div>
    </div>

   
</asp:Content>

