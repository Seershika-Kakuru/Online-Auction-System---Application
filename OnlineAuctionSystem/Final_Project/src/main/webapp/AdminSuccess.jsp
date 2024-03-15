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
<body style = "font-size:16pt;">
<div>
<h1 align = center>
<i>
Admin Dashboard
</i>
</h1>
</div>
<%
    if ((session.getAttribute("userID") == null)) {
%>
<p style="font-size:16pt; position:relative; top:2px;" >
<br>You are not logged in<br/>
<a href="Login.jsp">Please Login</a>
</p>
<%} else {
	 ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	String userID = (session.getAttribute("userID")).toString();
	ResultSet username = stmt.executeQuery("select * from user where memberID='" + userID + "'");
	String name = "";
	if(username.next())name = username.getString("name");
%>  
<p  style="font-size:16pt; position:relative; top:2px;" >Welcome <%=name%>!  

<div class="frontend">
<h2 style = "font-size:16pt;">Want to generate a sales report? </h2>
<ul>
			<li><a href="GenerateSalesReport.jsp">Generate Sales Report</a></li>
</ul>
<a href="Logout.jsp" >Log out</a></p>
<%
    }
%>
</body>
</html>