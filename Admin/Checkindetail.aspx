<%@ Page Title="" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" CodeFile="Checkindetail.aspx.cs" Inherits="Admin_Checkindetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style>
        /* Style for container */
        .container {
            margin-top: 20px;
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
            width: 170px;
            height: 150px;
            object-fit: cover;
        }

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <center style="margin-top:50px">
        <h1>View CHECK-IN Details</h1>
    </center>
    <div class="container">
        <div class="">
            <asp:Label ID="Label3" runat="server" Text="Search By Name,Mobile,Check In Date" Font-Size="20px" Font-Bold="true"></asp:Label>
            <br />
            <asp:TextBox ID="txtsearch" runat="server" AutoPostBack="true" OnTextChanged="txtsearch_TextChanged" Width="300px" Height="40px" Font-Bold="true" Font-Size="25px"></asp:TextBox>
        </div>
        <br />
        <div style="text-align:center;border:2px solid white;overflow:scroll; width:90%">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="bookid" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" >
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
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("email") %>' Width="150px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField>
                    
                    
                    <asp:TemplateField HeaderText="Phone">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("phone") %>' Width="110px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    
                     
                    <asp:TemplateField HeaderText="Age">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("age") %>' Width="80px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    

                    <asp:TemplateField HeaderText="Adhar">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("adhar") %>' Width="110px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    
                    <asp:TemplateField HeaderText="No. of Child">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("noofchild") %>' Width="110px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    
                    <asp:TemplateField HeaderText="No. of Adult">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("noofadult") %>' Width="110px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    
                    <asp:TemplateField HeaderText="Check In">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("checkin") %>' Width="150px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbtitle" runat="server"  Text='<%# Eval("blogtitle") %>' Width="120px"></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField> 
                    
                    <asp:TemplateField HeaderText="Check Out">
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("checkout") %>' Width="150px"></asp:Label>
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
                             <asp:Label ID="lblrnum" runat="server" Text='<%# Eval("rprice") %>' Width="110px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Room Type">
                        <ItemTemplate>
                             <asp:Label ID="lblrnum" runat="server" Text='<%# Eval("rtype") %>' Width="110px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Bed Type">
                        <ItemTemplate>
                             <asp:Label ID="lblrnum" runat="server" Text='<%# Eval("bedtype") %>' Width="110px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    

                     <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("date") %>' Width="110px"></asp:Label>
                        </ItemTemplate>

                      <%--  <EditItemTemplate>
                            <asp:TextBox ID="upbdate" TextMode="Date" runat="server" Text='<%# Eval("blogdate") %>'></asp:TextBox>
                        </EditItemTemplate>--%>
                    </asp:TemplateField>

                </Columns>
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
        </div>
    </div>
</asp:Content>

