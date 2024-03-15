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

<br>
   
    <%
    try{
    //Get the database connection
    ApplicationDB db = new ApplicationDB();	
   	Connection con = db.getConnection();
   	
   	//Create a SQL statement
   	Statement stmt = con.createStatement();
   	
   	//getting userID which is the session attribute
   	String userID = (session.getAttribute("userID")).toString();
   	String name = "";
   	ResultSet username = stmt.executeQuery("select * from user where memberID='" + userID + "'");
    if(username.next())name = username.getString("name");
   	
    //getting values of button
    int auctionID = Integer.parseInt(request.getParameter("wishItem"));
    //get the sellerID for this auction
    ResultSet getSeller = stmt.executeQuery("select sellerID from auction where auctionID='" + auctionID + "' and sellerID = '" + userID + "'");
    if(getSeller.next()){
    	throw new IllegalArgumentException("YOU ARE THE SELLER OF THIS AUCTION, YOU CANNOT ADD ITEM TO WISHLIST");
    }
    
    //============================================================================================================
    //check if the item is in present auctions
    //if it is send an alert saying it is already available
    //get itemID, and item name using auction ID
    ResultSet rs;
    rs = stmt.executeQuery("select a.itemID, e.name from electronicdevices e, auction a where e.eID = a.itemID and a.auctionID = '" + auctionID + "' and a.closingDate > now() and a.openingDate < now()");
    int itemID = 0;
    String itemName = "";
    if(rs.next()){
    	itemID = rs.getInt("itemID");
    	itemName = rs.getString("name");
    String alert = "The item with itemID: " + itemID + " and item name: " + itemName + " is now available!";
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
	
  //============================================================================================================
    //check if the item is in past auctions
    //if it is send an alert saying it is no longer available
    //get itemID, and item name using auction ID
     ResultSet rs1;
    rs1 = stmt.executeQuery("select * from electronicdevices e, auction a where e.eID = a.itemID and a.auctionID = '" + auctionID + "' and a.closingDate < now()");
    int itemID1 = 0;
    String itemName1 = "";
    if(rs1.next()){
    	itemID1 = rs1.getInt("itemID");
    	itemName1 = rs1.getString("name");
    String alert1 = "The item with itemID: " + itemID1 + " and item name: " + itemName1 + " is no longer available!";
    String insertAlert1 = "INSERT INTO hasanalert(userID, auctionID, eID, alertMessage)"
			+ "VALUES (?, ?, ?, ?)";
	PreparedStatement psAlert1 = con.prepareStatement(insertAlert1);
	psAlert1.setString(1, userID);
	psAlert1.setInt(2, auctionID);
	psAlert1.setInt(3, itemID1);
	psAlert1.setString(4, alert1);

	//Run the query against the DB
	psAlert1.executeUpdate();
    }
	
	//===============================================================================================================
	//check if the item is in future auctions
	//If it is in the future auctions, then add it to the wishlist
	ResultSet rs2;
    rs2 = stmt.executeQuery("select  a.itemID, e.name from electronicdevices e, auction a where e.eID = a.itemID and a.auctionID = '" + auctionID + "' and a.openingDate > now()");
    int itemID2 = 0;
    String itemName2 = "";
    if(rs2.next()){
    	itemID2 = rs2.getInt("itemID");
    	itemName2 = rs2.getString("name");
    	//add to wishlist => eID, userID
        //check if the item is in the person's wishlist
    	Statement stmt1 = con.createStatement();
    	ResultSet inWishesFor = stmt1.executeQuery("select * from wishesFor where userID = '" + userID + "' and eID = '" + itemID2 + "'");
    	
    	if(inWishesFor.next()){
    		out.println("Enters Here!");
    		String alert2 = "The item with itemID: " 
                    + itemID2 + " and item name: " + itemName2 + " is ALREADY in your wishlist!";
  
              String insertAlert2 = "INSERT INTO hasanalert(userID, auctionID, eID, alertMessage)"
			+ "VALUES (?, ?, ?, ?)";
	           PreparedStatement psAlert2 = con.prepareStatement(insertAlert2);
	           psAlert2.setString(1, userID);
	           psAlert2.setInt(2, auctionID);
	           psAlert2.setInt(3, itemID2);
	           psAlert2.setString(4, alert2);

	           //Run the query against the DB
	          psAlert2.executeUpdate();
    	}
    	else{
             String insertWishItem = "INSERT INTO wishesFor(userID, eID)"
    			+ "VALUES (?, ?)";
             PreparedStatement psWishItem = con.prepareStatement(insertWishItem);
 	         psWishItem.setString(1, userID);
 	         psWishItem.setInt(2, itemID2);
 	         psWishItem.executeUpdate();
 	 
             String alert2 = "The item with itemID: " 
                      + itemID2 + " and item name: " + itemName2 + " has been added to your wishlist, you will notified to your Alerts Inbox when its available!";
    
             String insertAlert2 = "INSERT INTO hasanalert(userID, auctionID, eID, alertMessage)"
			                          + "VALUES (?, ?, ?, ?)";
	         PreparedStatement psAlert2 = con.prepareStatement(insertAlert2);
	         psAlert2.setString(1, userID);
	         psAlert2.setInt(2, auctionID);
	         psAlert2.setInt(3, itemID2);
	         psAlert2.setString(4, alert2);

	        //Run the query against the DB
	          psAlert2.executeUpdate();
           }
    }
    //=================================================================================================================
        //Close the connection.
  		con.close();
  		out.print("Check Your Alerts Inbox To See Status Of Item!");
  		%><button onclick="window.location.href='displayYourAlerts.jsp';">See your Alerts</button><%
    } catch(IllegalArgumentException iae) {
		  out.println(iae.getMessage());
		  out.println("<br>");
		  %><button onclick="window.location.href='ListOfItems.jsp';">Try To Add A Different Item To The WishList!</button><%
	}
    catch (Exception ex) {
		   out.print(ex);
	       out.println("<br>");
		  out.print("insert failed");
		    out.println("<br>");
		%><button onclick="window.location.href='ListOfItems.jsp';">Try Again To Add An Item!</button><%
   }%>
</body>
</html>