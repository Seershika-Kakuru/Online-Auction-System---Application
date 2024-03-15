<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>All Auctions</title>
</head>
<body style = "font-size:16pt;">

<%//Not Sure About This Button Thing%>
<button onclick="window.location.href='Success.jsp';">Return to Your Dashboard</button> 
	<%@ page import ="java.sql.*" %>
<%ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();	
Statement stmt = con.createStatement();

ResultSet rs;
rs = stmt.executeQuery("select distinct a.sellerID, u.name from auction a, user u where u.memberID = a.sellerID"); %>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
</style>
<h1>All Sellers</h1>
<table style="width:100%">
<thead>
    <tr>
        <th>Seller ID</th>
        <th>Name</th>
    </tr>
</thead>
<tbody>
<%

while(rs.next()){
	out.print("<tr>");
	out.print("<td>");
	out.print(rs.getString("sellerID"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getString("name"));
	out.print("</td>");
	out.print("<td>");
	out.print("<form action='ShowAuctionsForEverySeller.jsp' method='post'><button name='sellerID' type='submit' value='"
			+ rs.getString("sellerID") + "'> Show This Seller's Auctions</button></form>");
	out.print("</td>");
}
%>

</tbody>
</table>
<%
ResultSet rs1;
rs1 = stmt.executeQuery("select distinct b.buyerID, u.name from bid b, user u where u.memberID = b.buyerID"); %>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
</style>
<h1>All Buyers</h1>
<table style="width:100%">
<thead>
    <tr>
        <th>Buyer ID</th>
        <th>Name</th>
    </tr>
</thead>
<tbody>
<%

while(rs1.next()){
	out.print("<tr>");
	out.print("<td>");
	out.print(rs1.getString("buyerID"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs1.getString("name"));
	out.print("</td>");
	out.print("<td>");
	out.print("<form action='ShowAuctionsForEveryBuyer.jsp' method='post'><button name='buyerID' type='submit' value='"
			+ rs1.getString("buyerID") + "'> Show This Buyer's Auctions</button></form>");
	out.print("</td>");
}
con.close();
%>