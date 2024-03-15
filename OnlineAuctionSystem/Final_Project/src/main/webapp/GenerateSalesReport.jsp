<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, java.text.SimpleDateFormat"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body style = "font-size:16pt;">

<%//Not Sure About This Button Thing%>
<button onclick="window.location.href='AdminSuccess.jsp';">Return to Your Dashboard</button> 
	<%@ page import ="java.sql.*" %>
<p style = "font-size:16pt;"><b>What would you like to include in your sales report?</b></p>
<form method="post" action="postReport.jsp">
	 <table style="font-size:16pt;">
       <tr>
	   <td>
	   </td>
	   </tr>
	   <tr>
	   <td>
	   <input type="checkbox" name="totalEarnings" value="totalEarnings"/> Total Earnings
	     <tr>
	   <td>
	   <input type="checkbox" name="earningsPerItem" value="earningsPerItem"/> Earnings Per Item
	     <tr>
	   <td>
	   <input type="checkbox" name="earningsPerItemType" value="earningsPerItemType"/> Earnings Per Item Type
	     <tr>
	   <td>
	   <input type="checkbox" name="earningsPerEndUser" value="earningsPerEndUser"/> Earnings Per End-User
	     <tr>
	   <td>
	   <input type="checkbox" name="bestSellingItems" value="bestSellingItems"/> Best-Selling Items
	   </td>
	   </tr>
	   <input type="checkbox" name="bestBuyers" value="bestBuyers"/> Best Buyers
	  
		<input type="submit" value="Submit" style="font-size:16pt;">
		</form>
	
	<%//FIX PLACEMENT OF SUBMIT BUTTON LATER %>
		
	  