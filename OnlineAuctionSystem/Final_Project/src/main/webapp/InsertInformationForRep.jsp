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
<body>
	<%@ page import ="java.sql.*" %>
<%
try{
	 String memberID = request.getParameter("MemberID");
	 String name = request.getParameter("Name");
	 String password = request.getParameter("Password");
	 String email = request.getParameter("Email");
	 String phone = request.getParameter("Phone");
	 String address = request.getParameter("Address");
	 boolean isMemberIDEmpty = (memberID == "" || memberID.isEmpty());
	 boolean isNameEmpty = (name == "" || name.isEmpty());
	 boolean isPasswordEmpty = (password == "" || password.isEmpty());
	 boolean isEmailEmpty = (email == "" || email.isEmpty());
	 boolean isPhoneEmpty = (phone == "" || phone.isEmpty());
	 boolean isAddressEmpty = (address == "" || address.isEmpty());
	
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();	
	Statement stmt = con.createStatement();
	
    ResultSet rs;
    rs = stmt.executeQuery("select * from user where memberID='" + memberID + "'");
    if(isMemberIDEmpty ||isNameEmpty || isPasswordEmpty || isEmailEmpty || isPhoneEmpty || isAddressEmpty){
		%><p style="font-size:16pt;"><b>Some field is empty!! please make sure all fields are filled: <a href='CreateAnAccountForRep.jsp'> try again!</a></b></p><%
	}
	else{
    if (rs.next()) {
    	%><p style="font-size:16pt;"><b>memberID exists, please try another <a href= 'CreateAnAccountForRep.jsp'>try again</a></b></p><%
    } else {
    		
    	//Make an insert statement for the user table:
		String insert = "INSERT INTO user(memberID, name, password, email, phoneNumber, address)"
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, memberID);
		ps.setString(2, name);
		ps.setString(3, password);
		ps.setString(4, email);
		ps.setString(5, phone);
		ps.setString(6, address);
		//Run the query against the DB
		ps.executeUpdate();
		
	  	//Make an insert statement for the user table:
			String insert1 = "INSERT INTO customerrepresentative(repID)"
					+ "VALUES (?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps2 = con.prepareStatement(insert1);

			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps2.setString(1, memberID);
			
			//Run the query against the DB
			ps2.executeUpdate();


		
		//Run the query against the DB
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.println("<p>insert succeeded</p>");
		
	    // the username will be stored in the session
        response.sendRedirect("AdminSuccess.jsp"); 
    	}
    }
}
catch (Exception ex) {
	out.print(ex);
	out.print("insert failed");
}
 

%>

</body>
</html>