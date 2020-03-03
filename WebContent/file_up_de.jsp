<%-- 
    Document   : file_up_de
    Created on : Sep 16, 2016, 6:26:54 PM
    Author     : java4
--%>

<%@page import="java.Dbcon.DbConnection"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
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
                                                                <ul>
                                                                    <li id="button1"><a href="cloud_home.jsp">Home</a></li>
                                                                    <li id="button2"><a href="cus_details.jsp">Customer Details</a></li>
                                                                    <li id="button3"><a href="file_up_de.jsp">File Upload Details</a></li>
                                                                    <li id="button3"><a href="down_de.jsp">File Download Details</a></li>
                                                                    <li id="button4"><a href="reg.jsp">Logout</a></li>
                                                                </ul>
                                                            </div>
                                                            </div>
                                                            <!-- header ends -->
                                                            <!-- content begins -->

                                                            <div id="main">
                                                                <div id="right">
                                                                    <h4></h4>

                                                                    <!--==============================body start=================================-->
                                                                    <br><br><center><h2 style="font-size: 26px; color: #00AEFF; font-family: cursive">Uploaded file Details</h2>
                                                                                <br><table border="2" style="text-align: center; margin-left: 0px; border-color: black">
                                                                                        <tr>
                                                                                            <th style="text-align: center;width: 200px; font-size: 16px; color: brown">File ID</th>
                                                                                            <th style="text-align: center;width: 200px; font-size: 16px; color: brown">File Name</th>
                                                                                            <th style="text-align: center;width: 400px;  font-size: 16px; color: brown">Date</th>
                                                                                            <th style="text-align: center;width: 200px;  font-size: 16px; color: brown">Customer</th>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <%
                                                                                                String User = (String) session.getAttribute("sssname");
                                                                                                System.out.println(User);;
                                                                                                Connection con = null;
                                                                                                Statement st = null;
                                                                                                ResultSet rs = null;
                                                                                                try {
                                                                                                    con = DbConnection.getConnection();
                                                                                                    st = con.createStatement();
                                                                                                    rs = st.executeQuery("select * from uploads");
                                                                                                    while (rs.next()) {
                                                                                            %>
                                                                                            <td style="font-size: 16px"><br><%=rs.getString("id")%></td>  
                                                                                            <td style="font-size: 16px"><br><%=rs.getString("filename")%></td>   
                                                                                            <td style="font-size: 16px"><br><%=rs.getString("date")%></td>  
                                                                                            <td style="font-size: 16px"><br><%=rs.getString("cname")%></td>  
                                                                                        </tr>
                                                                                        <%
                                                                                                }
                                                                                            } catch (Exception ex) {
                                                                                                ex.printStackTrace();
                                                                                            }

                                                                                        %>
                                                                                    </table>
                                                                                    <br><br><br><br><br><br><br><br><br><br><br><br>
                                                                                                                                    <!--==============================end body=================================-->

                                                                                                                                    </div>
                                                                                                                                    <div id="left">
                                                                                                                                        <h3>Categories</h3>
                                                                                                                                        <div class="ul_bg">
                                                                                                                                            <ul class="categories">
                                                                                                                                                <li><a href="cloud_home.jsp">Cloud Home</a></li>
                                                                                                                                                <li><a href="cus_details.jsp">Customer Details</a></li>
                                                                                                                                                <li><a href="file_up_de.jsp">File Upload Details</a></li>
                                                                                                                                                <li><a href="down_de.jsp">File Download Details</a></li>
                                                                                                                                                <li><a href="reg.jsp">Logout</a></li>
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



