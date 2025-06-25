<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*"%>
<%
    // Retrieve username from session
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.html"); // Redirect to login if session is invalid
        return;
    }

    // Fetch posts created by everyone
    String query = "SELECT * FROM posts";
    ResultSet rs = null;
    Connection conn = null;
    Statement stmt = null;
    
    try {
        // Load the JDBC driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Establish a connection
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_management", "root", "Rajini@1432");

        // Create a statement
        stmt = conn.createStatement();

        // Execute the query
        rs = stmt.executeQuery(query);
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            margin: 0;
            padding: 0;
        }
        .container {
            margin-top: 50px;
        }
        .button-container {
            margin-top: 20px;
        }
        button {
            padding: 10px 20px;
            margin: 10px;
            font-size: 16px;
            border: none;
            background-color: #4caf50;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .post-card {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin: 20px auto;
            padding: 20px;
            max-width: 800px;
            text-align: left;
            position: relative;
        }
        .post-card h3 {
            color: #333;
            font-size: 22px;
            margin-bottom: 10px;
        }
        .post-card p {
            color: #555;
            font-size: 16px;
            line-height: 1.6;
        }
        .post-meta {
            font-size: 14px;
            color: #777;
            margin-top: 10px;
        }
        .post-meta span {
            margin-right: 20px;
        }
        .post-footer {
            margin-top: 15px;
            text-align: right;
        }
        .posted-by {
            font-size: 14px;
            font-weight: bold;
            color: #333;
            position: absolute;
            top: 10px;
            left: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome, <%= username %>!</h1>
        <h3>What would you like to do today?</h3>
        <div class="button-container">
            <button onclick="location.href='createPost.jsp'">Create Post</button>
            <button onclick="location.href='profile.jsp'">Profile</button>
        </div>

        <h2>Posts by Everyone</h2>

        <%
            try {
                // Check if there are any posts
                if (rs != null) {
                    while (rs.next()) {
        %>

        <!-- Post Card Design -->
        <div class="post-card">
           
            <!--<div class="posted-by">Posted by: <%= rs.getString("username") %></div>-->
            <h3><%= rs.getString("job_title") %></h3>
            <p><%= rs.getString("description") %></p>
            <div class="post-meta">
                <span><strong>Start Time:</strong> <%= rs.getTimestamp("start_time") %></span>
                <span><strong>Workplace:</strong> <%= rs.getString("workplace") %></span>
                <span><strong>Intake:</strong> <%= rs.getInt("person_intake") %></span>
            </div>
            <div class="posted-by">Posted by: <%= rs.getString("username") %></div>
            <div class="post-footer">
                <div class="posted-by">Posted by: <%= rs.getString("username") %></div>
                <strong>Qualifications:</strong> <%= rs.getString("qualifications") %><br>
                <strong>Contact:</strong> <%= rs.getString("phone_number") %>
            </div>
        </div>

        <%
                    }
                } else {
                    out.println("<p>No posts available.</p>");
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>
    </div>
</body>
</html>
