<%@ page import="java.sql.*" %>
<%
    // Check if the user is logged in
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.html"); // Redirect to login page
        return;
    }

    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String jobTitle = request.getParameter("jobTitle");
        String description = request.getParameter("description");
        String startTime = request.getParameter("startTime");
        String workplace = request.getParameter("workplace");
        String personIntake = request.getParameter("personIntake");
        String qualifications = request.getParameter("qualifications");
        String phoneNumber = request.getParameter("phoneNumber");

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/user_management",
                "root",
                "Rajini@1432"
            );

            // Insert post into database
            String query = "INSERT INTO posts (username, job_title, description, start_time, workplace, person_intake, qualifications, phone_number) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, jobTitle);
            stmt.setString(3, description);
            stmt.setString(4, startTime);
            stmt.setString(5, workplace);
            stmt.setInt(6, Integer.parseInt(personIntake));
            stmt.setString(7, qualifications);
            stmt.setString(8, phoneNumber);

            stmt.executeUpdate();

            // Close connection
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }

    // Handle post deletion
    String deletePostId = request.getParameter("deletePostId");
    if (deletePostId != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_management", "root", "Rajini@1432");

            String deleteQuery = "DELETE FROM posts WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(deleteQuery);
            stmt.setInt(1, Integer.parseInt(deletePostId));
            stmt.executeUpdate();

            conn.close();
            response.sendRedirect("createPost.jsp"); // Redirect after deletion
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error: " + e.getMessage() + "</h3>");
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Post</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
        }
        form {
            margin-bottom: 30px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <h1>Create Post</h1>
    <form method="POST" action="createPost.jsp">
        <label>Job Title:</label><br>
        <input type="text" name="jobTitle" required><br><br>
        
        <label>Description:</label><br>
        <textarea name="description" required></textarea><br><br>
        
        <label>Start Time and Date:</label><br>
        <input type="datetime-local" name="startTime" required><br><br>
        
        <label>Workplace:</label><br>
        <input type="text" name="workplace" required><br><br>
        
        <label>Person Intake:</label><br>
        <input type="number" name="personIntake" required><br><br>
        
        <label>Qualifications:</label><br>
        <textarea name="qualifications" required></textarea><br><br>
        
        <label>Phone Number:</label><br>
        <input type="tel" name="phoneNumber" pattern="[0-9]{10}" title="Enter a valid 10-digit phone number" required><br><br>
        
        <button type="submit">Submit</button>
    </form>

    <h2>Your Posts</h2>
    <table>
        <tr>
            <th>Job Title</th>
            <th>Description</th>
            <th>Start Time</th>
            <th>Workplace</th>
            <th>Person Intake</th>
            <th>Qualifications</th>
            <th>Phone Number</th>
            <th>Actions</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_management", "root", "Rajini@1432");

                // Fetch posts created by the logged-in user
                String query = "SELECT * FROM posts WHERE username = ?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, username);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getString("job_title") %></td>
            <td><%= rs.getString("description") %></td>
            <td><%= rs.getTimestamp("start_time") %></td>
            <td><%= rs.getString("workplace") %></td>
            <td><%= rs.getInt("person_intake") %></td>
            <td><%= rs.getString("qualifications") %></td>
            <td><%= rs.getString("phone_number") %></td>
            <td>
                <a href="editPost.jsp?id=<%= rs.getInt("id") %>">Edit</a> | 
                <a href="createPost.jsp?deletePostId=<%= rs.getInt("id") %>">Delete</a>
            </td>
        </tr>
        <%
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
            }
        %>
    </table>
</body>
</html>
