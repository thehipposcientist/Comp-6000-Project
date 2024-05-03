<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Reviews</title>
    <link rel="stylesheet" type="text/css" href="FilmRadar.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .content {
            width: 80%;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            text-align: left;
            border-bottom: 1px solid #ccc;
            padding: 10px;
        }
        form {
            text-align: left;
            padding: 20px;
            margin-top: 20px;
        }
        input[type="number"], textarea {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
        }
        input[type="submit"], a.button-link {
            width: auto;
            padding: 10px 20px;
            margin-top: 10px;
            background-color: #5C7AEA;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
        }
        input[type="submit"]:hover, a.button-link:hover {
            background-color: #4254B5;
        }
        a {
            display: inline-block;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="content">
        <% 
            String movieId = request.getParameter("movie_id");
            if (movieId == null) {
                out.println("<p>Movie ID is missing!</p>");
            } else {
                Connection conn = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                String movieTitle = null;
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/filmradar", "root", "Turtle94");
                    // Query to get the movie title
                    String titleQuery = "SELECT title FROM movies WHERE movie_id = ?";
                    ps = conn.prepareStatement(titleQuery);
                    ps.setInt(1, Integer.parseInt(movieId));
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        movieTitle = rs.getString("title");
                    }
                    // Query to get reviews
                    String reviewQuery = "SELECT r.rating, r.comment, u.username FROM reviews r JOIN users u ON r.user_id = u.user_id WHERE r.movie_id = ?";
                    ps = conn.prepareStatement(reviewQuery);
                    ps.setInt(1, Integer.parseInt(movieId));
                    rs = ps.executeQuery();

                    out.println("<h1>" + (movieTitle != null ? movieTitle : "Unknown Movie") + " Reviews</h1>");
                    out.println("<ul>");
                    if (!rs.next()) {
                        out.println("<li>No reviews found for this movie. Be the first to review.</li>");
                    } else {
                        do {
                            String rating = rs.getString("rating");
                            String comment = rs.getString("comment");
                            String username = rs.getString("username");
        %>
                            <li>
                                <strong>User: <%= username %></strong>
                                <p>Rating: <%= rating %> stars</p>
                                <p>Comment: <%= comment %></p>
                            </li>
        <% 
                        } while (rs.next());
                    }
                    out.println("</ul>");
                } catch (Exception e) {
                    out.println("<p>Error accessing database: " + e.getMessage() + "</p>");
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { out.println("<p>Error closing ResultSet: " + e.getMessage() + "</p>"); }
                    if (ps != null) try { ps.close(); } catch (SQLException e) { out.println("<p>Error closing PreparedStatement: " + e.getMessage() + "</p>"); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { out.println("<p>Error closing Connection: " + e.getMessage() + "</p>"); }
                }
            }
        %>
        <!-- Form to submit new review -->
        <h2>Add Your Review</h2>
        <form action="SubmitReview.jsp" method="post">
            <input type="hidden" name="movie_id" value="<%= movieId %>">
            <label for="rating">Rating (1-5):</label>
            <input type="number" id="rating" name="rating" min="1" max="5" required>
            <label for="comment">Comment:</label>
            <textarea id="comment" name="comment" required></textarea>
            <input type="submit" value="Submit Review">
        </form>
        <a href="index.jsp">Back to Home</a>
        <a href="movies.jsp" class="button-link">View Movies</a>
    </div>
</body>
</html>
