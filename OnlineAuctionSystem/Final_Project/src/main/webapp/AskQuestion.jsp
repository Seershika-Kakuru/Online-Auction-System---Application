<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Edit Account</title>
</head>
<body style = "font-size:16pt;">
<button onclick="window.location.href='Success.jsp';">Return to your Dashboard</button>


    
	<br>
	<form action="InsertQuestion.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Enter the details about for your question</b></p>
	<table>
	<tr>
	<td>Note: If you would like to edit your account, delete your account, remove an auction or remove a bid please specify the following:</td>
	</tr>
	<tr>
	<td>Edit Account: Specify which of the following parameters you would like changed to: password, name, phoneNumber, email and address</td>
	</tr>
	<tr>
	<td>Delete Account: Please specify that you would like to delete your account!</td>
	</tr>
	<tr>
	<td>Remove an Auction: Please specify the auctionID you would like to remove!</td>
	</tr>
	<tr>
	<td>Remove a Bid: Please specify the bidID which you would like to remove!</td>
	</tr>
	</table>


	 <table style="font-size:16pt;">
	   <tr>    
	   <td>Enter your question: <input type="text" name="question" placeholder="question" required></td>
	   </tr>
	   </table>
	   <input type="submit" value="Submit Question" style="font-size:16pt;">
	</form>
	<br>
	<button onclick="window.location.href='BrowseQandA.jsp';">Click here to browse questions and answers</button>
	
</body>
</html>