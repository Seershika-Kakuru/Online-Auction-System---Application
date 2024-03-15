<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Make a Bid</title>
</head>
<body style = "font-size:16pt;">
<button onclick="window.location.href='showAuctions.jsp';">Return to See The Auctions</button>
   
    <% 
    //Get the database connection
    ApplicationDB db = new ApplicationDB();	
   	Connection con = db.getConnection();
   	
   	//Create a SQL statement
   	Statement stmt = con.createStatement();
   	
   	String userID = (session.getAttribute("userID")).toString();
   	String name = "";
   	ResultSet username = stmt.executeQuery("select * from user where memberID='" + userID + "'");
    if(username.next())name = username.getString("name");
   	
    int auctionID = Integer.parseInt(request.getParameter("auctionId"));
  
    //get the seller of the auction
		ResultSet rs;
		rs = stmt.executeQuery("select sellerID, standardBiddingIncrement from auction a where a.auctionID = '" + auctionID + "'");
		rs.next();
		out.println("<br>Make sure your standard bidding increment is equal or greater than: " + rs.getDouble("standardBiddingIncrement"));
   	if(userID.equals(rs.getString("sellerID"))){
		out.println("<br>YOU ARE THE SELLER, YOU CAN'T PARTICIPATE IN THE AUCTION");
	}
   	else{
   		
   		//check if the person if the person is already in the bidding table
   		// if he is then check if he is an autobidder
   		ResultSet inTheBiddingTable = stmt.executeQuery("select * from bid where buyerID='" + userID + "' and auctionID = '" + auctionID + "'");
   		if(inTheBiddingTable.next()){
   		     boolean isAutoBid = inTheBiddingTable.getBoolean("isAutoBid");
   		     if(isAutoBid)out.println("<br>YOU ARE AN AUTOBIDDER, YOU CANNOT BID AGAIN!");
   		     else{
	
	session.setAttribute("auctionID", auctionID);
	
	
	
	%>
	
	<br>
		<form method="post" action="InsertBid.jsp">
		<table>
		
		<tr>
		<td>Enter the Bidding Amount: </td><td><input type="number" step = "any" name="currentBidAmount" placeholder = "0.0" required></td>
		</tr>
		<tr>
		<td> Type of Bid:
		<select name = "type">
			<option>Manual</option>
			<option>Automatic</option>
		</select>
		</td>
		</tr>
		  <tr>
		  <td>Enter the Bidding Increment (For Automatic Bids ONLY): </td><td><input type="number" step = "any" name="bidIncrement" placeholder = "0.0" ></td>
		  </tr>
		  <tr>
		  <td>Enter the Upper Limit (For Automatic Bid ONLY): </td><td><input type="number" step = "any" name="upperLimit" placeholder = "0.0" ></td>
		  </tr>
		  </table>
	   	  <input type="submit" value="Add Bid!" style="font-size:16pt;">
	   
		</form>
	<br>
	
    <%}}else{
    	session.setAttribute("auctionID", auctionID);
    	
    %>
	
	<br>
		<form method="post" action="InsertBid.jsp">
		<table>
		
		<tr>
		<td>Enter the Bidding Amount: </td><td><input type="number" step = "any" name="currentBidAmount" placeholder = "0.0" required></td>
		</tr>
		<tr>
		<td> Type of Bid:
		<select name = "type">
			<option>Manual</option>
			<option>Automatic</option>
		</select>
		</td>
		</tr>
		  <tr>
		  <td>Enter the Bidding Increment (For Automatic Bids ONLY): </td><td><input type="number" step = "any" name="bidIncrement" placeholder = "0.0" ></td>
		  </tr>
		  <tr>
		  <td>Enter the Upper Limit (For Automatic Bid ONLY): </td><td><input type="number" step = "any" name="upperLimit" placeholder = "0.0" ></td>
		  </tr>
		  </table>
	   	  <input type="submit" value="Add Bid!" style="font-size:16pt;">
	   
		</form>
	<br>
	
    <%
    	
    	}
    }%>
</body>
</html>