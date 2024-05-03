<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add New Movie</title>
</head>
<body>
<h1>Add a New Movie</h1>
<form method="post" action="AddMovieServlet">
    Title: <input type="text" name="title"><br>
    Director: <input type="text" name="director"><br>
    Year: <input type="text" name="year"><br>
    <input type="submit" value="Submit">
</form>
</body>
</html>
