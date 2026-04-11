<%@ Page Title="" Language="C#" MasterPageFile="MasterPage.master" AutoEventWireup="true" CodeFile="Blog.aspx.cs" Inherits="Blog" %>

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

    <!-- blog -->
      <div  class="blog">
         <div class="container" style="">
            <div class="row" >
               <div class="col-md-12">
                  <div class="titlepage">
                     <h2>Blog</h2>
                     <p>Our All Full Support And Full Services  </p>
                  </div>
               </div>
            </div>
            <div class="row" style="" >
                <asp:Repeater ID="Repeater1" runat="server">
                    <ItemTemplate>
                           <div class="col-md-4">
                  <div class="blog_box">
                     <div class="blog_img">
                       <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("blogimg","Admin/blogimg/{0}") %>' Width="360px" Height="250px" CssClass="room-image"/>
                     </div>
                     <div class="blog_room">
                        <h3><%# Eval("blogname") %></h3>
                        <span><%# Eval("blogtitle") %> </span>
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
      <!-- end blog -->
</asp:Content>

