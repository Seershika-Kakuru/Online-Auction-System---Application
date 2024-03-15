<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
	
</head>
<body>
<div>
<h1 align = center>
WELCOME! Please login to your Account!
</h1>
</div>
<br>

<form action="ValidateLogin.jsp" method="POST">
       <table  style="border:3px; border-style:solid; border-color:#FF0000; padding: 1em; position:relative; left:380px">
       <tr>
       <td style="font-size:16pt;"><b>MemberID: </b></td><td><input type="text" name="MemberID" maxlength="100" size = "50" style="font-size:16pt;"/></td>
       </tr>
       <tr>
       <td style="font-size:16pt;"><b>Password: </b></td><td><input type="password" name="Password" maxlength="100" size = "50" style="font-size:16pt;"/></td>
       </tr>
       <tr><td><input type="submit" value="Login" style="font-size:16pt;position:relative; left:300px; top:2px; background-color:#ADD8E6"/></td></tr></table>
     </form>
 <a style="font-size:16pt;position:relative; left:380px; top:5px" href=Register.jsp > Create An Account? </a>
</body>
<br/>
</html>