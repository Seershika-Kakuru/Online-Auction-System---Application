<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert Question</title>
</head>
<body>
	<%@ page import ="java.sql.*" %>
<%

	//all item data
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	String userID = (session.getAttribute("userID")).toString();
	String questionText = request.getParameter("question");
	
    

	String insert = "INSERT INTO question(userID, questionText)"
			+ "VALUES (?, ?)";
	//Create a Prepared SQL statement allowing you to introduce the parameters of the query
	PreparedStatement ps = con.prepareStatement(insert);

	//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
	ps.setString(1, userID);
	ps.setString(2, questionText);
	
	//Run the query against the DB
	ps.executeUpdate();
	
	con.close();
	
    response.sendRedirect("BrowseQandA.jsp");

%>

</body>
</html>