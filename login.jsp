<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
<link rel="stylesheet" type="text/css" href="FilmRadar.css">
</head>
<body>
<h1>Login to FilmRadar</h1>
<form action="LoginHandler.jsp" method="post">
    Username: <input type="text" name="username"><br>
    Password: <input type="password" name="password"><br>
    <input type="submit" value="Login">
</form>
<form action="register.jsp" method="get">
    <input type="submit" value="Register">
</form>
</body>
</html>
