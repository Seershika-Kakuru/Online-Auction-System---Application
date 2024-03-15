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

ResultSet rs;
rs = stmt.executeQuery("select * from electronicdevices e, auction a where e.eID = a.itemID and a.closingDate > now() and a.openingDate < now()"); %>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
</style>
<h1>Available Auctions</h1>
<table style="width:100%">
<thead>
    <tr>
        <th>auction ID</th>
        <th>Name</th>
        <th>Height</th>
        <th>Width</th>
        <th>Color</th>
        <th>Company/Brand</th>
        <th>Initial Price</th>
        <th>Open Time</th>
        <th>End Time</th>
    </tr>
</thead>
<tbody>
<%

while(rs.next()){
	out.print("<tr>");
	out.print("<td>");
	out.print(rs.getInt("auctionId"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getString("name"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getDouble("height"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getDouble("width"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getString("color"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getString("companyOrBrand"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getDouble("initialPrice"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getTimestamp("openingDate"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getTimestamp("closingDate"));
	out.print("</td>");
	out.print("<td>");
	out.print("<form action='makeABid.jsp' method='post'><button name='auctionId' type='submit' value='"
			+ rs.getInt("auctionId") + "'> Make A Bid</button></form>");
	out.print("</td>");
}
%>

</tbody>
</table>
<%
Statement stmt1 = con.createStatement();
ResultSet rs1;
rs1 = stmt1.executeQuery("select * from electronicdevices e, auction a where e.eID = a.itemID and a.closingDate < now()"); %>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
</style>
<h1>Closed Auctions</h1>
<table style="width:100%">
<thead>
    <tr>
        <th>auction ID</th>
        <th>Name</th>
        <th>Height</th>
        <th>Width</th>
        <th>Color</th>
        <th>Company/Brand</th>
        <th>Initial Price</th>
        <th>Winner ID</th>
        <th>Amount Item Has Been Sold For</th>
        <th>Open Time</th>
        <th>End Time</th>
    </tr>
</thead>
<tbody>
<%

while(rs1.next()){
	//getting the highestBid and the hiddenMinimumPrice
	double highestBid = rs1.getDouble("HighestBid");
	double hiddenMinimumPrice = rs1.getDouble("hiddenMinimumPrice");
	String highestBidderID = rs1.getString("highestBidderID");
	out.print("<tr>");
	out.print("<td>");
	out.print(rs1.getInt("auctionId"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs1.getString("name"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs1.getDouble("height"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs1.getDouble("width"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs1.getString("color"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs1.getString("companyOrBrand"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs1.getDouble("initialPrice"));
	out.print("</td>");
	if(highestBid >= hiddenMinimumPrice){
		out.print("<td>");
		out.print(highestBidderID);
		out.print("</td>");
		out.print("<td>");
		out.print(highestBid);
		out.print("</td>");
	}
	else{
		out.print("<td>");
		out.print("NO WINNER");
		out.print("</td>");
		out.print("<td>");
		out.print("NO AMOUNT");
		out.print("</td>");
	}
	out.print("<td>");
	out.print(rs1.getTimestamp("openingDate"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs1.getTimestamp("closingDate"));
	out.print("</td>");

}
%>
</tbody>
</table>
<%
ResultSet rs2;
Statement stmt2 = con.createStatement();
rs2 = stmt2.executeQuery("select * from electronicdevices e, auction a where e.eID = a.itemID and a.openingDate > now()"); %>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
</style>
<h1>Future Auctions</h1>
<table style="width:100%">
<thead>
    <tr>
        <th>auction ID</th>
        <th>Name</th>
        <th>Height</th>
        <th>Width</th>
        <th>Color</th>
        <th>Company/Brand</th>
        <th>Initial Price</th>
        <th>Open Time</th>
        <th>End Time</th>
    </tr>
</thead>
<tbody>
<%

while(rs2.next()){
	out.print("<tr>");
	out.print("<td>");
	out.print(rs2.getInt("auctionId"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs2.getString("name"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs2.getDouble("height"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs2.getDouble("width"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs2.getString("color"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs2.getString("companyOrBrand"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs2.getDouble("initialPrice"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs2.getTimestamp("openingDate"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs2.getTimestamp("closingDate"));
	out.print("</td>");

}

con.close();
%>

</tbody>
</table>

</body>
</html>