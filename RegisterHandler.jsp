<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registration Process</title>
    <link rel="stylesheet" type="text/css" href="FilmRadar.css">
</head>
<body>
    <%
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (username == null || email == null || password == null ||
            username.isEmpty() || email.isEmpty() || password.isEmpty()) {
            out.println("<p>All fields must be filled out. Please try again.</p>");
            out.println("<a href='register.jsp'>Go back to Registration</a>");
        } else {
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/filmradar", "root", "Turtle94");
                String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, email);
                pstmt.setString(3, password);

                int result = pstmt.executeUpdate();
                if (result > 0) {
                    out.println("<p>Registration successful!</p>");
                    out.println("<a href='index.jsp'>Go to Home</a>");
                } else {
                    out.println("<p>Registration failed. Please try again.</p>");
                    out.println("<a href='register.jsp'>Go back to Registration</a>");
                }
            } catch (SQLException e) {
                out.println("<p>Error: " + e.getMessage() + "</p>");
                out.println("<a href='register.jsp'>Go back to Registration</a>");
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        }
    %>
</body>
</html>
