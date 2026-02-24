<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="BooknowForm.aspx.cs" Inherits="BooknowForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .room-item {
            /*flex-basis: calc(33.33% - 20px);*/ /* 3 items per row with 20px spacing between them */
            margin-bottom: 20px;
            box-sizing: border-box;
        }

            .room-item .image-container {
                width: 100%;
                /* Maintain aspect ratio for the images */
                position: relative;
                overflow: hidden;
            }

                .room-item .image-container img {
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 50%;
                    object-fit: cover; /* Ensure the image covers the entire container */
                }

        .room-image {
            transition: transform 0.3s ease; /* Smooth transition for the zoom effect */
        }

            .room-image:hover {
                transform: scale(1.1); /* Scale the image by 10% on hover */
            }
            .file-preview img {
                max-width: 100%;
                max-height: 200px;
                border-radius: 6px;
                border: 1px solid #ddd;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            }
    </style>

    <script type="text/javascript">
        function onlyAlphabets(evt) {
            // Get the event key code
            var charCode = (evt.which) ? evt.which : event.keyCode;

            // Ensure that the key pressed is a letter or space
            if ((charCode < 65 || charCode > 90) && (charCode < 97 || charCode > 122) && charCode != 32) {
                return false;
            }
            return true;
        }
    </script>

    <%-- Phone number Validition --%>
    <script>
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
    </script>

    <%-- AGE --%>
    <script>
        function isTwoDigitNumber(event) {
            var charCode = (event.which) ? event.which : event.keyCode;
            var inputValue = event.target.value + String.fromCharCode(charCode);
            return /^\d{0,2}$/.test(inputValue);
        }
  </script>



    <script>
        function isNumberKey(event) {
            var charCode = (event.which) ? event.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
</script>


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

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label ID="lblroomid" runat="server" Text="Label" style="display:none"></asp:Label>
    <asp:Label ID="lblbookid" runat="server" Text="Label" style="display:none"></asp:Label>

    <div class="contact">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="titlepage">
                        <h2>Book Now</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <asp:Panel ID="pnlRequest" runat="server" CssClass="main_form">
                        <div class="row">
                            <div style="display:flex">
                                <div class="col-md-6">
                                <asp:TextBox ID="txtName" CssClass="contactus" placeholder="Name" runat="server" onkeypress="return onlyAlphabets(event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvName" runat="server" ForeColor="Red" ControlToValidate="txtName" ErrorMessage="Please enter your name" Display="Dynamic" />
                                </div>
                            <div class="col-md-6">
                                <asp:TextBox ID="txtEmail" CssClass="contactus" placeholder="Email" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ForeColor="Red" ControlToValidate="txtEmail" ErrorMessage="Please enter your email address" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                    ValidationExpression="\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b"
                                    ErrorMessage="Please enter a valid email address" Display="Dynamic" />
                            </div>
                            </div>

                            <div style="display:flex">
                                <div class="col-md-6">
                                <asp:TextBox ID="txtPhone" CssClass="contactus" placeholder="Phone Number" runat="server" onkeypress="return isNumberKey(event);" MaxLength="10"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ForeColor="Red" ControlToValidate="txtPhone" ErrorMessage="Please enter your phone number" Display="Dynamic" />
                                </div>

                            <div class="col-md-6">
                                <asp:TextBox ID="txtAge" runat="server" CssClass="contactus" placeholder="Age" onkeypress="return isTwoDigitNumber(event);"></asp:TextBox><br />
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtAge"
                                    ErrorMessage="Age is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="txtAge" Type="Integer"
                                    MinimumValue="18" MaximumValue="99" ErrorMessage="Age must be between 18 and 99" Display="Dynamic" ForeColor="Red">
                             </asp:RangeValidator>
                            </div>
                            </div>

                            <div style="display:flex">
                                <div class="col-md-6">
                            <asp:TextBox ID="txtAdharCard" runat="server" CssClass="contactus" placeholder="Adhar Card" Required="true"></asp:TextBox><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtAdharCard"
                                ErrorMessage="Adhar Card is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>

                           <div class="col-md-6">
    <asp:TextBox ID="txtnc" runat="server" CssClass="contactus" placeholder="Number of Child" onkeypress="return isNumberKey(event);" Required="true"></asp:TextBox><br />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtnc"
        ErrorMessage="Number of Child is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>

</div>
                            </div>

                            <div style="display:flex">
                                          <div class="col-md-6">
                                              <br />
                                     <asp:TextBox ID="txtna" runat="server" CssClass="contactus" placeholder="Number Of Adult" Required="true"></asp:TextBox><br />
                               
                                    </div>
                                 <div class="file-preview col-md-6">
                                          <asp:Label ID="Label3" runat="server" Text="ID/PHOTOS"></asp:Label>
                                    <asp:FileUpload ID="FileUpload1" runat="server"  CssClass="contactus" onchange="previewFile()" />
                                     <br />
                                     <img id="previewImage" alt="Preview" style="display: none;" />
                                          </div>
                                
                                       </div>

                            
                            <div style="display:flex">
                              


                                <div class="col-md-6">
                                    

                                    </div>
                            </div>

                            <div style="display:flex">
                                 <div class="col-md-6">
                            <asp:Label ID="Label1" runat="server" Text="Check-In"></asp:Label>
                            <asp:TextBox ID="txtCheckIn" runat="server" CssClass="contactus" placeholder="Check-in Date" type="datetime-local" Required="true"></asp:TextBox><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ControlToValidate="txtCheckIn"
                                ErrorMessage="Check-in Date is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>


                            <div class="col-md-6">
                            <asp:Label ID="Label2" runat="server" Text="Check-Out"></asp:Label>
                            <asp:TextBox ID="txtCheckOut" CssClass="contactus" runat="server" placeholder="Check-out Date" type="datetime-local" Required="true"></asp:TextBox><br />
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtCheckOut"
                                ErrorMessage="Check-out Date is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                                </div>
                            </div>



                            <div class="col-md-12">
                                <%--<asp:Button ID="btnSend" CssClass="send_btn" Text="Send" runat="server" />--%>
                                <asp:Button ID="btnSubmit" CssClass="send_btn" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
                            </div>
                        </div>
                    </asp:Panel>
                </div>
                <div class="col-md-6">
                    <%-- <div class="map_main">
                     <div class="map-responsive">
                        <iframe src="https://www.google.com/maps/embed/v1/place?key=AIzaSyA0s1a7phLN0iaD6-UE7m4qP-z21pH0eSc&amp;q=Eiffel+Tower+Paris+France" width="600" height="400" frameborder="0" style="border:0; width: 100%;" allowfullscreen=""></iframe>
                     </div>
                  </div>--%>
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <div class="room-item">
                                <div class="image-container" style="border: 2px solid">
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("room_image","~/Admin/Roomimg/{0}") %>' Width="552px" Height="350px" CssClass="room-image" />
                                    <center>
                                        <h4><%# Eval("rtype") %>
                                            <br />
                                            <%# Eval("bedtype") %>
                                        </h4>
                                        <h2>₹ <%# Eval("rprice") %></h2>

                                        <h5><%# Eval("rcatg") %></h5>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
    </div>
    <!-- end contact -->

</asp:Content>
