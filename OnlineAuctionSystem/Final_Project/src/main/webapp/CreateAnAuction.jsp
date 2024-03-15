<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Create Auction</title>
</head>
<body>  
	<button onclick="window.location.href='Success.jsp';">Return to Your Dashboard</button>

	<form action="InsertItemAndAuction.jsp" method="POST">	
	<p style = "font-size:16pt;"><b>Enter the details about your Electronic Device</b></p>
	 <table style="font-size:16pt;">
       <tr>
	   <td>
	   Select the kind of electronic device: 
	   </td>
	   </tr>
	   <tr>
	   <td>
	   <input type="radio" name="device" value="isLaptop"/> Laptop
	   <input type="radio" name="device" value="isSmartPhone"/> Smart Phone
	   <input type="radio" name="device" value="isTV"/> Television
	   </td>
	   </tr>
	   <tr>    
	   <td>Name Of The Device: <input type="text" name="nameOfDevice" placeholder="name" required></td>
	   </tr>
	   <tr>    
	   <td>Height: <input type="number" step="any" name="height" placeholder="0.0" required></td>
	   </tr>
	   <tr>    
	   <td>Width: <input type="number" step="any" name="width" placeholder="0.0" required></td>
	   </tr>
	   <tr>    
	   <td>Color: <input type="text" name="color" placeholder="Color" required></td>
	   </tr>
	   <tr>    
	   <td>Company/Brand: <input type="text" name="companyOrBrand" placeholder="Company/Brand Name" required></td>
	   </tr>
	   <tr>    
	   <td>Year Of Make: <input type="number" name="yearOfMake" placeholder="0" required></td>
	   </tr>
	    <tr>    
	   <td>Quality: <input type="text" name="quality" placeholder="Quality" required></td>
	   </tr>
	   <tr>    
	   <td>Version: <input type="text" name="version" placeholder="Version"></td>
	   </tr>
	   <tr>    
	   <td>Charging Port: <input type="text" name="chargingPort" placeholder="Charging Port"></td>
	   </tr>
	   <tr>
	   <td>Storage: <input type="number" step="any" name="storage" placeholder="0.0"></td>
	   </tr>
	   <tr>    
	   <td>Memory: <input type="number" step="any" name="memory" placeholder="0.0"></td>
	   </tr>
	   <tr>    
	   <td>Display Technology: <input type="text" name="displayTechnology" placeholder="Display Technology"></td>
	   </tr>
	   </table>
	   <br></br>
	   <p style = "font-size:16pt;"><b>Enter the details about your Auction</b></p>
	   <table style="font-size:16pt;">
	   <tr>    
	   <td>Enter the initial price of this item: <input type="number" step="any" name="initialPrice" placeholder="0.0" required></td>
	   </tr>
	   <tr>    
	   <td>Enter the minimum price of this item: <input type="number" step="any" name="minimumPrice" placeholder="0.0" required></td>
	   </tr>
	   <tr>    
	   <td>Enter the standard bidding increment of this auction: <input type="number" step="any" name="standardBiddingIncrement" placeholder="0.0" required></td>
	   </tr>
	    <tr>    
	   <td>Enter opening date of auction: <input type="text" name="openingDate" placeholder="yyyy-mm-dd hh:mm:ss" required></td>
	   </tr> 
	   <tr>    
	   <td>Enter closing date of auction: <input type="text" name="closingDate" placeholder="yyyy-mm-dd hh:mm:ss" required></td>
	   </tr> 
	   </table>
	   <input type="submit" value="Create Auction" style="font-size:16pt;">
	</form>
</body>
</html>