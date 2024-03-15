<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Edit Info</title>
</head>
<body>  
	<button onclick="window.location.href='RepresentativeSuccess.jsp';">Return to Your Dashboard</button>
	


	<form action="EditInfo.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Edit the users Account Details</b></p>
	Note: You can only edit the categories one at a time. If you want to change multiple attributes you will have to return to this page to enter the next change!
	 <table style="font-size:16pt;">
	   <tr>    
	   <td>Enter memberID: <input type="text" name="memberID" placeholder="memberID" required ></td>
	   </tr>
	   <tr>    
	   <td>Edit name: <input type="text" name="name" placeholder="name" ></td>
	   </tr>
	   <tr>    
	   <td>Edit password: <input type="text" name="password" placeholder="password" ></td>
	   </tr>
	   <tr>    
	   <td>Edit phone number: <input type="text" name="phonenumber" placeholder="phone #" ></td>
	   </tr>
	   <tr>    
	   <td>Edit email: <input type="text" name="email" placeholder="email" ></td>
	   </tr>
	   <tr>    
	   <td>Edit address: <input type="text" name="address" placeholder="address" ></td>
	   </tr>
	   <tr>    
	   <td>Delete Account: (Enter "delete" to comfirm the deletion of the account) <input type="text" name="delete" placeholder = "delete"/></td>
	   </tr>
	   </table>
	   <input type="submit" value="Submit" style="font-size:16pt;">
	   
	   </form>
	 <br>

	
	
</body>
</html>