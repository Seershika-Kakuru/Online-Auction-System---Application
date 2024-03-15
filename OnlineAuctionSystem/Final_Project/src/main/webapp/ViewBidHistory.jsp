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
<button onclick="window.location.href='Success.jsp';">Go Back</button>

<%@ page import ="java.sql.*" %>

<%
try {

//Get the database connection
ApplicationDB db = new ApplicationDB();
Connection con = db.getConnection();
//Create a SQL statement
Statement stmt = con.createStatement();
int auctionID = Integer.parseInt(request.getParameter("auctionID"));
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
<th> Buyer ID </th>
<th> Bid ID </th>
<th> Bid Type</th>
<th> Auction ID </th>
<th> Time of Bid </th>

<%ResultSet result1 = stmt.executeQuery("select * from bid b where b.auctionID = '"+ auctionID + "'");%>


</tr>

<%while(result1.next()){%>
<tr>
<td><%=result1.getInt("b.buyerID")%></td>
<td><%=result1.getInt("b.bidID")%></td>
<td><%=result1.getString("b.type")%></td>
<td><%=result1.getInt("b.auctionID")%></td>
<td><%=result1.getTimestamp("b.placedDate")%></td>

</tr>
<%}%>


<%
//close the connection.
db.closeConnection(con);
%>
</table>


<%} catch (Exception e) {
out.print(e);
}%>


</body>
</html>