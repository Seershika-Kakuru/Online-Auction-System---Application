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
<button onclick="window.location.href='AdminSuccess.jsp';">Return to Your Dashboard</button>
	<%@ page import ="java.sql.*" %>
<%ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();	
Statement stmt = con.createStatement();
//PLAN: SELECT THE TOP 3 FROM ITEMS ARRANGED IN DESCENDING ORDER BY THE AMOUNT THEY ARE SOLD FOR
//MAKE SURE THE HIGHEST BID > HIDDEN MINIMUM PRICE
//select a.itemID, e.name, a.HighestBid from auction a, electronicdevices e where a.itemID = e.eID and a.HighestBid > a.hiddenMinimumPrice order by a.HighestBid DESC LIMIT 3;
ResultSet rs = stmt.executeQuery("select a.itemID, e.name, a.highestBidderID, a.HighestBid, u.name nameOfUser from auction a, electronicdevices e, user u where u.memberID = a.highestBidderId and a.itemID = e.eID and a.HighestBid >= a.hiddenMinimumPrice and a.closingDate < now() order by a.HighestBid DESC LIMIT 3");
%>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
</style>
<h1>Best Buyers</h1>
<table style="width:100%">
<thead>
    <tr>
        <th>Name Of The Buyers</th>
        <th>Member IDs Of The Buyers</th>
        <th>Item ID</th>
        <th>Item Name</th>
        <th>Amount The Item Is Sold For</th>
    </tr>
</thead>
<tbody>
<%

while(rs.next()){
	out.print("<tr>");
	out.print("<td>");
	out.print(rs.getString("nameOfUser"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getInt("highestBidderID"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getInt("itemID"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getString("name"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getDouble("HighestBid"));
	out.print("</td>");
}
%>

</tbody>
</table>

<% con.close();
%>


</body>
</html>