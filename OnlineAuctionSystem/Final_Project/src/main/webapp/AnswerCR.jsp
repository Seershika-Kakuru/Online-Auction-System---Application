<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Answer Question</title>
</head>
<body>
	<%@ page import ="java.sql.*" %>
<%

	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	int qID = Integer.parseInt(request.getParameter("qID"));
	String userID = request.getParameter("userID");
	String answerText = request.getParameter("answer");
	
	boolean qIDuserIDexists = false;
	
	//making sure qID and userID are in the table and that the specific row the CR wants to respond to is in the table
	ResultSet result1;
	result1 = stmt.executeQuery("select * from question");
	while(result1.next()){
		int questionid = result1.getInt("qID");
		//out.print(questionid);
		String userid = result1.getString("userID");
		//out.print(userid);
		String answertext = result1.getString("answerText");
		//out.print(answertext);
		if(qID == questionid && userID.equals(userid) && answertext == null){
			qIDuserIDexists = true;
			PreparedStatement stmt2 = con.prepareStatement("UPDATE question set answerText=? where qID = " + qID+ "");
			stmt2.setString(1, answerText);
			stmt2.executeUpdate();
			break;
			
			
		}
	}
	
	
	if(qIDuserIDexists == false){
		out.print("No such qID or userID exists try again!");%>
		<button onclick="window.location.href='ViewCR.jsp';">Back to Questions</button>
		<%con.close();
		
	}
	else{
		out.print("You have succesfuly entered an answer!");%>
		<button onclick="window.location.href='ViewCR.jsp';">Back to Questions</button>
		<%con.close();
	}
	

	


%>

</body>
</html>	 
	 
	 
	 
	 
	 
	 
	 
