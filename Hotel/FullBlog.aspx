<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="FullBlog.aspx.cs" Inherits="FullBlog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>
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

    <asp:Label ID="lblblogid" runat="server" Text="Label" Visible="false"></asp:Label>
    <br />
    <div class="container" style="border:">
        <asp:Repeater ID="Repeater1" runat="server">
            <ItemTemplate>
                <div class="col-lg-12" style="border:;display:flex">
                    <div style="border:" class="col-md-6">
                        <div class="col-sm-12" style="border:">
                        <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("blogimg","~/Admin/Blogimg/{0}") %>' CssClass="room-image" Width="450px" Height="300px"/>
                     </div>
                        <br />
                    
                    <div class="col-sm-12" style="border:;">
                        <asp:Image ID="Image2" runat="server" ImageUrl='<%# Eval("blogimg2","~/Admin/Blogimg/{0}") %>' CssClass="room-image" Width="450px" Height="300px"/>
                     </div>
                        <br />
                    
                    <div class="col-sm-12" style="border:">
                        <asp:Image ID="Image3" runat="server" ImageUrl='<%# Eval("blogimg3","~/Admin/Blogimg/{0}") %>' CssClass="room-image" Width="450px" Height="300px"/>
                     </div>
                    </div>

                    <div class="col-md-6" style="border:">
                        <div class="col-sm-12" style="border:">
                        <h2 style="text-align:center;margin-top:100px; font-size:50px"><%# Eval("blogname") %></h2>
                            <h2><%# Eval("blogtitle") %></h2>
                            <br />
                            <h1 style="font-family:'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif"><%# Eval("blogdesc") %></h1>
                            <br />
                            <h1 style="font-family:'Segoe UI', Tahoma, Geneva, Verdana, sans-serif">Welcome to HEAVEN, where luxury meets comfort, and every stay is a memorable experience. Nestled in the heart of NEWYORK, our hotel offers a tranquil oasis amidst the vibrant energy of the city. Whether you're traveling for business or leisure, our exceptional amenities and personalized service ensure that your stay is nothing short of extraordinary.</h1>
                        </div>
                    </div>

                   <%-- --%>
               </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <br />
    <br />
    <div class="container">
        <center>
            <h1 style="font-family:'Bell MT'">OUR MORE BLOGS</h1>
        </center>
        <br />
         <div class="row" style="border:2px solid white" >
                <asp:Repeater ID="Repeater2" runat="server">
                    <ItemTemplate>
                           <div class="col-md-4">
                  <div class="blog_box">
                     <div class="blog_img">
                       <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("blogimg","~/Admin/blogimg/{0}") %>' Width="360px" Height="250px" CssClass="room-image"/>
                     </div>
                     <div class="blog_room" style="padding-bottom:50px">
                         <br />
                        <h3><%# Eval("blogname") %></h3>
                        <%--<span><%# Eval("blogtitle") %> </span> <br />--%>
                        <%--<p><%# Eval("blogdesc") %> </p> <br />--%>
                          <a href="FullBlog.aspx?blogid=<%# Eval("blogid") %>" class="zoom-link" style="color:white; width:250px;height:40px; background-color:rgb(176 71 71);border:none;border-radius:4%;text-align:center">VIEW MORE</a>
                    
                         </div>
                      </div>
               </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
         </div>
    </div>
</asp:Content>

