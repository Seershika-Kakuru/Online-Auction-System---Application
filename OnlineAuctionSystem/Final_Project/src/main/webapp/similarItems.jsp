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
<button onclick="window.location.href='ListOfItems.jsp';">Return to See The Items</button>
<br>
   
    <% 
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
    int itemID = Integer.parseInt(request.getParameter("similarItems"));
    out.println("Hello! " + name + ", All the items similar to the item with item ID " + itemID + " are:");
    
    //IMPLEMENTATION
    //getting the information about isLaptop, isSmartPhone, isTV for the item
    ResultSet infoOfItem = stmt.executeQuery("select e.name, e.isLaptop, e.isSmartPhone, e.isTV from electronicdevices e where e.eID = '" + itemID + "'");
    //ResultSet infoOfItem = stmt.executeQuery("select e.name from auction a, electronicdevices e where a.itemID='" + itemID + "' AND a.itemID=e.eID");
    
    String itemName = "";
    boolean isLaptop = false;
    boolean isSmartPhone = false;
    boolean isTV = false;
    if(infoOfItem.next()){
    	itemName = infoOfItem.getString("name");
    	isLaptop = infoOfItem.getBoolean("isLaptop");
    	isSmartPhone = infoOfItem.getBoolean("isSmartPhone");
    	isTV = infoOfItem.getBoolean("isTV");
    }
    //AT THESE POINT WE ALL HAVE ALL INFORMATION ABOUT THE PRESENT ITEM
   // String n = "";
   // while(infoOfItem.next()){
    	//  n = new String(infoOfItem.getString("name"));
   // }
    //itemName = new String(n);
  
 //IF THE PRESENT ITEM IS A LAPTOP, GET ALL LAPTOPS FROM THE PREVIOUS MONTH
 if(isLaptop){
	Statement stmt1 = con.createStatement();
    ResultSet prevMonthAuctions = stmt1.executeQuery("select * from electronicdevices e, auction a where MONTH(closingDate) = (MONTH(CURRENT_TIMESTAMP)-1) AND a.itemID=e.eID and e.isLaptop = true");
    
    //Create Table to Display Auction Information for All Similar Items
%>    
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
</style>
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
        <th>End Time</th>
    </tr>
</thead>
<tbody>
<% 
while(prevMonthAuctions.next()){
	//print all items except the current item
	if(!itemName.equals(prevMonthAuctions.getString("name"))){
		out.print("<tr>");
		out.print("<td>");
		out.print(prevMonthAuctions.getInt("auctionId"));
		out.print("</td>");
		out.print("<td>");
		out.print(prevMonthAuctions.getString("name"));
		out.print("</td>");
		out.print("<td>");
		out.print(prevMonthAuctions.getDouble("height"));
		out.print("</td>");
		out.print("<td>");
		out.print(prevMonthAuctions.getDouble("width"));
		out.print("</td>");
		out.print("<td>");
		out.print(prevMonthAuctions.getString("color"));
		out.print("</td>");
		out.print("<td>");
		out.print(prevMonthAuctions.getString("companyOrBrand"));
		out.print("</td>");
		out.print("<td>");
		out.print(prevMonthAuctions.getDouble("initialPrice"));
		out.print("</td>");
		out.print("<td>");
		out.print(prevMonthAuctions.getTimestamp("closingDate"));
		out.print("</td>");
		out.print("<td>");
	}}//end of while loop
}// end of if statement
 else if(isSmartPhone){
	 //IF THE PRESENT ITEM IS A SMART PHONE, GET ALL SMART PHONES FROM THE PREVIOUS MONTH
	 Statement stmt2 = con.createStatement();
	 ResultSet prevMonthAuctions = stmt2.executeQuery("select * from electronicdevices e, auction a where MONTH(closingDate) = (MONTH(CURRENT_TIMESTAMP)-1) AND a.itemID=e.eID and e.isSmartPhone = true");
	    
	    //Create Table to Display Auction Information for All Similar Items
	%>    
	<style>
	table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
	}
	</style>
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
	        <th>End Time</th>
	    </tr>
	</thead>
	<tbody>
	<% 
	while(prevMonthAuctions.next()){
		if(!itemName.equals(prevMonthAuctions.getString("name"))){
			out.print("<tr>");
			out.print("<td>");
			out.print(prevMonthAuctions.getInt("auctionId"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getString("name"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getDouble("height"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getDouble("width"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getString("color"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getString("companyOrBrand"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getDouble("initialPrice"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getTimestamp("closingDate"));
			out.print("</td>");
			out.print("<td>");
		}}//end of while loop
	 
 }//end of else if
 else if(isTV){
	 //IF THE PRESENT ITEM IS A TV, GET ALL TVs FROM THE PREVIOUS MONTH
	 Statement stmt3 = con.createStatement();
	 ResultSet prevMonthAuctions = stmt3.executeQuery("select * from electronicdevices e, auction a where MONTH(closingDate) = (MONTH(CURRENT_TIMESTAMP)-1) AND a.itemID=e.eID and e.isTV = true");
	    
	    //Create Table to Display Auction Information for All Similar Items
	%>    
	<style>
	table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
	}
	</style>
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
	        <th>End Time</th>
	    </tr>
	</thead>
	<tbody>
	<% 
	while(prevMonthAuctions.next()){
		if(!itemName.equals(prevMonthAuctions.getString("name"))){
			out.print("<tr>");
			out.print("<td>");
			out.print(prevMonthAuctions.getInt("auctionId"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getString("name"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getDouble("height"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getDouble("width"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getString("color"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getString("companyOrBrand"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getDouble("initialPrice"));
			out.print("</td>");
			out.print("<td>");
			out.print(prevMonthAuctions.getTimestamp("closingDate"));
			out.print("</td>");
			out.print("<td>");
		}}//end of while loop
	 
	 
 }
 
  con.close();//closing the connection
   %>
</body>
</html>