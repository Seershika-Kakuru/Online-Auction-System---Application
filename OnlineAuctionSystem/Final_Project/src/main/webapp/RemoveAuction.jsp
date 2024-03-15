<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Info</title>
</head>
<body>  
<button onclick="window.location.href='RepresentativeSuccess.jsp';">Return to Your Dashboard</button>



<form action="RemoveAuctionCR.jsp" method="POST">
<p style = "font-size:16pt;"><b>Remove an Auction (Seller)</b></p>
<table style="font-size:16pt;">
  <tr>    
  <td>Enter userID: <input type="text" name="userID" placeholder="userID" ></td>
  </tr>
  <tr>    
  <td>Enter Auction ID: <input type="text" name="auctionID" placeholder="auctionID" ></td>
  </tr>
  </table>
  <input type="submit" value="Delete Auction" style="font-size:16pt;">
 
  </form>
<br>



</body>
</html>