<%-- 
    Document   : up
    Created on : Sep 14, 2016, 3:51:36 PM
    Author     : java4
--%>

<%@page import="java.security.SecureRandom"%>
<%@page import="java.network.ThreadDemo"%>
<%@page import="java.util.Random"%>
<%
    int a = Integer.parseInt(request.getParameter("mini"));
    int b = Integer.parseInt(request.getParameter("max"));
    int c = Integer.parseInt(request.getParameter("mini1"));
    int d = Integer.parseInt(request.getParameter("max1"));
    int mul = a*b*c*d;
    System.out.println("multipilication"+mul);
    System.out.println("A and B Value" + a + b);
    System.out.println("c and d Value" + c + d);
    Random RANDOM = new SecureRandom();
    int PASSWORD_LENGTH = 15;
    String letters = "qwertyuioplkjhgfdsazxcvbnm1234567890ZXCVBNMASDFGHJKLQWERTYUIOP";
    String key = "";
    for (int i = 0; i < PASSWORD_LENGTH; i++) {
        int index = (int) (RANDOM.nextDouble() * letters.length());
        key += letters.substring(index, index + 1);
    }
    session.setAttribute("Random_Key", key);
    System.out.println("Random_Key"+key);
    //LP
        Random LP = new SecureRandom();
    int LP_LENGTH = 3;
    String lp = "123456789";
    String lp_key = "";
    for (int i = 0; i < LP_LENGTH; i++) {
        int index = (int) (LP.nextDouble() * lp.length());
        lp_key += lp.substring(index, index + 1);
    }
    session.setAttribute("lp_Key", lp_key);
    System.out.println("lp_Key"+ lp_key);
    ThreadDemo thread = new ThreadDemo();
    thread.run();
    if (a < b && c < d) {

        response.sendRedirect("upload.jsp?msg=true");
    } else {
        response.sendRedirect("linear.jsp?msgg=failed");
    }

%>
