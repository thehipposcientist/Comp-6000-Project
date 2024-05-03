<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Movies</title>
<link rel="stylesheet" type="text/css" href="FilmRadar.css">
<style>
    .movie-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
        padding: 20px;
    }
    .movie {
        background-color: #f3e1cc;
        padding: 10px;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
    }
    h1, h2, .year {
        text-align: center;
    }
    .rate {
        direction: rtl;
        unicode-bidi: bidi-override;
        margin: 10px 0;
    }
    .rate input {
        display: none;
    }
    .rate label {
        color: #94775a; /* Bright tan color */
        float: right;
        font-size: 30px;
        cursor: pointer;
    }
    .rate input:checked ~ label,
    .rate label:hover,
    .rate label:hover ~ label {
        color: #d2a679; /* Gold color for active/hover state */
    }
    .view-reviews {
        display: block;
        text-align: center;
        margin-top: 10px;
        color: #d2a679;
        text-decoration: none;
    }
</style>
</head>
<body>
<div class="logout-wrapper">
    <form action="logout.jsp" method="post">
        <button type="submit">Logout</button>
    </form>
</div>
    
<div class="movie-grid">
<%
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure to use the correct driver
    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/filmradar", "root", "Turtle94");
    String sql = "SELECT movie_id, title, year FROM movies";
    ps = conn.prepareStatement(sql);
    rs = ps.executeQuery();
    while (rs.next()) {
        String title = rs.getString("title");
        int year = rs.getInt("year");
        int movieId = rs.getInt("movie_id");
%>
    <div class="movie">
        <h2><%= title %></h2>
        <p class="year"><%= year %></p>
        <form action="RateMovie.jsp" method="post" class="rate">
            <input type="hidden" name="movie_id" value="<%= movieId %>">
            <input type="radio" id="star5-<%= movieId %>" name="rating" value="5"/><label for="star5-<%= movieId %>">&#9733;</label>
            <input type="radio" id="star4-<%= movieId %>" name="rating" value="4"/><label for="star4-<%= movieId %>">&#9733;</label>
            <input type="radio" id="star3-<%= movieId %>" name="rating" value="3"/><label for="star3-<%= movieId %>">&#9733;</label>
            <input type="radio" id="star2-<%= movieId %>" name="rating" value="2"/><label for="star2-<%= movieId %>">&#9733;</label>
            <input type="radio" id="star1-<%= movieId %>" name="rating" value="1"/><label for="star1-<%= movieId %>">&#9733;</label>
            <input type="submit" value="Submit Rating">
        </form>
        <a href="ViewReviews.jsp?movie_id=<%= movieId %>" class="view-reviews">View Reviews</a>
    </div>
<%
    }
} catch (SQLException e) {
    out.println("<p>Database error: " + e.getMessage() + "</p>");
} finally {
    if (rs != null) try { rs.close(); } catch (SQLException e) { out.println("<p>Error closing ResultSet: " + e.getMessage() + "</p>"); }
    if (ps != null) try { ps.close(); } catch (SQLException e) { out.println("<p>Error closing PreparedStatement: " + e.getMessage() + "</p>"); }
    if (conn != null) try { conn.close(); } catch (SQLException e) { out.println("<p>Error closing Connection: " + e.getMessage() + "</p>"); }
}
%>
</div>
</body>
</html>
