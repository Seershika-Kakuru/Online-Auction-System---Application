<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>  
	<button onclick="window.location.href='Success.jsp';">Return to Your Dashboard</button>

					  
	<br>
	<form action="BrowseKeyword.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Enter the keyword you would like to search for:</b></p>
	 <table style="font-size:16pt;">
	   <tr>    
	   <td>Enter your keyword: <input type="text" name="keyword" placeholder="keyword" required></td>
	   </tr>
	   </table>
	   <input type="submit" value="Submit" style="font-size:16pt;">
	</form>
	<br>
	
</body>
</html>