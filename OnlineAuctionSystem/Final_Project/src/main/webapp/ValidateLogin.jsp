<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page import ="java.sql.*" %>
<%
    String memberID = request.getParameter("MemberID");   
    String password = request.getParameter("Password");
    
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
    ResultSet rs1;
    rs1 = stmt.executeQuery("select * from user where memberID='" + memberID + "'");
    if (rs1.next()){
    	 ResultSet rs2;
    	    rs2 = stmt.executeQuery("select * from user where memberID='" + memberID + "' and password='" + password + "'");
    	    if (rs2.next()) {
    	    	ResultSet username;
    	    	username = stmt.executeQuery("select * from user where memberID='" + memberID + "' and password='" + password + "'");
    	    	String name = "";
    	    	if(username.next())name = username.getString("name");
    	    	ResultSet isEndUser = stmt.executeQuery("select * from enduser where userID='" + memberID + "'");
    	    	if(isEndUser.next())response.sendRedirect("Success.jsp");
    	    	else{
    	    		ResultSet isRep = stmt.executeQuery("select * from customerrepresentative where repID='" + memberID + "'");
    	    		if(isRep.next())response.sendRedirect("RepresentativeSuccess.jsp");
    	    		else{
    	    			Statement stmt1 = con.createStatement();
    	    			ResultSet isAdmin = stmt1.executeQuery("select * from admin where adminID='" + memberID + "'");
        	    		if(isAdmin.next())response.sendRedirect("AdminSuccess.jsp");
    	    		}
    	    	}
    	    	session.setAttribute("userID", memberID);
    	     
    	    } else {%>
    	        <p style = "font-size:16pt; position:relative; top:2px;"><b>Invalid entry in password! <a href='Login.jsp'>try again!</a></b></p><% 
    	    }
    }
    else{%>
    	<p style="font-size:16pt; position:relative; top:2px;"><b>MemberID doesn't exist. <a href= 'Register.jsp'>Register An Account or </a> <br> <a href = 'Login.jsp'>Go Back To The Login Page</a></b></p><%
    }
    con.close();
%>

</body>
</html>