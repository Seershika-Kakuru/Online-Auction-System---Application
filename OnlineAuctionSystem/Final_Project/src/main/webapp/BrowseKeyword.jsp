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
<button onclick="window.location.href='Success.jsp';">Back</button>
	
	<%@ page import ="java.sql.*" %>
	
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String keyword = request.getParameter("keyword");
	
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
			<th>Question ID</th>
			<th>User ID</th>
			<th>Question</th>
			<th>Answer</th>
		
			<%ResultSet result1 = stmt.executeQuery("select * from question q");%>
					
					
				</tr>
					
					<%while(result1.next()){
						String question = result1.getString("q.questionText");
							if(question.indexOf(keyword) != -1){%>
							<tr>
								<td><%=result1.getInt("q.qID")%></td>
								<td><%=result1.getInt("q.userID")%></td>
								<td><%=result1.getString("q.questionText")%></td>
								<td><%=result1.getString("q.answerText")%></td>
							</tr>								
								
							<%}%>

					<%}%>
					
	
	</table>
					
			<% 
			//close the connection.
			db.closeConnection(con);
			%>
		

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		

	</body>
</html>


