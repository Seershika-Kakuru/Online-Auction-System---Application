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
<button onclick="window.location.href='RepresentativeSuccess.jsp';">Return to Your Dashboard</button>
	
	<%@ page import ="java.sql.*" %>
	
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
	
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
					
					<%while(result1.next()){%>
						<tr>
							<td><%=result1.getInt("q.qID")%></td>
							<td><%=result1.getInt("q.userID")%></td>
							<td><%=result1.getString("q.questionText")%></td>
							<td><%=result1.getString("q.answerText")%></td>
						</tr>
					<%}%>
					
	
	</table>
			
	<form action="AnswerCR.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Enter the details about the question you want to answer: </b></p>
	 <table style="font-size:16pt;">
	   <tr>    
	   <td>Enter the question ID: <input type="text" name="qID" placeholder="qID" required></td>
	   </tr>
	   <tr>    
	   <td>Enter the user ID : <input type="text" name="userID" placeholder="userID" required></td>
	   </tr>
	   <tr>    
	   <td>Enter your Answer : <input type="text" name="answer" placeholder="answer" required></td>
	   </tr>
	   </table>
	   <input type="submit" value="Submit Answer" style="font-size:16pt;">
	
	</form>	
	

			<%
			//close the connection.
			db.closeConnection(con);
			%>
		

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
		

	</body>
</html>

