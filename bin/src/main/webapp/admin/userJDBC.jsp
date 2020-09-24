<%@page import="com.oultoncollege.db.UserDAO"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.oultoncollege.db.Settings"%>
<%@page import="com.oultoncollege.db.DatabaseConnection"%>
<%@page import="com.oultoncollege.model.User"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Proctor Scheduler</title>
    <link rel="stylesheet" type="text/css" href="styles/main.css">
    <link rel="stylesheet" type="text/css" href="styles/user.css">
</head>
<body>
    <h1>User Information</h1>
       
    <% 
    	int userID = 0;
    	String userFirstName = "";
    	String userLastName = "";
    	String phoneNumber = "";
    	String ext = "";
    	String accountType = "";
    	String email = "";
    	List<User> users = null;
    	DatabaseConnection dc = new DatabaseConnection();
		try {
			//dc.getConnection();
		Class.forName(Settings.DB_DRIVER);
        String dbPath = "jdbc:" + Settings.DB_TYPE + "://" + Settings.DB_HOST + ":" + Settings.DB_PORT + "/" + Settings.DB_NAME; 
		Connection dbConnection = DriverManager.getConnection(dbPath, Settings.DB_USER, Settings.DB_PWD);
		
		
		UserDAO userManager = new UserDAO(dbConnection);
			users = userManager.getUsers();
			userFirstName = users.get(1).getFirstName();
			userLastName = users.get(1).getLastName();
			email = users.get(1).getEmail();
			phoneNumber = users.get(1).getPhoneNumber();
			ext = users.get(1).getExt();
			accountType = users.get(1).getAccountType();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
     %>
    
    <a href="?userID=<%=userID %>">Edit</a>
    <form>
    	<fieldset>
    		<legend>User Info</legend>
    		<label>First Name</label>
    		<br>
    		<input type="text" name="firstName" id="firstName" value="<%=userFirstName %>"/>
    		<br>
    		<label>Last Name</label>
    		<br>
    		<input type="text" name="lastName" id="lastName" value="<%=userLastName %>"/>
    		<br>
    		<label>Email</label>
    		<br>
    		<input type="text" name="email" id="email" value="<%=email %>"/>
    		<br>
    		<label>Phone Number</label>
    		<br>
    		<input type="text" name="phoneNumber" id="phoneNumber" value="<%=phoneNumber %>"/>
    		<br>
    		<label>Extension</label>
    		<br>
    		<input type="text" name="ext" id="ext" value="<%=ext %>"/>
    		<br>
    		<label>Account Type</label>
    		<br>
    		<input type="text" name="accountType" id="accountType" value="<%=accountType %>"/>
    	</fieldset>
    </form>
    <ul>
    	
    	 <% 
    		for(User user : users){
    			out.print("<li>" + user.getFirstName() + " " + user.getLastName() + "</li>");
    			
    		}
    	%>
    </ul>
</body>
</html>