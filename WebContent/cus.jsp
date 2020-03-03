<%-- 
    Document   : cus
    Created on : Sep 13, 2016, 4:52:15 PM
    Author     : java4
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <style> 

        .inputs {
            background: #DCEFF5;
            font-size: 0.9rem;
            -moz-border-radius: 3px;
            -webkit-border-radius: 3px;
            border-radius: 3px;
            border: none;
            padding: 10px 10px;
            width: 200px;
            margin-bottom: 20px;
            box-shadow: inset 0 2px 3px rgba( 0, 0, 0, 0.1 );
            clear: both;
        }

        .inputs:focus {
            background: #fff;
            box-shadow: 0 0 0 3px #33A3C9, inset 0 2px 3px rgba( 0, 0, 0, 0.2 ), 0px 5px 5px rgba( 0, 0, 0, 0.15 );
            outline: none;
        }
        .inputss {
            background: #DCEFF5;
            font-size: 0.9rem;
            -moz-border-radius: 3px;
            -webkit-border-radius: 3px;
            border-radius: 3px;
            border: none;
            padding: 10px 10px;
            width: 220px;
            margin-bottom: 20px;
            box-shadow: inset 0 2px 3px rgba( 0, 0, 0, 0.1 );
            clear: both;
        }

        .inputss:focus {
            background: #fff;
            box-shadow: 0 0 0 3px #33A3C9, inset 0 2px 3px rgba( 0, 0, 0, 0.2 ), 0px 5px 5px rgba( 0, 0, 0, 0.15 );
            outline: none;
        }
        .button {
            background-color: lightseagreen; /* Green */
            border: none;
            color: white;
            padding: 10px 27px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
        }
    </style> 
    <%
        if (request.getParameter("msgg") != null) {
    %>
    <script>alert('Please Enter Correct username and Password');</script>
    <%            }
    %>
    <head>
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <title>Secure Optimization Computation</title>
        <meta name="keywords" content="" />
        <meta name="description" content="" />
        <link href="styles.css" rel="stylesheet" type="text/css" media="screen" />
    </head>
    <body>
        <!-- header begins -->
        <div id="site_shadow">
            <div id="content">
                <div id="header">
                    <div>
                        <BR><h1><font style="color: #00060C">CypherDB: A Novel Architecture for Outsourcing Secure Database Processing</font></h1>
                    </div><br><br><br><br><br><br><br><br><br><br>
                                                            <div id="menu">
                                                                <ul>
                                                                    <li id="button1"><a href="index.jsp">Home</a></li>
                                                                    <li id="button2"><a href="cus.jsp">Customer</a></li>
                                                                    <li id="button3"><a href="cloud.jsp">Cloud</a></li>
                                                                    <li id="button4"><a href="reg.jsp">Registration</a></li>
                                                                </ul>
                                                            </div>
                                                            </div>
                                                            <!-- header ends -->
                                                            <!-- content begins -->

                                                            <div id="main">
                                                                <div id="right">
                                                                    <h4></h4>

                                                                    <!--==============================body start=================================-->
                                                                    <br><br><center><h2 style="font-size: 26px; color: #2198EA; font-family: cursive">Customer Login</h2>
                                                                                <br><form action="login.jsp" method="get"> 
                                                                                        <input type="text" class="inputs" name="name" required="" placeholder="Your Name" /><br> 
                                                                                            <input type="password" class="inputs" name="pass" required="" placeholder="Password" /><br> 
                                                                                                <input type="hidden" value="1" name="status" />
                                                                                                <input type="Submit" value="Login" class="button" >
                                                                                                    </form></center>

                                                                                                    <br><br><br>
                                                                                                                <!--==============================end body=================================-->

                                                                                                                </div>
                                                                                                                <div id="left">
                                                                                                                    <h3>Categories</h3>
                                                                                                                    <div class="ul_bg">
                                                                                                                        <ul class="categories">
                                                                                                                            <li><a href="index.jsp">Home</a></li>
                                                                                                                            <li><a href="cus.jsp">Customer</a></li>
                                                                                                                            <li><a href="cloud.jsp">Cloud</a></li>
                                                                                                                            <li><a href="reg.jsp">Registration</a></li>
                                                                                                                        </ul>
                                                                                                                    </div>
                                                                                                                </div><div style="clear:both"></div>
                                                                                                                <!--content ends -->
                                                                                                                <!--footer begins -->
                                                                                                                </div>
                                                                                                                <div id="footer">
                                                                                                                    <p>Copyright  2017. | <a href="#" ></a></p> 
                                                                                                                    <p>Design by <a href="#" title="Flash Templates">Asha</a> </p>
                                                                                                                </div>
                                                                                                                </div>
                                                                                                                </div>
                                                                                                                <!-- footer ends-->
                                                                                                                </body>
                                                                                                                </html>

