<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

     <!--  contact -->
      <div class="contact">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <h2>Contact Us</h2>
                  </div>
               </div>
            </div>
            <div class="row">
               <div class="col-md-6">
                  <asp:Panel ID="pnlRequest" runat="server" CssClass="main_form">
            <div class="row">
                <div class="col-md-12">
                    <asp:TextBox ID="txtName" CssClass="contactus" placeholder="Name" runat="server" onkeypress="return onlyAlphabets(event);"></asp:TextBox>
                </div>
                <div class="col-md-12">
                  <asp:TextBox ID="txtEmail" CssClass="contactus" placeholder="Email" runat="server"></asp:TextBox>
<asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Please enter your email address" Display="Dynamic" />
<asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
    ValidationExpression="\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b"
    ErrorMessage="Please enter a valid email address" Display="Dynamic" />
                </div>

                <div class="col-md-12">
                    <asp:TextBox ID="txtPhoneNumber" CssClass="contactus" placeholder="Phone Number" runat="server" onkeypress="return isNumberKey(event);" maxlength="10"></asp:TextBox>
                </div>

                <div class="col-md-12">
                    <asp:TextBox ID="txtMessage" CssClass="textarea" placeholder="Message" TextMode="MultiLine" runat="server"></asp:TextBox>
                </div>
                <div class="col-md-12">
                    <asp:Button ID="btnSend" CssClass="send_btn" Text="Send" OnClick="btnSend_Click" runat="server" />
                </div>
            </div>
        </asp:Panel>
               </div>
               <div class="col-md-6">
                  <div class="map_main">
                     <div class="map-responsive">
                        <iframe src="https://www.google.com/maps/embed/v1/place?key=AIzaSyA0s1a7phLN0iaD6-UE7m4qP-z21pH0eSc&amp;q=Eiffel+Tower+Paris+France" width="600" height="400" frameborder="0" style="border:0; width: 100%;" allowfullscreen=""></iframe>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- end contact -->

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

    <%-- Phone number Valdition --%>
    <script>
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }
</script>
</asp:Content>

