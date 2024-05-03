<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit Review</title>
</head>
<body>
    <%
        Integer userId = (Integer) session.getAttribute("user");
        String movieId = request.getParameter("movie_id");
        String rating = request.getParameter("rating");
        String comment = request.getParameter("comment");

        if (userId == null) {
            out.println("<p>You must be logged in to submit a review.</p>");
        } else if (movieId == null || rating == null || comment == null) {
            out.println("<p>Error: Missing data from form. Please fill all fields.</p>");
        } else {
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/filmradar", "root", "Turtle94");
                String sql = "INSERT INTO reviews (movie_id, user_id, rating, comment) VALUES (?, ?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(movieId));
                ps.setInt(2, userId);
                ps.setInt(3, Integer.parseInt(rating));
                ps.setString(4, comment);
                int result = ps.executeUpdate();

                if (result > 0) {
                    out.println("<p>Review submitted successfully!</p>");
                } else {
                    out.println("<p>Error submitting review. Please try again later.</p>");
                }
            } catch (Exception e) {
                out.println("<p>Error accessing database: " + e.getMessage() + "</p>");
            } finally {
                if (ps != null) try { ps.close(); } catch (SQLException e) { out.println("<p>Error closing PreparedStatement: " + e.getMessage() + "</p>"); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { out.println("<p>Error closing Connection: " + e.getMessage() + "</p>"); }
            }
        }
    %>
    <a href="ViewReviews.jsp?movie_id=<%= movieId %>">Back to Reviews</a>
</body>
</html>
