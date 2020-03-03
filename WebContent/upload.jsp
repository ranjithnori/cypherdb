<%-- 
    Document   : upload
    Created on : Sep 14, 2016, 5:01:31 PM
    Author     : java4
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.Dbcon.uploadnew"%>
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
<!--                                                                <ul>
                                                                    <li id="button1"><a href="index.jsp">Home</a></li>
                                                                    <li id="button2"><a href="cus.jsp">Customer</a></li>
                                                                    <li id="button3"><a href="cloud.jsp">Cloud</a></li>
                                                                    <li id="button4"><a href="reg.jsp">Registration</a></li>
                                                                </ul>-->
                                                            </div>
                                                            </div>
                                                            <!-- header ends -->
                                                            <!-- content begins -->

                                                            <div id="main">
                                                                <div id="right">
                                                                    <h4></h4>

                                                                    <!--==============================body start=================================-->
                                                                    <center><h2 style="font-size: 26px; color: #00AEFF; font-family: cursive">File Upload</h2>
                                                                    <br><%
                                                                        String random = (String) session.getAttribute("Random_Key");
                                                                        System.out.println(random);
                                                                        String lp = (String) session.getAttribute("lp_Key");
                                                                        %>
                                                                        <center><form action="uploadnew"  method="post" enctype="multipart/form-data"> 
                                                                                <input type="text" class="inputs" name="skey" value="<%=lp%>" readonly="" /><br>
                                                                                    <input type="text" class="inputs" name="buplic" readonly="" Value="<%=random%>" /><br>
                                                                                        <input type="file" class="inputs" name="file" required=""  /><br> 
                                                                                            <input type="Submit" value="upload" class="button" >
                                                                                                </form></center>
                                                                                                <!--==============================end body=================================-->

                                                                                                </div>
                                                                                                <div id="left">
                                                                                                    <h3>Categories</h3>
                                                                                                    <div class="ul_bg">
                                                                                                        <ul class="categories">
<!--                                                                                                            <li><a href="index.jsp">Home</a></li>
                                                                                                            <li><a href="cus.jsp">Customer</a></li>
                                                                                                            <li><a href="cloud.jsp">Cloud</a></li>-->
                                                                                                            <li><a href="linear.jsp">Back</a></li>
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

