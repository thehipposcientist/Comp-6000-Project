<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Process</title>
    <link rel="stylesheet" type="text/css" href="FilmRadar.css">
</head>
<body>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || username.isEmpty() || password == null || password.isEmpty()) {
            out.println("<p>Username and Password cannot be empty. Please try again.</p>");
            out.println("<a href='login.jsp'>Go back to Login</a>");
        } else {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Ensure this matches your MySQL driver version
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/filmradar", "root", "Turtle94");
                String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                pstmt.setString(2, password);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    session.setAttribute("user", rs.getInt("user_id"));
                    out.println("<p>Login successful!</p>");
                    out.println("<a href='movies.jsp'>Go to Movies</a>");
                } else {
                    out.println("<p>Invalid username or password. Please try again.</p>");
                    out.println("<a href='login.jsp'>Go back to Login</a>");
                }
            } catch (SQLException e) {
                out.println("<p>Database error: " + e.getMessage() + "</p>");
                out.println("<a href='login.jsp'>Go back to Login</a>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) {}
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) {}
                if (conn != null) try { conn.close(); } catch (SQLException e) {}
            }
        }
    %>
</body>
</html>
