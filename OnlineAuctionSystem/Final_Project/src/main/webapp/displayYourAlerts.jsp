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
Statement stmt2 = con.createStatement();
String userID = (session.getAttribute("userID")).toString();
//================================================================================================================================
//Check the wishlist of the person
ResultSet WishList = stmt2.executeQuery("select * from wishesFor where userID = '" + userID + "'");
//now for each item in the wish list check if it is available
while(WishList.next()){
	//get itemID
	int itemID = WishList.getInt("eID");
	//now check if the item is in available auctions
	ResultSet availableAuctions;
	availableAuctions = stmt.executeQuery("select * from auction a where a.itemID = '" + itemID + "' and a.closingDate > now() and a.openingDate < now()");
	if(availableAuctions.next()){
	int auctionID = availableAuctions.getInt("auctionID");
	//check if the person is already a bidder in this auction
	Statement stmt5 = con.createStatement();
	ResultSet seeIfBidder = stmt5.executeQuery("select * from bid where buyerID = '" + userID + "' and auctionID = '" + auctionID + "'");
	if(!seeIfBidder.next()){
    String alert = "The item which you have added to your wishlist itemID: " + itemID + " is now available, see auctions page!";
    String insertAlert = "INSERT INTO hasanalert(userID, auctionID, eID, alertMessage)"
			+ "VALUES (?, ?, ?, ?)";
	PreparedStatement psAlert = con.prepareStatement(insertAlert);
	psAlert.setString(1, userID);
	psAlert.setInt(2, auctionID);
	psAlert.setInt(3, itemID);
	psAlert.setString(4, alert);

	//Run the query against the DB
	psAlert.executeUpdate();
	}}
}
//==================================================================================================================================
//CHECK IF THE PERSON IS A WINNER IN ANY AUCTION
//get all the auctions he participated -> only closed auctions
Statement stmt3 = con.createStatement();
ResultSet getAllClosedAuctions = stmt3.executeQuery("select * from bid b, auction a where b.auctionID = a.auctionID and b.buyerID = '" + userID + "' and a.closingDate < now()");
while(getAllClosedAuctions.next()){
	//FOR EACH AUCTION, CHECK IF THIS PERSON IS THE HIGHEST BIDDER
	//IF THE PERSON IS THE HIGHEST BIDDER
	//IF HE IS THE HIGHEST BIDDER, CHECK IF THE WINNER FOR THE AUCTION HAS ALREADY BEEN SET ONCE
	//IF IT IS SET, NO NEED TO SEND ANY ALERTS
	//IF IT IS NOT SET THEN CHECK IF THE HIGHEST BID > RESERVE
    //IF IT IS THEN SEND AN ALERT
	//out.println("Entered here");
	//get the highestBidderID
	String highestBidderID = getAllClosedAuctions.getString("highestBidderID");
	int auctionID = getAllClosedAuctions.getInt("auctionID");
	int itemID = getAllClosedAuctions.getInt("itemID");
	double highestBid = getAllClosedAuctions.getDouble("HighestBid");
	double reserve = getAllClosedAuctions.getDouble("hiddenMinimumPrice");
	boolean isWinner = getAllClosedAuctions.getBoolean("isWinner");
	if(userID.equals(highestBidderID)){
		if(!isWinner){
              if(highestBid >= reserve){
            	//update isWinner
				  String query = "update auction set isWinner = " + true + " where auctionID = '" + auctionID + "'";
				  stmt.executeUpdate(query);
				//send an alert
				 String alert = "Congratulations! You have emerged as the winner in the auction '" + auctionID + "'";
				    String insertAlert = "INSERT INTO hasanalert(userID, auctionID, eID, alertMessage)"
							+ "VALUES (?, ?, ?, ?)";
					PreparedStatement psAlert = con.prepareStatement(insertAlert);
					psAlert.setString(1, userID);
					psAlert.setInt(2, auctionID);
					psAlert.setInt(3, itemID);
					psAlert.setString(4, alert);

					//Run the query against the DB
					psAlert.executeUpdate();
			} 
			
		}
	}
}
//===================================================================================================================================
ResultSet rs;
rs = stmt.executeQuery("select * from hasanalert h where userID = '" + userID + "'"); %>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
</style>
<h1>Your Alerts</h1>
<table style="width:100%">
<thead>
    <tr>
        <th>alert ID</th>
        <th>Alert Message</th>
    </tr>
</thead>
<tbody>
<%

while(rs.next()){
	out.print("<tr>");
	out.print("<td>");
	out.print(rs.getInt("alertID"));
	out.print("</td>");
	out.print("<td>");
	out.print(rs.getString("alertMessage"));
	out.print("</td>");
}



con.close();
%>

</tbody>
</table>

</body>
</html>