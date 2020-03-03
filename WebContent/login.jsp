<%-- 
    Document   : loginaction
    Created on : Feb 23, 2016, 3:43:53 PM
    Author     : java4
--%>

<%@page import="java.util.UUID"%>
<%@page import="java.security.SecureRandom"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.Dbcon.DbConnection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Random"%>
<%@page import="java.network.ThreadDemo"%>

<%
    Connection con = null;
    Statement st = null;
    ResultSet rs = null;


    String name = request.getParameter("name");
    String pass = request.getParameter("pass");
    String Eamil = request.getParameter("email");
    String dob = request.getParameter("dob");
    String Gender = request.getParameter("gen");
    String phone = request.getParameter("phone");
    String State = request.getParameter("state");
    String Country = request.getParameter("country");
    String secret = request.getParameter("secret");
    System.out.println("User Details" + phone + Gender + dob + State + Eamil + name + pass + Country);

    String skey = request.getParameter("skey1");
    String skey2 = request.getParameter("skey2");

    System.out.println("Skey: " + skey + "Skey2: " + skey2);
    session.setAttribute("secret_key1", skey);
    int status = Integer.parseInt(request.getParameter("status"));
    try {
        con = DbConnection.getConnection();
        st = con.createStatement();
        switch (status) {
            case 1:
                try {
                    rs = st.executeQuery("select * from reg where name='" + name + "' AND pass='" + pass + "'");
                    if (rs.next()) {
                        session.setAttribute("sssname", rs.getString("name"));
                        session.setAttribute("sssemail", rs.getString("email"));
                        session.setAttribute("sssstate", rs.getString("state"));
                        session.setAttribute("ssscountry", rs.getString("country"));
                        response.sendRedirect("chome.jsp?msg=success");
                    } else {
                        response.sendRedirect("cus.jsp?msgg=failed");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;
            case 2:

                try {
                    con = DbConnection.getConnection();
                    st = con.createStatement();
                    int i = st.executeUpdate("insert into reg(name, pass, email, dob, gen, phone, state, country) values ('" + name + "','" + pass + "','" + Eamil + "','" + dob + "','" + Gender + "','" + phone + "','" + State + "','" + Country + "')");
                    if (i != 0) {

                        response.sendRedirect("reg.jsp?msg=success");
                    } else {
                        response.sendRedirect("reg.jsp?msgg=failed");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;

            case 3:
                try {
                    if (name.equalsIgnoreCase("cloud") && pass.equalsIgnoreCase("cloud")) {
                        response.sendRedirect("cloud_home.jsp?msg=success");
                    } else {
                        response.sendRedirect("cloud.jsp?msgg=failed");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;

            case 4:
                try {
                    rs = st.executeQuery("select * from uploads where secretkey='" + skey + "'");
                    if (rs.next()) {
                        session.setAttribute("secretkay1", skey);
                        ThreadDemo demo = new ThreadDemo();
                        demo.run();
                        response.sendRedirect("download.jsp?msg=success");
                    } else {
                        response.sendRedirect("down.jsp?msgg=failed");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;
            case 5:
                try {
                    rs = st.executeQuery("select * from upload where fileaccess='" + pass + "'");
                    if (rs.next()) {
                        session.setAttribute("passd", pass);
                        response.sendRedirect("download.jsp?msg=success");
                    } else {
                        response.sendRedirect("down.jsp?msgg=failed");
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
                break;
            default:
                response.sendRedirect("index.html");
        }
    } catch (Exception ex) {
        ex.printStackTrace();
    }

%>