<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Delete Auction</title>
</head>
<body>
<%@ page import ="java.sql.*" %>
<%

//part where user wants to edit their account info
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();

	int auctID = Integer.parseInt(request.getParameter("auctionID"));
	//out.print("AuctID: "+auctID);
	String userID = request.getParameter("userID");
	//out.print("UserID: "+userID);
	//out.print("ID: "+memberID);
	//out.print("Delete: "+ deleteAccount);

	boolean conditions = false;

	//making sure qID and userID are in the table and that the specific row the CR wants to respond to is in the table
	ResultSet result1;
	result1 = stmt.executeQuery("select * from auction");
	while(result1.next()){
	String sellerID = result1.getString("sellerID");
	int auctionID = result1.getInt("auctionID");
	//out.print(answertext);
	if(sellerID.equals(userID) && auctID == auctionID){
		conditions = true;
		break;
		}
	}


	if(conditions == false){
		out.print("Not a valid seller or no such auction exists!!");
		%>
		<button onclick="window.location.href='ViewCR.jsp';">Back to Questions</button>
		<%
	}else{
		String deleteAllAlerts = "DELETE from hasanalert where auctionID = '" + auctID + "'";
		stmt.executeUpdate(deleteAllAlerts);
		
		
		/*
		Statement stmt2 = con.createStatement();
		ResultSet result2;
		result2 = stmt2.executeQuery("select * from bid");
		while(result2.next()){
			int bidID = result2.getInt("bidID");
			int auctionID = result2.getInt("auctionID");
			if(auctID == auctionID){
  				String query2 = "DELETE from bid where bidID= '" + bidID + "'" ;
				stmt2.executeUpdate(query2);
				break;
			}
		}
		*/
		//delete all bids on this auction
		String DeleteAllBids = "DELETE from bid where auctionID = '" + auctID + "'";
		stmt.executeUpdate(DeleteAllBids);
		
		String query1 = "DELETE from auction where auctionID= '" + auctID + "'" ;
		stmt.executeUpdate(query1);
		
		out.print("This is a valid request!");
		
			%>
			<button onclick="window.location.href='ViewCR.jsp';">Back to Questions</button>
			<%
	}
	
	con.close();%>
	


</body>
</html>