<%@ page import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.html"); // Redirect to login page
        return;
    }

    int postId = Integer.parseInt(request.getParameter("id"));
    String jobTitle = "", description = "", startTime = "", workplace = "", qualifications = "", phoneNumber = "";
    int personIntake = 0;

    // Fetch the post details
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_management", "root", "Rajini@1432");

        // Fetch post by postId
        String query = "SELECT * FROM posts WHERE id = ? AND username = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, postId);
        stmt.setString(2, username);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            jobTitle = rs.getString("job_title");
            description = rs.getString("description");
            startTime = rs.getString("start_time");
            workplace = rs.getString("workplace");
            personIntake = rs.getInt("person_intake");
            qualifications = rs.getString("qualifications");
            phoneNumber = rs.getString("phone_number");
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    }

    // Handle post update form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        jobTitle = request.getParameter("jobTitle");
        description = request.getParameter("description");
        startTime = request.getParameter("startTime");
        workplace = request.getParameter("workplace");
        personIntake = Integer.parseInt(request.getParameter("personIntake"));
        qualifications = request.getParameter("qualifications");
        phoneNumber = request.getParameter("phoneNumber");

        try {
            // Update post in the database
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_management", "root", "Rajini@1432");

            String updateQuery = "UPDATE posts SET job_title = ?, description = ?, start_time = ?, workplace = ?, person_intake = ?, qualifications = ?, phone_number = ? WHERE id = ? AND username = ?";
            PreparedStatement stmt = conn.prepareStatement(updateQuery);
            stmt.setString(1, jobTitle);
            stmt.setString(2, description);
            stmt.setString(3, startTime);
            stmt.setString(4, workplace);
            stmt.setInt(5, personIntake);
            stmt.setString(6, qualifications);
            stmt.setString(7, phoneNumber);
            stmt.setInt(8, postId);
            stmt.setString(9, username);

            stmt.executeUpdate();
            conn.close();

            // Redirect to the profile page or post listing after update
            response.sendRedirect("createPost.jsp");
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
    <title>Edit Post</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
        }
        form {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <h1>Edit Post</h1>
    <form method="POST" action="editPost.jsp?id=<%= postId %>">
        <label>Job Title:</label><br>
        <input type="text" name="jobTitle" value="<%= jobTitle %>" required><br><br>
        
        <label>Description:</label><br>
        <textarea name="description" required><%= description %></textarea><br><br>
        
        <label>Start Time and Date:</label><br>
        <input type="datetime-local" name="startTime" value="<%= startTime %>" required><br><br>
        
        <label>Workplace:</label><br>
        <input type="text" name="workplace" value="<%= workplace %>" required><br><br>
        
        <label>Person Intake:</label><br>
        <input type="number" name="personIntake" value="<%= personIntake %>" required><br><br>
        
        <label>Qualifications:</label><br>
        <textarea name="qualifications" required><%= qualifications %></textarea><br><br>
        
        <label>Phone Number:</label><br>
        <input type="tel" name="phoneNumber" pattern="[0-9]{10}" value="<%= phoneNumber %>" required><br><br>
        
        <button type="submit">Update Post</button>
    </form>
</body>
</html>
