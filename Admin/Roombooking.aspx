<%@ Page Title="" Language="C#" MasterPageFile="AdminMasterPage.master" AutoEventWireup="true" CodeFile="Roombooking.aspx.cs" Inherits="Admin_Roombooking" %>

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
       /* .file-upload {
            margin-top: 25px;
        }*/
        .file-preview {
            text-align: center;
            margin-bottom: 20px;
           /* display: flex;*/
            gap: 50px;
            margin-top:25px
        }

            .file-preview img {

                max-width: 100%;
                max-height: 200px;
                border-radius: 6px;
                border: 1px solid #ddd;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container">
        <h1 class="form-title">CHECK IN FORM</h1>
        <div class="form-section">
            <center><asp:Label ID="lblcancelorder" ForeColor="red" Font-Bold="true" Font-Size="larger" runat="server" Text=""></asp:Label></center>
            <h4>CUSTOMER</h4>
            <br />
            OFFLINE BOOKING<asp:RadioButton ID="rdb1" runat="server" GroupName="rdb1" AutoPostBack="true" OnCheckedChanged="BookingType_CheckedChanged"/>

            ONLINE BOOKING<asp:RadioButton ID="rdb2" runat="server" GroupName="rdb1" AutoPostBack="true" OnCheckedChanged="BookingType_CheckedChanged"/>
             <div class="col">
                    <div class="form-group">
                         <asp:Image ID="idimage" style="float:right" runat="server" ImageUrl='<%# Eval("idproof", "/cimg/{0}") %>' Height="120px" Width="120px" />
  
                    </div>
                </div>
            <div class="row">
                <div class="col">
                    <div class="form-group">
                        <label for="txtbid">Booking ID</label>
                        <asp:TextBox ID="txtbid" Font-Size="20px"  AutoPostBack="true" OnTextChanged="txtbid_TextChanged" runat="server" CssClass="form-control" placeholder="Booking ID"></asp:TextBox>
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
                        <asp:TextBox ID="txtcname" runat="server" CssClass="form-control" placeholder="Customer Name" onkeypress="return onlyAlphabets(event)"></asp:TextBox>
                    </div>
                </div>
                <%-- Allow enter key only alphabet in Customer Name --%>
                    <script>
                        function onlyAlphabets(event) {
                        var key = event.keyCode;
                        return ((key >= 65 && key <= 90) || (key >= 97 && key <= 122) || key == 8 || key == 32);
                        }
                    </script>
            </div>


                          <div class="row">
                    <div class="col">
                        <div class="form-group">
                            <label for="txtphone">Phone No.</label>
                            <asp:TextBox ID="txtphone" runat="server" CssClass="form-control" placeholder="Phone No." onkeypress="return onlyTenDigit(event)"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label for="txtadhar">Adhar</label>
                            <asp:TextBox ID="txtadhar" runat="server" CssClass="form-control" placeholder="Adhar" onkeypress="return onlyTwelveDigit(event)"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label for="txtemail">Email</label>
                            <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Email" onblur="validateEmail()"></asp:TextBox>
                            <span id="emailError" style="color: red;"></span>
                        </div>
                    </div>
                </div>

            <%--  Allow enter key only 10 digit number in phone  --%>
                <script>
                    function onlyTenDigit(event) {
                        var key = event.keyCode;
                        return (key >= 48 && key <= 57 && event.target.value.length < 10) || key == 8;
                    }

                     <%--  Allow enter key only 12 digit number in adhar  --%>
                    function onlyTwelveDigit(event) {
                        var key = event.keyCode;
                        return (key >= 48 && key <= 57 && event.target.value.length < 12) || key == 8;
                    }

                     <%--  validtion in email  --%>
                    function validateEmail() {
                        var email = document.getElementById("txtemail").value;
                        var emailError = document.getElementById("emailError");
                        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                        if (!emailRegex.test(email)) {
                            emailError.textContent = "Invalid email format";
                        } else {
                            emailError.textContent = "";
                        }
                    }
                </script>

            <div class="row">
                    <div class="col">
                        <label for="txtage">Age</label>
                        <asp:TextBox ID="txtage" runat="server" CssClass="form-control" placeholder="Age" onkeypress="return onlyTwoDigit(event)"></asp:TextBox>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label for="txtnc">No Of Child</label>
                            <asp:TextBox ID="txtnc" runat="server" CssClass="form-control" placeholder="No Of Child" onkeypress="return onlyTwoDigit(event)"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col">
                        <div class="form-group">
                            <label for="txtna">No Of Adult</label>
                            <asp:TextBox ID="txtna" runat="server" CssClass="form-control" placeholder="No Of Adult" onkeypress="return onlyTwoDigit(event)"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <script>
                    function onlyTwoDigit(event) {
                        var key = event.keyCode;
                        return (key >= 48 && key <= 57 && event.target.value.length < 2) || key == 8;
                    }
                </script>
        </div>

        <div class="form-section" runat="server">
            <h4>ROOM</h4>
            <asp:Label ID="lblroomid" runat="server" Text="Label" Visible="false"></asp:Label>
            <div class="row">

                 <div class="col">
                    <div class="form-group">
                        <label for="txtrno">Room No..</label>
                        <asp:TextBox ID="txtrno" runat="server" CssClass="form-control" placeholder="Room No."></asp:TextBox>
                        <asp:DropDownList ID="ddlroomno" AutoPostBack="true" OnSelectedIndexChanged="ddlroomno_SelectedIndexChanged" runat="server" CssClass="form-control">
                            <asp:ListItem>----SELECT ROOM NO---</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="col">
                    <div class="form-group">
                        <label for="txtrtype">Room Type</label>
                        <%--<asp:TextBox ID="txtrtype" runat="server" CssClass="form-control" placeholder="Room Type"></asp:TextBox>--%>
                        <asp:DropDownList ID="ddlrtype" CssClass="form-control" runat="server">
                            <asp:ListItem> --Select Room Type</asp:ListItem>
                    <asp:ListItem>AC Single</asp:ListItem>
                    <asp:ListItem>AC Double</asp:ListItem>
                    <asp:ListItem>NON-AC</asp:ListItem>
                        </asp:DropDownList>
                    </div>
                </div>
                
                <div class="col">
                    <div class="form-group">
                        <label for="txtbedtype">Bed Type</label>
                        <%--<asp:TextBox ID="txtbedtype" runat="server" CssClass="form-control" placeholder="Bed Type"></asp:TextBox>--%>
                          <asp:DropDownList ID="ddlbedtype" CssClass="form-control" runat="server">
                    <asp:ListItem>--Select Bed Type</asp:ListItem>
                    <asp:ListItem>Single Bed</asp:ListItem>
                    <asp:ListItem>Double Bed</asp:ListItem>
                        </asp:DropDownList>
                        </div>
                </div>

        </div>
            
            <div class="row">

                 <div class="col">
                    <div class="form-group">
                        <label for="txtrctg">Room Catg..</label>
                        <%--<asp:TextBox ID="txtrcatg" runat="server" CssClass="form-control" placeholder="Room Catg..."></asp:TextBox>--%>
                     <asp:DropDownList ID="ddlrcatg" runat="server" CssClass="form-control">
                <asp:ListItem>--Select Room Category</asp:ListItem>
                <asp:ListItem>Delux</asp:ListItem>
                <asp:ListItem>Super Delux</asp:ListItem>
            </asp:DropDownList>
                    
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
                        <asp:TextBox ID="txtpay" runat="server" CssClass="form-control" placeholder="Total Payment"></asp:TextBox>
                    </div>
                </div>

        </div>


          <%--  <div runat="server" class="cicoidfill"> 
                  <div class="row">
                  <div class="col">
                    <div class="form-group">
                        <label for="txtcheckin">Check In Date</label>
                        <asp:TextBox ID="txtcheckin" runat="server" CssClass="form-control" placeholder="Check In Date"></asp:TextBox>
                    </div>
                </div>
                
                    <div class="col">
                    <div class="form-group">
                        <label for="txtcheckout">Check Out Date</label>
                        <asp:TextBox ID="txtcheckout" runat="server" CssClass="form-control" placeholder="Check Out Date"></asp:TextBox>
                    </div>
                </div>
                   
                </div>
            </div>--%>
            <div class="row">
                                 <div class="col">
                                     <div class="form-group">
                                          <asp:Label ID="Label1" runat="server" Text="Check-In"></asp:Label>
                            <asp:TextBox ID="txtcheckin" runat="server" BackColor="#3c3c3c" CssClass="form-control" class="form-control" placeholder="Check-in Date" type="datetime-local" Required="true"></asp:TextBox><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtCheckIn"
                                ErrorMessage="Check-in Date is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                             
                                     </div>
                                     </div>


                            <div class="col">
                                <div class="form-group">
                                     <asp:Label ID="Label2" runat="server" Text="Check-Out"></asp:Label>
                            <asp:TextBox ID="txtcheckout" BackColor="#3c3c3c" CssClass="form-control" runat="server" placeholder="Check-out Date" type="datetime-local" Required="true"></asp:TextBox><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtCheckOut"
                                ErrorMessage="Check-out Date is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                               
                                </div>
                                </div>
                            </div>

            <div class="row">

                   <div class="col file-preview">
                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="form-control" onchange="previewFile()"/>
                 <br />
                <img id="previewImage" alt="Preview" style="display: none;" />
               
                </div>

                 <div class="col" runat="server" id="divstatus">
                      <asp:Label ID="lblstts" Text="STATUS" runat="server" />
                      <asp:DropDownList ID="ddlstatus" runat="server" CssClass="form-control">
                          <asp:ListItem>Not Accept</asp:ListItem>
                          <asp:ListItem>CHECK IN</asp:ListItem>
                          <asp:ListItem>REJECT</asp:ListItem>
                      </asp:DropDownList>
                 </div>

                    
            </div>

                    <center><asp:Button ID="btnadd" runat="server" Text="ADD" CssClass="styled-button" OnClick="btnadd_Click"/>
 </center>
        <center>
            <asp:Button ID="btnupdate" runat="server" Text="ADD NOW" CssClass="styled-button" OnClick="btnupdate_Click"/>
        </center>
              </div>
</asp:Content>
