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
<button onclick="window.location.href='Success.jsp';">Return to Your Dashboard</button>
	<%@ page import ="java.sql.*" %>
<%ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();	
Statement stmt = con.createStatement();
//select all items - itemID, item name, auction ID
ResultSet rs;
rs = stmt.executeQuery("select a.itemID, e.name, a.auctionID from electronicdevices e, auction a where e.eID = a.itemID"); %>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
</style>
<h1>All Items</h1>
<table style="width:100%">
<thead>
    <tr>
        <th>auction ID</th>
        <th>Item ID</th>
        <th>Item Name</th>
        <th>See Status of Bidding</th>
        <th>See Similar Items In The Preceding Month</th>
        <th>Add Item to WishList</th>
    </tr>
</thead>
<tbody>
<%

while(rs.next()){
	out.print("<tr>");
	out.print("<td>");
	out.print(rs.getInt("auctionID"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getInt("itemID"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getString("name"));
	out.print("</td>");
	out.print("<td>");
	out.print("<form action='statusOfBidding.jsp' method='post'><button name='statusOfBidding' type='submit' value='"
			+ rs.getInt("itemID") + "'>See Current Status Of Bidding</button></form>");
	out.print("</td>");
	out.print("<td>");
	out.print("<form action='similarItems.jsp' method='post'><button name='similarItems' type='submit' value='"
			+ rs.getInt("itemID") + "'>See Similar Items</button></form>");
	out.print("</td>");
	out.print("<td>");
	out.print("<form action='addItemToWishList.jsp' method='post'><button name='wishItem' type='submit' value='"
			+ rs.getInt("auctionID") + "'>Add Item To Wishlist</button></form>");
	out.print("</td>");
}


con.close();
%>

</tbody>
</table>

</body>
</html>