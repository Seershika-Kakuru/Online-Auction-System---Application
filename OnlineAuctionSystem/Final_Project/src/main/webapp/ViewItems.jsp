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
<body style = "font-size:16pt;">
<button onclick="window.location.href='SearchSortItems.jsp';">Go Back</button>
	
	<%@ page import ="java.sql.*" %>
	
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String type = request.getParameter("sortType");
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
			<th>Name</th>
				<!-- View All value allows us user to view all items and we can see the status of bidding for each item -->
				<%if (type.equals("View All")){%>
				
					<th> Item ID </th>				
					<th> Auction ID </th>				
					<th>Type</th>				
					<th> Company </th>					
					<th> Year Of Make</th>			
					<th> Quality </th>				
					<th>Listed Price</th>	
					<th>Highest Bidder ID</th>			
					<th>Highest Bidding Amount</th>				
					<th> Opening Date </th>
					<th> Closing Date </th>
					
					<%ResultSet result1 = stmt.executeQuery("select * from electronicdevices e, auction a where e.eID = a.itemID ");%>
					
					
				</tr>
					
					<%while(result1.next()){%>
						<tr>
							<td><%=result1.getString("e.name")%></td>
							<td><%=result1.getInt("e.eID")%></td>
							<td><%=result1.getInt("a.auctionID")%></td>
							<td>
							<%	boolean laptop = result1.getBoolean("e.isLaptop");
								boolean phone = result1.getBoolean("e.isSmartPhone");
								boolean TV = result1.getBoolean("e.isTV");
								if(laptop == true){
									out.print("Laptop");
								}else if (phone == true){
									out.print("Smart Phone");
								}else {
									out.print("TV");
								}
							%>
							</td>
							<td><%=result1.getString("e.companyOrBrand")%></td>
							<td><%=result1.getInt("e.yearOfMake")%></td>
							<td><%=result1.getString("e.quality")%></td>
							<td><%=result1.getString("a.initialPrice")%></td>
							<td><%=result1.getInt("a.highestBidderID")%></td>
							<td><%=result1.getDouble("a.HighestBid")%></td>
							<td><%=result1.getTimestamp("a.openingDate")%></td>
							<td><%=result1.getTimestamp("a.closingDate")%></td>
							
						</tr>
					<%}%>
				
				<!-- if type is selected, shows only the type of each item -->		
				<%}else if(type.equals("Type")){ %>
				
					<th>Item ID </th>
					<th>Auction ID</th>
					<th>Type</th>
					</tr>
					
					<%ResultSet result1 = stmt.executeQuery("select * from electronicdevices e, auction a where e.eID = a.itemID ");%>
					
					<%while(result1.next()){%>
						<tr>
							<td><%=result1.getString("e.name")%></td>
							<td><%=result1.getInt("e.eID")%></td>
							<td><%=result1.getInt("a.auctionID")%></td>
							
							<td>
							<%	boolean laptop = result1.getBoolean("e.isLaptop");
								boolean phone = result1.getBoolean("e.isSmartPhone");
								boolean TV = result1.getBoolean("e.isTV");
								if(laptop == true){
									out.print("Laptop");
								}else if (phone == true){
									out.print("Smart Phone");
								}else {
									out.print("TV");
								}
							%>
							</td>
						</tr>
							
					<%}%>
					
					<!-- if company is selected, shows only the company(Sorted in ascending order) of each item -->	
				<%}else if(type.equals("Company")){%>
				
					<th>Item ID </th>
					<th>Auction ID</th>
					<th>Company</th>
					</tr>
					
					<%ResultSet result1 = stmt.executeQuery("select * from electronicdevices e, auction a where e.eID = a.itemID order by e.companyOrBrand asc");%>
					
					<%while(result1.next()){%>
						<tr>
							<td><%=result1.getString("e.name")%></td>
							<td><%=result1.getInt("e.eID")%></td>
							<td><%=result1.getInt("a.auctionID")%></td>
							<td><%=result1.getString("e.companyOrBrand")%></td>
						
						</tr>
					<%}%>
					
					<!-- if year is selected, shows only the year (sorted in ascending order) of each item -->
				<%}else if(type.equals("Year Of Make")){%>
				
					<th>Item ID </th>
					<th>Auction ID </th>
					<th>Year Of Make</th>
					
					</tr>
					
					<%ResultSet result1 = stmt.executeQuery("select * from electronicdevices e, auction a where e.eID = a.itemID order by e.yearOfMake asc");%>
					
					<%while(result1.next()){%>
						<tr>
							<td><%=result1.getString("e.name")%></td>
							<td><%=result1.getInt("e.eID")%></td>
							<td><%=result1.getInt("a.auctionID")%></td>
							<td><%=result1.getString("e.yearOfMake")%></td>
						
						</tr>
					<%}%>
					
					
				<!-- if quality is selected, shows only the quality (sorted in ascending order) of each item -->
				<%}else if(type.equals("Quality")){%>
				
					<th>Item ID </th>
					<th>Auction ID</th>
					<th>Quality</th>
					
					</tr>
					
					<%ResultSet result1 = stmt.executeQuery("select * from electronicdevices e, auction a where e.eID = a.itemID order by e.quality asc ");%>
					
					<%while(result1.next()){%>
						<tr>
							<td><%=result1.getString("e.name")%></td>
							<td><%=result1.getInt("e.eID")%></td>
							<td><%=result1.getInt("a.auctionID")%></td>
							<td><%=result1.getString("e.quality")%></td>
						
						</tr>
					<%}%>
					
				<!-- if listed price is selected, shows only the initialprice/listedprice (sorted in descending order) of each item -->	
				<%}else if(type.equals("Listed Price")){%>
				
					<th>Item ID </th>
					<th>Auction ID</th>
					<th>Listed Price</th>
					</tr>
					
					<%ResultSet result1 = stmt.executeQuery("select * from electronicdevices e, auction a where e.eID = a.itemID order by a.initialPrice desc ");%>
					
					<%while(result1.next()){%>
						<tr>
							<td><%=result1.getString("e.name")%></td>
							<td><%=result1.getInt("e.eID")%></td>
							<td><%=result1.getInt("a.auctionID")%></td>
							<td><%=result1.getString("a.initialPrice")%></td>
						
						</tr>
					<%}%>
					
					
				<!-- if bidding price is selected, shows only the bidding (sorted in descending order) of each item -->
				<%}else if(type.equals("Bidding Price")){%>
				
					<th>Item ID </th>
					<th>Auction ID</th>
					<th>Bidding Price</th>
					</tr>
					
					<%ResultSet result1 = stmt.executeQuery("select * from electronicdevices e, auction a where e.eID = a.itemID order by a.HighestBid desc ");%>
					
					<%while(result1.next()){%>
						<tr>
							<td><%=result1.getString("e.name")%></td>
							<td><%=result1.getInt("e.eID")%></td>
							<td><%=result1.getInt("a.auctionID")%></td>
							<td><%=result1.getString("a.HighestBid")%></td>
						
						</tr>
					<%}%>					
				
				
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



