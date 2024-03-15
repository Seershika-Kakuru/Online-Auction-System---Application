<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ page import ="java.sql.*" %>
<%

	//all item data
	 boolean isLaptop = false;
	 boolean isSmartPhone = false;
	 boolean isTV = false;
	 String device = request.getParameter("device");
	 //out.println(device);
	 if(device.equals("isLaptop")){
		 isLaptop = true;
	 }
	 else if(device.equals("isSmartPhone")){
		 isSmartPhone = true;
	 }
	 else if(device.equals("isTV")){
		 isTV = true;
	 }
	String deviceName = request.getParameter("nameOfDevice");
    //String height = request.getParameter("height");
	double height = Double.parseDouble(request.getParameter("height"));
	//out.println(height);
	double width = Double.parseDouble(request.getParameter("width"));
	String color = request.getParameter("color");
	String company = request.getParameter("companyOrBrand");
	String version = request.getParameter("version");
	String chargingPort = request.getParameter("chargingPort");
	String storageString = request.getParameter("storage");
	double storage = 0;
	if(storageString.length() != 0)storage = Double.parseDouble(storageString);
	String yearOfMakeString = request.getParameter("yearOfMake");
	int yearOfMake = 0;
	if(yearOfMakeString.length() != 0)yearOfMake= Integer.parseInt(yearOfMakeString);
	String memoryString = request.getParameter("memory");
	double memory = 0;
	if(memoryString.length() != 0)memory = Double.parseDouble(memoryString);
	String quality = request.getParameter("quality");
	String displayTechnology = request.getParameter("displayTechnology");
	//all auction data
	double initialPrice = Double.parseDouble(request.getParameter("initialPrice"));
	double minPrice = Double.parseDouble(request.getParameter("minimumPrice"));
	double standardBidIncrement = Double.parseDouble(request.getParameter("standardBiddingIncrement"));
	String openingDate = request.getParameter("openingDate");
	SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date opendate = sdf1.parse(openingDate);
	java.sql.Timestamp openingTimestamp = new java.sql.Timestamp(opendate.getTime());
	
	String closingDate = request.getParameter("closingDate");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	java.util.Date date = sdf.parse(closingDate);
	java.sql.Timestamp closingTimestamp = new java.sql.Timestamp(date.getTime());
	//who's the seller -> the one who is logged in
	String sellerID = (session.getAttribute("userID")).toString();
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	
	//let us first save the item data in 'electronic devices' table
	String insert = "INSERT INTO electronicdevices(isLaptop, isSmartPhone, isTV, name, height, width, color, companyOrBrand, version, chargingPort, storage, yearOfMake, memory, quality, displayTechnology)"
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setBoolean(1, isLaptop);
	ps.setBoolean(2, isSmartPhone);
	ps.setBoolean(3, isTV);
	ps.setString(4, deviceName);
	ps.setDouble(5, height);
	ps.setDouble(6, width);
	ps.setString(7, color);
	ps.setString(8, company);
	ps.setString(9, version);
	ps.setString(10, chargingPort);
	ps.setDouble(11, storage);
	ps.setInt(12, yearOfMake);
	ps.setDouble(13, memory);
	ps.setString(14, quality);
	ps.setString(15, displayTechnology);
	//Run the query against the DB
	ps.executeUpdate();
	ResultSet rs = stmt.executeQuery("select max(eID) max from electronicdevices");
	int itemID = 0;
	if(rs.next())itemID = rs.getInt("max");
	//now let us save all the auction data
	String insert1 = "INSERT INTO auction(sellerID, itemID, initialPrice, hiddenMinimumPrice, standardBiddingIncrement, openingDate, closingDate)"
			+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps1 = con.prepareStatement(insert1);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps1.setString(1, sellerID);
	ps1.setInt(2, itemID);
	ps1.setDouble(3, initialPrice);
	ps1.setDouble(4, minPrice);
	ps1.setDouble(5, standardBidIncrement);
	ps1.setTimestamp(6,openingTimestamp);
	ps1.setTimestamp(7,closingTimestamp);
	//Run the query against the DB
	ps1.executeUpdate();
	con.close();
	
    response.sendRedirect("showAuctions.jsp");

%>

</body>
</html>