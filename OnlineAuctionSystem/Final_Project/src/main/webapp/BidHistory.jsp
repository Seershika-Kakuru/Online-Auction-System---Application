<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Edit Account</title>
</head>
<body style = "font-size:16pt;">
<button onclick="window.location.href='Success.jsp';">Return to your Dashboard</button>


    
	<br>
	<form action="ViewBidHistory.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Enter the auctionID you want to see the history of Bids</b></p>
	 <table style="font-size:16pt;">
	   <tr>    
	   <td>Enter the auction ID: <input type="text" name="auctionID" placeholder="auctionID" required></td>
	   </tr>
	   </table>
	   <input type="submit" value="Submit Question" style="font-size:16pt;">
	</form>
	<br>
	
</body>
</html>