<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Gallery.aspx.cs" Inherits="Gallery" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <style>
        .container2 {
   /* display: flex;*/
    /*flex-wrap: wrap;*/
    justify-content: space-between;
}

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
     height: 90%;
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



    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <div class="back_re">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="title">
                     <h2>Gallery</h2>
                  </div>
               </div>
            </div>
         </div>
      </div>

     <div  class="our_room">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="titlepage">
                     <p  class="margin_0"> The Best Comfortable and Favorite Choice For You</p>
                  </div>
               </div>
            </div>

         <div>
            
         </div>

             </div>
         </div>

    <div class="container2">
        <div class="row" style="gap:70px;padding-left:80px">
    <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
            <div class="room-item">
                <div class="image-container" style="border:2px solid">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("room_image","~/Admin/Roomimg/{0}") %>' Width="330px" Height="250px" CssClass="room-image"/>
                    <center>
                      <%--  <h4><%# Eval("rtype") %>
                            <br />
                            <%# Eval("bedtype") %>
                        </h4>
                         <h2>₹ <%# Eval("rprice") %></h2>
                    
                    <h5><%# Eval("rcatg") %></h5>--%>

        <div>
            <%--<asp:Button ID="btnbook" runat="server" Text="Book Now" width="250px" Height="45px"/>--%>
            <%--<asp:Label ID="lblbooknow" runat="server" Text="Book Now"  width="250px" Height="45px"></asp:Label>--%>
       

<%--<asp:LinkButton ID="bookNowButton" runat="server" CssClass="zoom-link" OnClick="bookNowButton_Click">Book Now</asp:LinkButton>--%>
            
            <%--<h3 style="border:2px solid black; width:250px; background-color:rgb(176 71 71);border:none;border-radius:4%;" class="zoom-link"><a href="BooknowForm.aspx?Roomid=<%# Eval("Roomid") %>" style="color:white">Book Now</a></h3>--%>
        </div>
                    </center>
                    <br />
               
                </div>
                
            </div>
        </ItemTemplate>
    </asp:Repeater>
            </div>
</div>
</asp:Content>

