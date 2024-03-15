<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<div>
<h1 align = center>
Create An Account!
</h1>
</div>
<br>
<% // things needed for the user login: memberID, Name, Password, Email, Phone, Address %>
<form name="myForm" action="InsertInformation.jsp" method="POST">
       <table  style="border:3px; border-style:solid; border-color:#00008B; padding: 1em; position:relative; left:150px">
       <tr>
       <td style="font-size:16pt;"><b>Enter your MemberID: </b></td><td><input type="text" name="MemberID" maxlength="100" size = "50" style="font-size:16pt;"/></td>
       <td style="font-size:16pt;"><b>(Not more than 5 characters!)</b></td>
       </tr>
       <tr>
       <td style="font-size:16pt;"><b>Enter Your Name: </b></td><td><input type="text" name="Name" maxlength="100" size = "50" style="font-size:16pt;"/></td>
        <td style="font-size:16pt;"><b>(Not more than 100 characters!)</b></td>
       </tr>
       <tr>
	   <td style="font-size:16pt;"><b>Enter Your Password: </b></td><td><input type="password" name="Password" maxlength="100" size = "50" style="font-size:16pt;"/></td>
	   <td style="font-size:16pt;"><b>(Not more than 10 characters!)</b></td>
	   </tr>
	   <tr>
	   <td style="font-size:16pt;"><b>Enter Your Email:</b></td><td><input type="text" name="Email" maxlength="100" size = "50" style="font-size:16pt;"></td>
	   <td style="font-size:16pt;"><b>(Not more than 100 characters!)</b></td>
	   </tr>
	   <tr>
       <td style="font-size:16pt;"><b>Enter your Phone Number: </b></td><td><input type="text" name="Phone" maxlength="100" size = "50" style="font-size:16pt;"/></td>
       <td style="font-size:16pt;"><b>(Not more than 11 characters!)</b></td>
       </tr>
       <tr>
       <td style="font-size:16pt;"><b>Enter your Address: </b></td><td><input type="text" name="Address" maxlength="100" size = "50" style="font-size:16pt;"/></td>
       <td style="font-size:16pt;"><b>(Not more than 100 characters!)</b></td>
       </tr>
       <tr><td><input type="submit" value="Register" style="font-size:16pt;position:relative; left:470px; top:2px; background-color:#FFFF00"/></td></tr>
       </table>
     </form>
</br>
</body>
</html>