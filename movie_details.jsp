<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movie Details</title>
</head>
<body>
<%
String movieId = request.getParameter("movie_id");
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/FilmRadar", "yourusername", "yourpassword");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM movies WHERE movie_id = ?");
    ps.setString(1, movieId);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
        out.println("<h1>" + rs.getString("title") + "</h1>");
        out.println("<p>Director: " + rs.getString("director") + "</p>");
        out.println("<p>Year: " + rs.getInt("year") + "</p>");
    }
    rs.close();

    // Display reviews for this movie
    ps = con.prepareStatement("SELECT * FROM reviews WHERE movie_id = ?");
    ps.setString(1, movieId);
    rs = ps.executeQuery();
    out.println("<h2>Reviews:</h2>");
    while (rs.next()) {
        out.println("<p>Rating: " + rs.getInt("rating") + "/5</p>");
        out.println("<p>Comment: " + rs.getString("comment") + "</p>");
    }
    con.close();
} catch(Exception e) {
    out.println("Database connection problem: " + e.getMessage());
}
%>
<a href="SubmitReview.jsp?movie_id=<%= movieId %>">Write a Review</a> | <a href="Movies.jsp">Back to Movies</a>
</body>
</html>
