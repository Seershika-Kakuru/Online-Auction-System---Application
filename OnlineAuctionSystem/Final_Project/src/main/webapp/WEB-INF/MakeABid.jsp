<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body style = "font-size:16pt;">
<button onclick="window.location.href='showAuctions.jsp';">Return to See The Auctions</button>
    <% 
    int auctionID = Integer.parseInt(request.getParameter("auctionId"));
	session.setAttribute("auctionId", auctionID);
	String userName = (session.getAttribute("user")).toString();%>
	<p>
	Hello <%=userName %> please make a bid on auctionID: <%=session.getAttribute("auctionID") %>
	</p>
   
</body>
</html>