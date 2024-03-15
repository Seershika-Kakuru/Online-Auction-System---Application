<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
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
int itemID = Integer.parseInt(request.getParameter("statusOfBidding"));

//create three result sets
//first for available auctions
ResultSet rs1 = stmt.executeQuery("select * from auction a where itemID = '" + itemID + "' and a.closingDate > now() and a.openingDate < now()");

//second for closed auctions
Statement stmt1 = con.createStatement();
ResultSet rs2 = stmt1.executeQuery("select * from auction a where itemID = '" + itemID + "' and a.closingDate < now()");
		
//third for future auctions
Statement stmt2 = con.createStatement();
ResultSet rs3 = stmt2.executeQuery("select * from auction a where itemID = '" + itemID + "' and a.openingDate > now()");
		
if(rs1.next()){
	out.println("THE ITEM YOU HAVE SELECTED IS NOW AVAILABLE!");
	%><br>
	<button onclick="window.location.href='showAuctions.jsp';">Go To The Auctions Page Now!</button>
	<br>
	<button onclick="window.location.href='ListOfItems.jsp';">Return To See Items</button>
	<% 
}
else if(rs2.next()){
	out.println("THE ITEM YOU HAVE SELECTED IS NO LONGER AVAILABLE!");
	%>
	<br>
	<button onclick="window.location.href='ListOfItems.jsp';">Return To See Items</button>
	<% 
	
}
else if(rs3.next()){
	out.println("THE ITEM YOU HAVE SELECTED WILL BE AVAILABLE IN THE FUTURE!");
	%>
	<br>
	<button onclick="window.location.href='showAuctions.jsp';">Go To The Auctions Page Now!</button>
	<br>
	<button onclick="window.location.href='ListOfItems.jsp';">Return To See Items</button>
	<% 
	
}


%>
</body>
</html>