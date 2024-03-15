<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>This Seller's Auctions</title>
</head>
<body style = "font-size:16pt;">
<button onclick="window.location.href='ShowAllSellersAndBuyers.jsp';">Return to View All Sellers and Buyers</button>
   
    <% 
    //Get the database connection
    ApplicationDB db = new ApplicationDB();	
   	Connection con = db.getConnection();
   	
   	//Create a SQL statement
   	Statement stmt = con.createStatement();

//String sellerID = (session.getAttribute("sellerID")).toString();
String sellerID = request.getParameter("sellerID");
ResultSet getAllAuctions;
getAllAuctions = stmt.executeQuery("select auctionID from auction where sellerID ='" + sellerID + "'");
%>

<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
</style>
<h1>All Auctions</h1>
<table style="width:100%">
<thead>
    <tr>
        <th>Auction ID</th>
    </tr>
</thead>
<tbody>
<%
while(getAllAuctions.next()){
int auction = getAllAuctions.getInt("auctionID");
out.print("<tr>");
out.print("<td>");
out.println(auction);

	}
	%>