<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Sales Report</title>
</head>
<body style = "font-size:16pt;">
<button onclick="window.location.href='GenerateSalesReport.jsp';">Go Back</button>
	
	<%@ page import ="java.sql.*" %>
	
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String type = request.getParameter("type");
		
		
		//Checking if totalEarnings box is checked
		boolean totalEarnings = request.getParameter("totalEarnings") != null;
		boolean earningsPerItem = request.getParameter("earningsPerItem") !=null;
		boolean earningsPerItemType = request.getParameter("earningsPerItemType") !=null;
		boolean earningsPerEndUser = request.getParameter("earningsPerEndUser") !=null;
		boolean bestSellingItems = request.getParameter("bestSellingItems") !=null;
		boolean bestBuyers = request.getParameter("bestBuyers") !=null;
		
		if(totalEarnings==true){
			//out.print("Checkbox success");
			ResultSet rs;
			rs = stmt.executeQuery("select SUM(HighestBid) from auction where CURRENT_TIMESTAMP>closingDate"); 
			rs.next();
			%>
			<style>
			table, th, td {
			  border: 1px solid black;
			  border-collapse: collapse;
			}
			</style>
			<h1>Total Earnings</h1>
			<table style="width:100%">
			<thead>
			    <tr>
			        <th>Total Earnings</th>
			        
			    </tr>
			</thead>
			<tbody>
			<%
				out.print("<tr>");
				out.print("<td>");
				out.print(rs.getFloat(1));
				out.print("</td>");
				//out.println();
			%>

			</tbody>
			</table>
			<% 
		}
		
		if(earningsPerItem==true){
			ResultSet rs1;
			rs1 = stmt.executeQuery("select a.itemID, a.HighestBid, e.name from auction a, electronicdevices e where CURRENT_TIMESTAMP>closingDate AND a.auctionID=e.eID");
			%>
			
			<style>
			table, th, td {
 			 border: 1px solid black;
  			border-collapse: collapse;
				}
			</style>
			<h1>Total Earnings Per Item</h1>
			<table style="width:100%">
			<thead>
			    <tr>
			        <th>Item ID</th>
			        <th>Item Name</th>
			        <th>Amount</th>
			    </tr>
			</thead>
			<tbody>
			
			<% 
			while(rs1.next()){
				out.print("<tr>");
				out.print("<td>");
				out.print(rs1.getInt("itemID"));
				out.print("</td>");
				out.print("<td>");
				out.print(rs1.getString("e.name"));
				out.print("</td>");
				out.print("<td>");
				out.print(rs1.getFloat("HighestBid"));
				out.print("</td>");
			
			}
			
		}
		if(earningsPerItemType==true){
			ResultSet rs2;
			ResultSet rs3;
			ResultSet rs4;
			rs2 = stmt.executeQuery("select SUM(a.HighestBid) from auction a, electronicdevices e where a.itemID=e.eID AND e.isLaptop=true");
			rs2.next();
			float laptop = rs2.getFloat(1);
			rs3 = stmt.executeQuery("select SUM(a.HighestBid) from auction a, electronicdevices e where a.itemID=e.eID AND e.isSmartPhone=true");
			rs3.next();
			float SmartPhone = rs3.getFloat(1);
			rs4 = stmt.executeQuery("select SUM(a.HighestBid) from auction a, electronicdevices e where a.itemID=e.eID AND e.isTV=true");
			rs4.next();
			float tv = rs4.getFloat(1);
		
		%>
		</tbody>
			</table>
					<style>
			table, th, td {
			  border: 1px solid black;
			  border-collapse: collapse;
			}
			</style>
			<h1>Total Earnings Per Type of Item</h1>
			<table style="width:100%">
			<thead>
			    <tr>
			        <th>Item Type</th>
			        <th>Earnings</th>
			        
			    </tr>
			</thead>
			<tbody>
			<%
				out.print("<tr>");
				out.print("<td>");
				out.print("Laptop");
				out.print("</td>");
				out.print("<td>");
				out.print(laptop);
				out.print("<tr>");
				out.print("<td>");
				out.print("Smart Phone");
				out.print("</td>");
				out.print("<td>");
				out.print(SmartPhone);
				out.print("<tr>");
				out.print("<td>");
				out.print("TV");
				out.print("</td>");
				out.print("<td>");
				out.print(tv);
				out.print("</td>");
		
			%>

			</tbody>
			</table>
		
		<%
		}
		if(earningsPerEndUser==true){
			ResultSet rs5;
			rs5 = stmt.executeQuery("select u.userID, SUM(a.HighestBid) from auction a, enduser u where a.sellerID=u.userID GROUP BY(u.userID)");
		%>
		</tbody>
			</table>
					<style>
			table, th, td {
			  border: 1px solid black;
			  border-collapse: collapse;
			}
			</style>
			<h1>Total Earnings Per End-User</h1>
			<table style="width:100%">
			<thead>
			    <tr>
			        <th>User ID</th>
			        <th>Earnings</th>
			        
			    </tr>
			</thead>
			<tbody>
		<%
		while(rs5.next()){
		out.print("<tr>");
		out.print("<td>");
		out.print(rs5.getString("userID"));
		out.print("</td>");
		out.print("<td>");
		out.print(rs5.getFloat("SUM(a.HighestBid)"));
		out.print("</td>");
		}
		}
		if(bestSellingItems==true){
			ResultSet rs6;
			rs6 = stmt.executeQuery("select a.itemID, e.name, a.HighestBid from auction a, electronicdevices e where a.itemID = e.eID and a.HighestBid >= a.hiddenMinimumPrice and a.closingDate < now() order by a.HighestBid DESC LIMIT 3");
		%>
		</tbody>
			</table>
					<style>
			table, th, td {
			  border: 1px solid black;
			  border-collapse: collapse;
			}
			</style>
			<h1>Best-Selling Items</h1>
			<table style="width:100%">
			<thead>
			    <tr>
			        <th>Item ID</th>
			        <th>Item Name</th>
			        <th>Amount The Item Was Sold For</th>
			        
			    </tr>
			</thead>
			<tbody>
		<% 
		while(rs6.next()){
			out.print("<tr>");
			out.print("<td>");
			out.print(rs6.getInt("a.itemID"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs6.getString("e.name"));
			out.print("</td>");
			out.print("<td>");
			out.print(rs6.getFloat("a.HighestBid"));
		}
		}
		%>
		</tbody>
		</table>
		<%
		if(bestBuyers==true){
			ResultSet rs7;
			rs7 = stmt.executeQuery("select a.itemID, e.name, a.highestBidderID, a.HighestBid, u.name nameOfUser from auction a, electronicdevices e, user u where u.memberID = a.highestBidderId and a.itemID = e.eID and a.HighestBid >= a.hiddenMinimumPrice and a.closingDate < now() order by a.HighestBid DESC LIMIT 3");
		
		%>
		</tbody>
			</table>
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
			        <th>Name of Buyer</th>
			        <th>Member ID of Buyer</th>
			        <th>Item ID</th>
			        <th>Item Name</th>
			        <th>Amount The Item Is Sold For</th>
			    </tr>
			</thead>
			<tbody>
			<%
			while(rs7.next()){
				out.print("<tr>");
				out.print("<td>");
				out.print(rs7.getString("nameOfUser"));
				out.print("</td>");
				out.print("<td>");
				out.print(rs7.getString("a.highestBidderID"));
				out.print("</td>");
				out.print("<td>");
				out.print(rs7.getInt("a.itemID"));
				out.print("</td>");
				out.print("<td>");
				out.print(rs7.getString("e.name"));
				out.print("</td>");
				out.print("<td>");
				out.print(rs7.getFloat("a.HighestBid"));
			}
		}
			%>
		</tbody>
		</table>
			<% 
			//close the connection.
			db.closeConnection(con);
			%>
			
			<%} catch (Exception e) {
			out.print(e);
		}%>