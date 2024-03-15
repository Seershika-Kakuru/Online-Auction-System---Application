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
<body style = "font-size:16pt;">  
	<button onclick="window.location.href='Success.jsp';">Return to Your Dashboard</button>

					  
		<br>
		<br>
		Sort And Search Auction Items by selecting a category:
		<form method="post" action="ViewItems.jsp">
		
			<select name = "sortType">
				<option>Type</option>
				<option>Company</option>
				<option>Year Of Make</option>
				<option>Quality</option>
				<option>Listed Price</option>
				<option>Bidding Price</option>
				<option>View All</option>
			</select>
			<br>
			<br>
			<input type="submit" value="Submit" style="font-size:16pt;">
			<br>
		</form>
		<br>
	
	
</body>
</html>