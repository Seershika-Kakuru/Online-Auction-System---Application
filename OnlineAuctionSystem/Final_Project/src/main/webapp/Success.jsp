<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body style = "font-size:16pt;">
<div>
<h1 align = center>
<i>
Dashboard
</i>
</h1>
</div>
<%
    if ((session.getAttribute("userID") == null)) {
%>
<p style="font-size:16pt; position:relative; top:2px;" >
<br>You are not logged in<br/>
<a href="Login.jsp">Please Login</a>
</p>
<%} else {

   ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	Statement stmt1 = con.createStatement();
	String userID = (session.getAttribute("userID")).toString();
	String name = "";
	ResultSet username = stmt.executeQuery("select * from user where memberID='" + userID + "'");
	if(username.next())name = username.getString("name");
	ResultSet  getAllParticipatedAuctions;
	getAllParticipatedAuctions = stmt1.executeQuery("select b.buyerID, b.isAutoBid, b.bidIncrement, b.upperLimit, b.auctionID, b.currentBidAmount, a.HighestBid, a.highestBidderID from bid b, auction a where b.auctionID = a.auctionID and b.buyerID = '" + userID + "' and a.closingDate > now() and a.openingDate < now()");
	//out.println(getAllParticipatedAuctions.next());
		//if there are auctions participated, then iterate through each auction the person participated
		//out.println("Entering here");
		while(getAllParticipatedAuctions.next()){
			//out.println("Entering here");
			//now check for automatic bids
		    boolean isAutoBid = getAllParticipatedAuctions.getBoolean("isAutoBid");
			int auctionID = getAllParticipatedAuctions.getInt("auctionID");
			double currentBid = getAllParticipatedAuctions.getDouble("currentBidAmount");//current bid of the person for this particular auction -> bid table
			double highestBid = getAllParticipatedAuctions.getDouble("HighestBid"); //highest bid of this particular section -> auction
			String highestBidID = getAllParticipatedAuctions.getString("highestBidderID");
			if(isAutoBid){
				//out.println("Entering here");
				//if the person autobidded on this auction
				//then check if the current bid is less than the highest bid
				double increment = getAllParticipatedAuctions.getDouble("bidIncrement");
				double upperLimit = getAllParticipatedAuctions.getDouble("upperLimit");
				//out.println(currentBid);
				//out.println(highestBid);
				if(currentBid <= highestBid && !(userID.equals(highestBidID))){
					//out.println("Entering here");
					//increment until your highestBid
					if(currentBid <= upperLimit){//!=
					while((currentBid <= highestBid) && currentBid <= upperLimit){ 
						//Alert(); //need to fix
						currentBid = currentBid + increment;
				}}
					//out.println(currentBid);
					//out.println(upperLimit);
					/*
					if(currentBid >= upperLimit){
						//out.println("Entering here");
						//ALERT FOR UPPERLIMIT CROSSING
						//The bid amount has now crossed the upperlimit
						//send alert to the user
						//get itemID for this specific auction
						ResultSet getItemID = stmt.executeQuery("select a.itemID from auction a where a.auctionID = '" + auctionID + "'");
						int itemNum = 0;
						if(getItemID.next())itemNum = getItemID.getInt("itemID");
						String alert = "The current bid amount for auctionID: " + auctionID + " has crossed the upperLimit, please reset the upper limit for this auction 1";
						String insertAlert = "INSERT INTO hasanalert(userID, auctionID, eID, alertMessage)"
								+ "VALUES (?, ?, ?, ?)";
				    	PreparedStatement psAlert = con.prepareStatement(insertAlert);
				    	psAlert.setString(1, userID);
						psAlert.setInt(2, auctionID);
						psAlert.setInt(3, itemNum);
						psAlert.setString(4, alert);
					
						//Run the query against the DB
						psAlert.executeUpdate();
						
					}
					*/
					//update the current bid
					String query = "update bid set currentBidAmount = " + currentBid + " where auctionID = '" + auctionID + "' and buyerID = '" + userID + "'";
						stmt.executeUpdate(query);
						
                    if(currentBid >= highestBid){
					
						String query1 = "update auction set HighestBid = " + currentBid + " where auctionID = '" + auctionID + "'";
						stmt.executeUpdate(query1);
						String query2 = "update auction set highestBidderID = '" + userID + "' where auctionID = '" + auctionID + "'";
					    stmt.executeUpdate(query2);
					    //ALERT EXECUTION
					    ResultSet usersInAuction = stmt.executeQuery("select b.buyerID, a.itemID from bid b, auction a where b.auctionID = a.auctionID and a.auctionID = '" + auctionID + "'");
					    //once you get all the users
					    //get itemID

					    //other than the present user
					    String alert = "Highest Bid has been changed for auctionID: " + auctionID + ", please bid a higher amount! <b>If you are an autoidder please ignore this message.</b>";
					    while(usersInAuction.next()){
					    	 String thisUserID = usersInAuction.getString("buyerID");
					    	 int itemID = usersInAuction.getInt("itemID");
					    	if(!thisUserID.equals(userID)){
					    	//you need to insert an alert for each of the user except for the current user
					    	String insertAlert = "INSERT INTO hasanalert(userID, auctionID, eID, alertMessage)"
									+ "VALUES (?, ?, ?, ?)";
					    	PreparedStatement psAlert = con.prepareStatement(insertAlert);
					    	psAlert.setString(1, thisUserID);
							psAlert.setInt(2, auctionID);
							psAlert.setInt(3, itemID);
							psAlert.setString(4, alert);
						
							//Run the query against the DB
							psAlert.executeUpdate();
					    	}
					    
					}
					    //ADDING CODE TO ALERT ALL THE AUTOBIDDERS IN CASE THE HIGHEST BID NOW IS GREATER THAN THEIR UPPER LIMIT
				    	 String alertAutoBidder = "For auction: " + auctionID + ", someone has placed a bid higher than your upper limit</b>";
				    	 //get all autobidders for this auction
				    	 Statement stmt6 = con.createStatement();
				    	 ResultSet allAutoBiddersInAuction = stmt6.executeQuery("select * from bid b, auction a where a.auctionID = b.auctionID and a.auctionID = '" + auctionID + "' and b.type = 'Automatic'");
				    	 //for all autobidders check if the highest bid now is greater than the upperlimit
				    	 while(allAutoBiddersInAuction.next()){
				    		 String thisUserID = allAutoBiddersInAuction.getString("buyerID");
					    	 int itemID = allAutoBiddersInAuction.getInt("itemID");
					    	 if(!thisUserID.equals(userID)){
				    		 if(allAutoBiddersInAuction.getDouble("upperLimit") < allAutoBiddersInAuction.getDouble("HighestBid")){
				    			 //if it is less send an alert
				    			 String insertAlertAutoBid = "INSERT INTO hasanalert(userID, auctionID, eID, alertMessage)"
											+ "VALUES (?, ?, ?, ?)";
							    	PreparedStatement psAlertAutoBid = con.prepareStatement(insertAlertAutoBid);
							    	psAlertAutoBid.setString(1, thisUserID);
									psAlertAutoBid.setInt(2, auctionID);
									psAlertAutoBid.setInt(3, itemID);
									psAlertAutoBid.setString(4, alertAutoBidder);
								
									//Run the query against the DB
									psAlertAutoBid.executeUpdate();
				    		 }}}
				    	 }
				}
			}
			
		}
%>
<p  style="font-size:16pt; position:relative; top:2px;" >Welcome <%=name%>!  

<div class="frontend">
<h2 style = "font-size:16pt;">Want to Sell an Item? </h2>
<ul>
			<li><a href="CreateAnAuction.jsp">Create Auction</a></li>
			<li><a href="showAuctions.jsp">See all Auctions</a></li>
</ul>
<h2 style = "font-size:16pt;">Want to Make a Bid on an Item? </h2>
<ul>
			<li><a href="showAuctions.jsp">Make a Bid</a></li>
</ul>
<h2 style = "font-size:16pt;">Want to See Your Alerts? </h2>
<ul>
			<li><a href="displayYourAlerts.jsp">See Alerts</a></li>
</ul>
</div>
<h2 style = "font-size:16pt;">Want to Sort And Search Items? </h2>
<ul>
			<li><a href="SearchSortItems.jsp">View Items Based On Your Preferred Criteria</a></li>
</ul>
<h2 style = "font-size:16pt;">Want to browse history of bids? </h2>
<ul>
			<li><a href="BidHistory.jsp">View History of Bids</a></li>
</ul>
<h2 style = "font-size:16pt;"> Want to browse Questions and Answers? </h2>
<ul>
	<li><a href="BrowseQandA.jsp">View All Questions and Answers</a></li>
	<li><a href="SearchBrowseQandA.jsp">Search for Questions</a></li>
</ul>
<h2 style = "font-size:16pt;"> Need Help? </h2>
<ul>
	<li><a href="AskQuestion.jsp">Speak with a Customer Representative</a></li>

</ul>
<h2 style = "font-size:16pt;">Want to view all sellers and buyers? </h2>
<ul>
			<li><a href="ShowAllSellersAndBuyers.jsp">View all sellers and buyers</a></li>
</ul>
<h2 style = "font-size:16pt;">Want to See Item Related Information: </h2>
<ul>
			<li><a href="ListOfItems.jsp">See List Of Items to Find Similar Items and Add To Wishlist</a></li>
</ul>
</div>
<%
con.close();}
%>
<p><a href="Logout.jsp" >Log out</a></p>

</body>
</html>