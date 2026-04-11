<%@ Page Title="" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" CodeFile="Addcrousel.aspx.cs" Inherits="Admin_Addcrousel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);




        }

        .file-preview {
            text-align: center;
            margin-bottom: 20px;
            display: flex;
            gap: 50px
        }

            .file-preview img {
                max-width: 100%;
                max-height: 200px;
                border-radius: 6px;
                border: 1px solid #ddd;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            }

        .form-group {
            margin-bottom: 20px;
        }

            .form-group label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
                color: #333;
            }

            .form-group input[type="text"],
            .form-group input[type="password"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ced4da;
                border-radius: 6px;
                box-sizing: border-box;
                transition: border-color 0.3s ease;
                background-color: #f5f5f5;
                color: #333;
            }

                .form-group input[type="text"]:focus,
                .form-group input[type="password"]:focus {
                    border-color: #007bff;
                    outline: none;
                }

        .btn-login {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 6px;
            background-color: #007bff;
            color: #fff;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

            .btn-login:hover {
                background-color: #0056b3;
            }
        /*============================Style For Dropdown=================*/
        /* Style for form-group */
        .form-group {
            margin-bottom: 15px; /* Adds space between form groups */
        }

            /* Style for labels */
            .form-group label {
                display: inline-block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            /* Style for dropdowns */
            .form-group select {
                width: 170px;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                box-sizing: border-box;
                font-size: 14px;
            }

/*=============    FOR GRIDVIEW     ==========*/

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
            height: 150px;
            object-fit: cover;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


       <center>
        <h1>Add CROUSEL</h1>
    </center>
    <div class="container">
        <div class="file-preview">
            <div>
                <asp:FileUpload ID="FileUpload1" runat="server" onchange="previewFile()" />
                <br />
                <img id="previewImage" alt="Preview" style="display: none;" />
            </div>

            <%--  <div class="file-preview">
                <div>
                    <asp:FileUpload ID="videoUpload" runat="server" onchange="previewVideo()" />
                    <br />
                    <video id="previewVideo" width="320" height="240" controls style="display: none;">
                        Your browser does not support the video tag.
                    </video>
                </div>
            </div>--%>
        </div>
       

        <div class="form-group" runat="server">
            <label for="txtcdate">Add Date</label>
            <asp:TextBox ID="txtcdate" runat="server" TextMode="Date" CssClass="form-control" placeholder="Enter Room Description"></asp:TextBox>
        </div>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn-login" OnClick="btnSubmit_Click"/>
   

    <br />
    <br />
        <br />
   <center>
        <h1 style="color:black">View CROUSEL Details</h1>
    </center>
        <div style="text-align:center">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="id" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateDeleteButton="True" AutoGenerateEditButton="True" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDeleting="GridView1_RowDeleting" OnRowEditing="GridView1_RowEditing" OnRowUpdating="GridView1_RowUpdating">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <Columns>
                    <asp:TemplateField HeaderText="ID">
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("id") %>' Width="70px"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    
                    <asp:TemplateField HeaderText="Room Image">
                        <ItemTemplate>
                            <asp:Image ID="Image1" class="clickable-image" runat="server" ImageUrl='<%# Eval("crouselimage","crouselimg/{0}") %>' CssClass="room-image"/>
                        </ItemTemplate>

                        <EditItemTemplate>
                            <asp:FileUpload ID="FileUpload1" runat="server" />
                        </EditItemTemplate>
                    </asp:TemplateField>

                        
                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="Label7" runat="server" Text='<%# Eval("date") %>' Width="110px"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="upcdate" TextMode="Date" runat="server" Text='<%# Eval("date") %>'></asp:TextBox>
                        </EditItemTemplate>
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



    <script>
        function previewFile() {
            var preview = document.getElementById('previewImage');
            var file = document.getElementById('<%= FileUpload1.ClientID %>').files[0];
            var reader = new FileReader();

            reader.onloadend = function () {
                preview.src = reader.result;
                preview.style.display = 'block';
            };

            if (file) {
                reader.readAsDataURL(file);
            } else {
                preview.src = '';
                preview.style.display = 'none';
            }
        }
    </script>


</asp:Content>

