<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
        .container {
            /* display: flex;*/
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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- banner -->
    <section class="banner_main">
    <div id="myCarousel" class="carousel slide banner" data-ride="carousel" data-interval="2000">
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner">
        <asp:Repeater ID="rptcrousel" runat="server">
            <ItemTemplate>
                <div class="carousel-item <%# Container.ItemIndex == 0 ? "active" : "" %>">
                    <asp:Image ID="Image1" ImageUrl='<%# Eval("crouselimage","~/Admin/crouselimg/{0}") %>' runat="server" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
    </a>
    <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
    </a>
</div>

        <%--<div class="booking_ocline">
            <div class="container">
               <div class="row">
                  <div class="col-md-5">
                     <div class="book_room">
                        <h1>Book a Room Online</h1>
                        <div class="book_now">
                           <div class="row">
                              <div class="col-md-12">
                                 <span>Arrival</span>
                                 <img class="date_cua" src="images/date.png">
                                 <input class="online_book" placeholder="dd/mm/yyyy" type="date" name="dd/mm/yyyy">
                              </div>
                              <div class="col-md-12">
                                 <span>Departure</span>
                                 <img class="date_cua" src="images/date.png">
                                 <input class="online_book" placeholder="dd/mm/yyyy" type="date" name="dd/mm/yyyy">
                              </div>
                              <div class="col-md-12">
                                 <button class="book_btn">Book Now</button>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </div>--%>
    </section>
    <!-- end banner -->
    <!-- about -->
    <div class="about">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-5">
                    <div class="titlepage">
                        <h2>About Us</h2>
                        <p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it's seen all around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum. </p>
                        <a class="read_more" href="Javascript:void(0)">Read More</a>
                    </div>
                </div>
                <div class="col-md-7">
                    <div class="about_img">
                        <figure>
                            <img src="images/about.png" alt="#" /></figure>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- end about -->
    <!-- our_room -->
    <div class="our_room">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="titlepage">
                        <h2>Our Room</h2>
                        <p>The Best Comfortable and Favorite Choice For You </p>
                    </div>
                </div>
            </div>
            <div class="row" style="gap: 70px;">
                <asp:Repeater ID="Repeater1" runat="server">
                    <ItemTemplate>
                        <div class="room-item">
                            <div class="image-container" style="border: 2px solid">
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("room_image","~/Admin/Roomimg/{0}") %>' Width="330px" Height="250px" CssClass="room-image" />
                                <center>
                                    <h4><%# Eval("rtype") %></h4>
                                    <h5><%# Eval("bedtype") %></h5>
                                    <%--   <h2>₹ <%# Eval("rprice") %></h2>
                    
                    <h6><%# Eval("rcatg") %></h6>--%>
                                    <%--<h4><%# Eval("rdesc") %></h4>--%>
                                </center>

                            </div>

                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                   
                </div>
              <center>
                <h4 runat="server" id="booklink">
                    <a href="OurRoom.aspx" style="color:white; width:150px;height:25px; background-color:rgb(176 71 71);border:none;border-radius:4%;" class="zoom-link">VIEW MORE ROOM</a>
                </h4>
            </center>
        </div>


    </div>
    <!-- end our_room -->
    <!-- gallery -->
    <div class="gallery">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="titlepage">
                        <h2>gallery</h2>
                    </div>
                </div>
            </div>
            <div class="row" style="gap: 50px">

                <asp:Repeater ID="Repeater2" runat="server">
                    <ItemTemplate>
                        <div class="room-item">
                            <div class="image-container" style="border: 2px solid">
                                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("room_image","~/Admin/Roomimg/{0}") %>' Width="250px" Height="200px" CssClass="room-image" />
                                <center>
                                    <%--<h4><%# Eval("rtype") %></h4>--%>
                                    <%--<h5><%# Eval("bedtype") %></h5>--%>
                                    <%--   <h2>₹ <%# Eval("rprice") %></h2>
                    
                    <h6><%# Eval("rcatg") %></h6>--%>
                                    <%--<h4><%# Eval("rdesc") %></h4>--%>
                                </center>

                            </div>

                        </div>
                    </ItemTemplate>
                </asp:Repeater>
               
            </div>
             <center>
                <h4 runat="server" id="H1">
                    <a href="Gallery.aspx" style="color:white; width:160px;height:25px; background-color:rgb(176 71 71);border:none;border-radius:4%;" class="zoom-link">VIEW MORE GALLERY</a>
                </h4>
            </center>
        </div>
    </div>
    <!-- end gallery -->
    <!-- blog -->
    <div class="blog">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="titlepage">
                        <h2>Blog</h2>
                        <p>Our All Full Support And Full Services  </p>
                    </div>
                </div>
            </div>
            <div class="row">
                <asp:Repeater ID="Repeater3" runat="server">
                    <ItemTemplate>
                        <div class="col-md-4">
                            <div class="blog_box">
                                <div class="blog_img">
                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl='<%# Eval("blogimg","~/Admin/blogimg/{0}") %>' Width="360px" Height="250px" CssClass="room-image" />
                                </div>
                                <div class="blog_room">
                                    <h3><%# Eval("blogname") %></h3>
                                    <span><%# Eval("blogtitle") %> </span>
                                    <p><%# GetShortDescription(Eval("blogdesc")) %></p>

                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                
            </div>
             <center>
                <h4 runat="server" id="H2">
                    <a href="Blog.aspx" style="color:white; width:160px;height:25px; background-color:rgb(176 71 71);border:none;border-radius:4%;" class="zoom-link">VIEW MORE BLOG</a>
                </h4>
            </center>
        </div>
    </div>
    <!-- end blog -->
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
                            <iframe src="https://www.google.com/maps/embed/v1/place?key=AIzaSyA0s1a7phLN0iaD6-UE7m4qP-z21pH0eSc&amp;q=Eiffel+Tower+Paris+France" width="600" height="400" frameborder="0" style="border: 0; width: 100%;" allowfullscreen=""></iframe>
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
</asp:Content>

