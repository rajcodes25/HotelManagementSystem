<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Addblog.aspx.cs" Inherits="Admin_Addblog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
       <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }

        .container {
            max-width: 1000px;
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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <center>
        <h1>Add Blog</h1>
    </center>

      <div class="container">
        <div class="file-preview" style="gap:10px">
            <div>
                <asp:FileUpload ID="FileUpload1" runat="server" onchange="previewFile()" />
                <br />
                <img id="previewImage" alt="Preview" style="display: none;" />
            </div>
            
            <div>
                <asp:FileUpload ID="FileUpload2" runat="server" onchange="previewFile2()" />
                <br />
                <img id="previewImage2" alt="Preview" style="display: none;" />
            </div> 
            
            <div>
                <asp:FileUpload ID="FileUpload3" runat="server" onchange="previewFile3()" />
                <br />
                <img id="previewImage3" alt="Preview" style="display: none;" />
            </div>

        </div>
          <div class="form-group" runat="server">
            <asp:Label ID="Label1" runat="server" Text="Blog Name" ForeColor="Black" Font-Bold="true"></asp:Label>
            <asp:TextBox ID="txtbname" runat="server" CssClass="form-control" placeholder="Enter Room Name"></asp:TextBox>
        </div>
          
          <div class="form-group" runat="server">
            <asp:Label ID="Label2" runat="server" Text="Blog Title" ForeColor="Black" Font-Bold="true"></asp:Label>
            <asp:TextBox ID="txtbtitle" runat="server" CssClass="form-control" placeholder="Enter Room Title"></asp:TextBox>
        </div>

           <div class="form-group" runat="server">
            <asp:Label ID="Label3" runat="server" Text="Blog Description" ForeColor="Black" Font-Bold="true"></asp:Label>
            <asp:TextBox ID="txtbdesc" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Enter Room Description"></asp:TextBox>
        </div>

          <div class="form-group" runat="server">
              <asp:Label ID="Label4" runat="server" Text="Blog Date" ForeColor="Black" Font-Bold="true"></asp:Label>
               <asp:TextBox ID="txtbdate" runat="server" TextMode="Date" CssClass="form-control" placeholder="Enter Room Description"></asp:TextBox>
    

             
          </div>
           <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn-login" OnClick="btnSubmit_Click"/>
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

            function previewFile2() {
            var preview = document.getElementById('previewImage2');
            var file = document.getElementById('<%= FileUpload2.ClientID %>').files[0];
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

            function previewFile3() {
                var preview = document.getElementById('previewImage3');
                var file = document.getElementById('<%= FileUpload3.ClientID %>').files[0];
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

