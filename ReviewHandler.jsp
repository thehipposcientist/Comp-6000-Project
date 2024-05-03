<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, util.DBConnection" %>
<%
int movieId = Integer.parseInt(request.getParameter("movie_id"));
int rating = Integer.parseInt(request.getParameter("rating"));
String comment = request.getParameter("comment");
String error = "";
if(movieId > 0 && rating >= 1 && rating <= 5 && comment != null && !comment.isEmpty()) {
    try (Connection conn = DBConnection.getConnection()) {
        String sql = "INSERT INTO reviews (movie_id, user_id, rating, comment) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, movieId);
        ps.setInt(2, (Integer) session.getAttribute("user_id")); // Assuming you store user_id in session after login
        ps.setInt(3, rating);
        ps.setString(4, comment);
        ps.executeUpdate();
        ps.close();
        response.sendRedirect("movies.jsp"); // Redirect back to the movies page
    } catch (SQLException e) {
        error = "Database error: " + e.getMessage();
        response.sendRedirect("movies.jsp?error=" + error);
    }
} else {
    error = "All fields are required and rating must be between 1 and 5";
    response.sendRedirect("movies.jsp?error=" + error);
}
%>
