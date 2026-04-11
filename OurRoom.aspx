<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="OurRoom.aspx.cs" Inherits="OurRoom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
        .container2 {
    display: flex;
    flex-wrap: wrap;
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

.zoom-link {
    display: inline-block;
}

/* Define keyframes for zoom in */
@keyframes zoomIn {
    0% {
        transform: scale(1); /* Start with normal size */
    }
    50% {
        transform: scale(1.1); /* Zoom in to 10% larger size */
    }
    100% {
        transform: scale(1); /* Return to normal size */
    }
}

/* Define keyframes for zoom out */
@keyframes zoomOut {
    0% {
        transform: scale(1.1); /* Start with zoomed-in size */
    }
    50% {
        transform: scale(1); /* Zoom out to normal size */
    }
    100% {
        transform: scale(1.1); /* Return to zoomed-in size */
    }
}

/* Apply animations to the link */
.zoom-link {
    animation: zoomInOut 1s infinite alternate; /* Zoom in and out animation */
}

/* Combine zoom in and out animations */
@keyframes zoomInOut {
    0%, 100% {
        transform: scale(1); /* Start and end with normal size */
    }
    50% {
        transform: scale(1.1); /* Zoom in to 10% larger size */
    }
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="back_re">
         <div class="container">
            <div class="row">
               <div class="col-md-12">
                  <div class="title">
                     <h2>Our Room</h2>
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
        <div class="row" style="padding-left:90px; gap:50px">
             <asp:Repeater ID="Repeater1" runat="server">
        <ItemTemplate>
            <div class="room-item">
                <div class="image-container" style="border:2px solid">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("room_image","Admin/Roomimg/{0}") %>' Width="330px" Height="250px" CssClass="room-image"/>
                    <center>
                        <h4><%# Eval("rtype") %>
                            <br />
                            <%# Eval("bedtype") %>
                        </h4>
                         <h2>₹ <%# Eval("rprice") %></h2>
                    
                    <h5><%# Eval("rcatg") %></h5>

        <div>
            <%--<asp:Button ID="btnbook" runat="server" Text="Book Now" width="250px" Height="45px"/>--%>
            <%--<asp:Label ID="lblbooknow" runat="server" Text="Book Now"  width="250px" Height="45px"></asp:Label>--%>
            <%--<asp:LinkButton ID="bookNowButton" runat="server" CssClass="zoom-link" OnClick="bookNowButton_Click">Book Now</asp:LinkButton>--%>
            
            <h3 runat="server" id="booklink"><a href="BooknowForm.aspx?Roomid=<%# Eval("Roomid") %>" style="color:white; width:250px;height:40px; background-color:rgb(176 71 71);border:none;border-radius:4%;" class="zoom-link">Book Now</a></h3>
            <asp:Label ID="lblbooked" runat="server" Text="BOOKED" ForeColor="red" Visible="false"></asp:Label>
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

