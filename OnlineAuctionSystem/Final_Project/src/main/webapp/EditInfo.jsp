<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Edit User Info</title>
</head>
<body>
<button onclick="window.location.href='RepresentativeSuccess.jsp';">Return to Your Dashboard</button>
	<%@ page import ="java.sql.*" %>
<%

	//part where user wants to edit their account info
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	
	String memberID = request.getParameter("memberID");
	//out.print("ID: "+memberID);
	String deleteAccount = request.getParameter("delete");
	//out.print("Delete: "+ deleteAccount);
	
	//check if memberID is in user table
	boolean memberIDexists = false;
	ResultSet rs = stmt.executeQuery("select * from user");
	while(rs.next()){
		String ID = rs.getString("memberID");
		if(ID.equals(memberID)){
			memberIDexists = true;
		}
	}
	
	if(memberIDexists == true){
		int count = 0;
		if(! deleteAccount.equals("delete")){
			
			String name = request.getParameter("name");
			//out.println("Name:"+name);
			//out.print(name.length());
			String password = request.getParameter("password");
			//out.print(password.length());
			//out.println("Password"+password);
			String phonenumber = request.getParameter("phonenumber");
			//out.print(phonenumber.length());
			//out.println("Number:"+phonenumber);
			String email = request.getParameter("email");
			//out.print(email.length());
			//out.println("Email"+email);
			String address = request.getParameter("address");
			//out.print(address.length());
			//out.println("Address: "+address);
			
			if (name.length() != 0){
				//out.print("yes");
				count++;
			}
			if(password.length() != 0){
				//out.print("yess");
				count++;
			}
			if(phonenumber.length() != 0){
				//out.print("yesss");
				count++;
			}
			if(email.length() != 0){
				//out.print("yessss");
				count++;
			}
			if(address.length() != 0){
				//out.print("yessss");
				count++;
			}
			
			//out.print("Count: "+ count);
			
			if(count > 1){
				out.println("You cannot edit more than one category! Try again!");
				%>
				<button onclick="window.location.href='AccountInformation.jsp';">Go Back</button>
				<%
				
				
			}else if(count == 1 && name.length() != 0){
					//out.print("Yes1");
					PreparedStatement stmt2 = con.prepareStatement("UPDATE user set name=? where memberID = " + memberID+"");
					stmt2.setString(1, name);
					stmt2.executeUpdate();
					out.print("The account has been updated!");
					
			}else if(count == 1 && password.length() !=0){
					//out.print("Yes2");
					PreparedStatement stmt3 = con.prepareStatement("UPDATE user set password=? where memberID = " + memberID+ "");
					stmt3.setString(1, password);
					stmt3.executeUpdate();	
					out.print("The account has been updated!");
					
			}else if(count == 1 && phonenumber.length() != 0){
					//out.print("Yes3");
					PreparedStatement stmt4 = con.prepareStatement("UPDATE user set phoneNumber=? where memberID = " + memberID+ "");
					stmt4.setString(1, phonenumber);
					stmt4.executeUpdate();
					out.print("The account has been updated!");
			}else if(count == 1 && email.length()!= 0){
					//out.print("Yes4");
					PreparedStatement stmt5 = con.prepareStatement("UPDATE user set email=? where memberID = " + memberID+ "");
					stmt5.setString(1, email);
					stmt5.executeUpdate();
					out.print("The account has been updated!");
					
			}else if(count == 1 && address.length()!=0){
					//out.print("Yes5");
					PreparedStatement stmt6 = con.prepareStatement("UPDATE user set address=? where memberID = " + memberID+ "");
					stmt6.setString(1, address);
					stmt6.executeUpdate();
					out.print("The account has been updated!");
			}
			
			%>
			<button onclick="window.location.href='ViewCR.jsp';">Back to Questions</button>
			<%
				
		
			
			
		}else if(deleteAccount.equals("delete")){
			//have to delete this memberID everywhere, so in auction table, bid table, user table and enduser table
			//enduser contains all the member id so if we are deleting an account we need to delete the member id on the enduser table and the usertable. 
			Statement stmt4 = con.createStatement();
			ResultSet getAuction = stmt4.executeQuery("select * from auction where sellerID = '" + memberID + "'");
			while(getAuction.next()){
			
				int auctionID = getAuction.getInt("auctionID");
				out.println(auctionID);
				
			    ////delete the user from the auction table 
				
				//String deleteFromAuction = "DELETE from auction where sellerID = '" + memberID + "'";
				//stmt.executeUpdate(deleteFromAuction);
				
				String deleteAllAlerts = "DELETE from hasanalert where auctionID = '" + auctionID + "'";
				stmt.executeUpdate(deleteAllAlerts);
				
				
				//delete all bids on this auction
				String DeleteAllBids = "DELETE from bid where auctionID = '" + auctionID + "'";
				stmt.executeUpdate(DeleteAllBids);
				
			
			//we deleted the seller in the auction, but the auction cannot exist without the seller
			//delete auction
			String deleteAuction = "DELETE from auction where auctionID = '" + auctionID + "'";
			stmt.executeUpdate(deleteAuction);
			
			
			}
			String deleteAllAlerts = "DELETE from hasanalert where userID = '" + memberID + "'";
			stmt.executeUpdate(deleteAllAlerts);
			
			String deleteAllQuestions = "DELETE from question where userID = '" + memberID + "'";
			stmt.executeUpdate(deleteAllQuestions);
			
			String deleteAllWishesFor = "DELETE from wishesFor where userID = '" + memberID + "'";
			stmt.executeUpdate(deleteAllWishesFor);
			
			
			
			Statement stmt5 = con.createStatement();
			String DeleteAllBids = "DELETE from bid where buyerID = '" + memberID + "'";
			stmt.executeUpdate(DeleteAllBids);
			
			
			String query1 = "DELETE from enduser where userID = '" + memberID + "'" ;
			stmt.executeUpdate(query1);
			
			
			String query2 = "DELETE from user where memberID = '" + memberID + "'" ;
			stmt.executeUpdate(query2);	
			
			out.print("The account has been deleted!");
			%>
			<button onclick="window.location.href='ViewCR.jsp';">Back to Questions</button>
			<%
			
		}
		
	}else{
		out.print("memberID does not exist! Try again!");
		%>
		<button onclick="window.location.href='AccountInformation.jsp';">Go Back</button>
		<%
		
	}
	

	

	con.close();

	

%>

</body>
</html>