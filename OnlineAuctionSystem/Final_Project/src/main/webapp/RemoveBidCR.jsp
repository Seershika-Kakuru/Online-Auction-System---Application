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
<button onclick="window.location.href='RepresentativeSuccess.jsp';">Return to Your Dashboard</button>
<%@ page import ="java.sql.*" %>
<%

//part where user wants to edit their account info
ApplicationDB db = new ApplicationDB();
Connection con = db.getConnection();
Statement stmt = con.createStatement();

int bidID = Integer.parseInt(request.getParameter("bidID"));
String userID = request.getParameter("userID");

boolean check = false;


//making sure qID and userID are in the table and that the specific row the CR wants to respond to is in the table
ResultSet result1;
result1 = stmt.executeQuery("select * from bid");
while(result1.next()){
	int ID = result1.getInt("bidID");
	String BuyerID = result1.getString("buyerID");
	//out.print(answertext);
	if(bidID == ID && userID.equals(BuyerID)){
	String query1 = "DELETE from bid where bidID= "+bidID+"" ;
	stmt.executeUpdate(query1);
	check = true;
	break;
	}
}

if(check == true){
	out.println("Deletion was successful!");
	%>
	<button onclick="window.location.href='ViewCR.jsp';">Back to Questions</button>
	<%
}
else{
	out.println("Deletion unsuccesful. No such userID has this bidID");
	%>
	<button onclick="window.location.href='ViewCR.jsp';">Back to Questions</button>
	<%
}

con.close();

%>








</body>
</html>