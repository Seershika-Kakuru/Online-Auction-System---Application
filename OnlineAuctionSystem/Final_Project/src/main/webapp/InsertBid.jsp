<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>



	<%@ page import ="java.sql.*" %>
	
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Gets the buyerid which is the same as the userid
		String buyerID = (session.getAttribute("userID")).toString();
		//Gets the auction id 
		int auctionID = (Integer)(request.getSession().getAttribute("auctionID"));
		//Gets the bidding amount from what the buyer entered in Make a Bid page
		double currentBidAmount = Double.parseDouble(request.getParameter("currentBidAmount"));
		//Gets the type of Auction the bidder specified (Automatic or Manual)
		String type = request.getParameter("type");
		
		ResultSet rs;
		//selects the max current bid amount from the bid table of the previous users
		rs = stmt.executeQuery("select max(b.currentBidAmount) as max from bid b where b.auctionID = '" + auctionID + "'");
		rs.next();
		double highestBid = rs.getDouble("max");
		//checks if the current bidders amount is less than the highest bid amount
		if(currentBidAmount < highestBid){
			out.println("Entering here");
				boolean isAutoBid = false;
				//checks whether the buyer chose automatic or manual bidding in the Make a Bid page
				if (type.equals("Automatic")){
					isAutoBid = true;
					
					//if the user wanted automatic bidding, then they will specify the increment and upper limit
					 double bidIncrement = Double.parseDouble(request.getParameter("bidIncrement"));
					 double upperLimit = Double.parseDouble(request.getParameter("upperLimit"));
					 
					
					//initializing variables highestBidAmount and aIDABid 
					double highestBidAmount = 0;
					int aIDABid = 0;
					
					ResultSet r1;
					r1 = stmt.executeQuery("SELECT * FROM auction"); 
					while(r1.next()){
						//each time we loop, the two variables stores the highestBidAmount and auctionID for each row from the auction table
						highestBidAmount = r1.getDouble("HighestBid");
						aIDABid = r1.getInt("auctionID");
						double getStandard = r1.getDouble("standardBiddingIncrement");
				
						//checks the auctionID the bidder wanted to bid on equals the selected row auctionID (value stored in the aIDABid variable) 
						if (auctionID == aIDABid){
							if(bidIncrement < getStandard){
								throw new IllegalArgumentException("Your bidding increment is less than the standard biding increment");
							}
							//as we increment we dont want to keep incrementing once we have reached the highest bid value even if we havent reached the upperLimit yet
							//makes sure currentBidAmount doesnt exceed highestBid and that bidder has not reached their upperLimit
							if(currentBidAmount <= upperLimit){
							while((currentBidAmount <= highestBid)&& currentBidAmount <= upperLimit){ 
									//Alert(); //need to fix
									currentBidAmount = currentBidAmount + bidIncrement;	
							}}
						}
					}
					/*
					if(currentBidAmount >= upperLimit){
						//ALERT FOR UPPERLIMIT CROSSING
						//The bid amount has now crossed the upperlimit
						//send alert to the user
						//get itemID for this specific auction
						ResultSet getItemID = stmt.executeQuery("select a.itemID from auction a where a.auctionID = '" + auctionID + "'");
						int itemNum = 0;
						if(getItemID.next())itemNum = getItemID.getInt("itemID");
						String alert = "The current bid amount for auctionID: " + auctionID + " has crossed the upperLimit, please reset the upper limit for this auction";
						String insertAlert = "INSERT INTO hasanalert(userID, auctionID, eID, alertMessage)"
								+ "VALUES (?, ?, ?, ?)";
				    	PreparedStatement psAlert = con.prepareStatement(insertAlert);
				    	psAlert.setString(1, buyerID);
						psAlert.setInt(2, auctionID);
						psAlert.setInt(3, itemNum);
						psAlert.setString(4, alert);
					
						//Run the query against the DB
						psAlert.executeUpdate();
						
					}
					*/
					if(currentBidAmount >= highestBid){ //if after incrementing and the bidder reached the highest bid amount (and did not exceed their upper limit) then we can update the tables
						String query = "update auction set HighestBid = " + currentBidAmount + " where auctionID = '" + auctionID + "'";
						stmt.executeUpdate(query);
						String query1 = "update auction set highestBidderID = '" + buyerID + "' where auctionID = '" + auctionID + "'";
					    stmt.executeUpdate(query1);
					    //IMPLEMENTATION OF ALERT
					    //sending alerts to other users of this auction because now this current bidding amount > max
					     //get all users who are bidders in this auction
					     //then send the alerts to them that the highest bid has changed and ask them to bid some higher amount
					     //if the person is an automatic bidder, ask him to ignore the message
					     //hasanalert - userID, eID
					     
						ResultSet usersInAuction = stmt.executeQuery("select b.buyerID, a.itemID from bid b, auction a where b.auctionID = a.auctionID and a.auctionID = '" + auctionID + "'");
					    //once you get all the users
					    //get itemID
					   
					    //other than the present user
					    String alert = "Highest Bid has been changed for auctionID: " + auctionID + ", please bid a higher amount! <b>If you are an autobidder please ignore this message.</b>";
					    while(usersInAuction.next()){
					    	 String thisUserID = usersInAuction.getString("buyerID");
					    	 int itemID = usersInAuction.getInt("itemID");
					    	if(!thisUserID.equals(buyerID)){
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
					    	 if(!thisUserID.equals(buyerID)){
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
				    		 }}
				    	 }
					}
					

					
					String insert = "INSERT INTO bid(buyerId, auctionID, currentBidAmount, type,  placedDate, isAutoBid, bidIncrement, upperLimit)"
							+ "VALUES (?, ?, ?, ?, now(), ?, ?, ?)";
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(insert);

					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					ps.setString(1, buyerID);
					ps.setInt(2, auctionID);
					ps.setDouble(3, currentBidAmount);
					ps.setString(4, type);
					ps.setBoolean(5, isAutoBid);
					ps.setDouble(6, bidIncrement);
					ps.setDouble(7, upperLimit);
				
					//Run the query against the DB
					ps.executeUpdate();
					
					
					
				}else{ //the bidders currentamount< highestBid and wanted to do manual bidding 
					
					ResultSet r2;
					r2 = stmt.executeQuery("SELECT * FROM auction"); 
					double highestBidAmount = 0;
					int aIDMBid = 0;
					while(r2.next()){
						//each time we loop, the two variables stores the highestBidAmount and auctionID for each row from the auction table
						highestBidAmount = r2.getDouble("HighestBid"); 
						aIDMBid = r2.getInt("auctionID");
						//checks if the auctionID specifed by the bidder in the makeABid page is the same as the selected auctionID from our query
						if (auctionID == aIDMBid){
							if(currentBidAmount < highestBid){
								//Alert(); //Need to fix
							}	
						}
					}
					Statement stmt4 = con.createStatement();
				    ResultSet rsSome = stmt4.executeQuery("select * from bid where auctionID = '" + auctionID + "' and buyerID = '" + buyerID +"'" );
				    //if there is already a manual bid
				    //just update it
				    if(rsSome.next()){
				    String querySome = "update bid set currentBidAmount = " + currentBidAmount + " where auctionID = '" + auctionID + "'";
				    stmt.executeUpdate(querySome);}
				    else{
					String insert = "INSERT INTO bid(buyerId, auctionID, currentBidAmount,type, placedDate, isAutoBid)" //bid increment and upperlimit are not included - these values will be set to NULL (MANUAL BID)
							+ "VALUES (?, ?, ?, ?, now(), ?)";
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(insert);

					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					ps.setString(1, buyerID);
					ps.setInt(2, auctionID);
					ps.setDouble(3, currentBidAmount);
					ps.setString(4, type);
					ps.setBoolean(5, isAutoBid);
					
					
					//Run the query against the DB
					ps.executeUpdate();}
				}
			    
			

		}else{ //if the current bidding amount > max bid amount from the past users, then update the tables
			
				
			//out.println("Entering here 1");
			    //check if automatic bidding
				boolean isAutoBid = false;
				if (type.equals("Automatic")){
					isAutoBid = true;
					//if the user wanted automatic bidding, then they will specify the increment and upper limit
					 double bidIncrement = Double.parseDouble(request.getParameter("bidIncrement"));
					 double upperLimit = Double.parseDouble(request.getParameter("upperLimit"));
					 //get the standard bidding increment for the specific auction 
					 ResultSet standard = stmt.executeQuery("select standardBiddingIncrement from auction where auctionID = '" + auctionID + "'");
					 if(standard.next()){
						 double getStandard = standard.getDouble("standardBiddingIncrement");
						 if(bidIncrement < getStandard){
								throw new IllegalArgumentException("Your bidding increment is less than the standard biding increment");
								//java.lang. exception: ur bidding
						}
					 }
				
						
					String insert = "INSERT INTO bid(buyerId, auctionID, currentBidAmount, type,  placedDate, isAutoBid, bidIncrement, upperLimit)"
							+ "VALUES (?, ?, ?, ?, now(), ?, ?, ?)";
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(insert);

					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					ps.setString(1, buyerID);
					ps.setInt(2, auctionID);
					ps.setDouble(3, currentBidAmount);
					ps.setString(4, type);
					ps.setBoolean(5, isAutoBid);
					ps.setDouble(6, bidIncrement);
					ps.setDouble(7, upperLimit);
					
					//Run the query against the DB
					ps.executeUpdate();
					
				
					 
				}else{ //the bidders currentamount>max bid amount and they wanted manual bidding instead
					//check if the person already manually bidded
					//out.println("Entering here 1");
					Statement stmt4 = con.createStatement();
				    ResultSet rsSome = stmt4.executeQuery("select * from bid where auctionID = '" + auctionID + "' and buyerID = '" + buyerID +"'" );
				    //if there is already a manual bid
				    //just update it
				    if(rsSome.next()){
				    String querySome = "update bid set currentBidAmount = " + currentBidAmount + " where auctionID = '" + auctionID + "' and buyerID = '" + buyerID + "'";
				    stmt.executeUpdate(querySome);}
				    else{
					String insert = "INSERT INTO bid(buyerId, auctionID, currentBidAmount,type, placedDate, isAutoBid)" //bid increment and upperlimit are not included - these values will be set to NULL (MANUAL BID)
							+ "VALUES (?, ?, ?, ?, now(), ?)";
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(insert);

					//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
					ps.setString(1, buyerID);
					ps.setInt(2, auctionID);
					ps.setDouble(3, currentBidAmount);
					ps.setString(4, type);
					ps.setBoolean(5, isAutoBid);
					
					
					//Run the query against the DB
					ps.executeUpdate();}
					
				}
				String query = "update auction set HighestBid = " + currentBidAmount + " where auctionID = '" + auctionID + "'";
				stmt.executeUpdate(query);
				String query1 = "update auction set highestBidderID = '" + buyerID + "' where auctionID = '" + auctionID + "'";
			    stmt.executeUpdate(query1);	
			    //ALERT EXECUTION
			    ResultSet usersInAuction = stmt.executeQuery("select b.buyerID, a.itemID from bid b, auction a where b.auctionID = a.auctionID and a.auctionID = '" + auctionID + "'");
			    //once you get all the users
			    //get itemID
			   
			    //other than the present user
			    String alert = "Highest Bid has been changed for auctionID: " + auctionID + ", please bid a higher amount! <b>If you are an autobidder please ignore this message.</b>";
			    while(usersInAuction.next()){
			    	 String thisUserID = usersInAuction.getString("buyerID");
			    	 int itemID = usersInAuction.getInt("itemID");
			    	if(!thisUserID.equals(buyerID)){
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
			    	 if(!thisUserID.equals(buyerID)){
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
		    		 }}
		    	 }
		
		
		

		}
		//Close the connection.
		con.close();
		out.print("<br>insert succeeded");
		%><button onclick="window.location.href='Success.jsp';">Return to Your Dashboard</button><%
		
		
		
		} catch(IllegalArgumentException iae) {
		  out.println(iae.getMessage());
		  out.println("<br>");
		  out.println("insert failed");
		  out.println("<br>");
		  %><button onclick="window.location.href='showAuctions.jsp';">Try to Bid Again!</button><%
	     }catch (Exception ex) {
		   out.print(ex);
	       out.println("<br>");
		  out.print("insert failed");
		    out.println("<br>");
		%><button onclick="window.location.href='showAuctions.jsp';">Try to Bid Again!</button><%
	     }
        %>

</body>
</html>

