<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Retrieve jobId from the request
    String jobId = request.getParameter("jobId");

    // Initialize database connection
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;
    String dbUrl = "jdbc:mysql://localhost:3306/user_management";
    String dbUser = "root";
    String dbPassword = "Rajini@1432";

    try {
        // Load database driver
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

        // Query to get the job post details
        String query = "SELECT * FROM posts WHERE id = ?";
        stmt = conn.prepareStatement(query);
        stmt.setString(1, jobId);
        rs = stmt.executeQuery();

        if (rs.next()) {
            String jobTitle = rs.getString("job_title");
            String description = rs.getString("description");
            String startTime = rs.getString("start_time");
            String workplace = rs.getString("workplace");
            String personIntake = rs.getString("person_intake");
            String qualifications = rs.getString("qualifications");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= jobTitle %> - Full Description</title>
</head>
<body>
    <h1><%= jobTitle %></h1>
    <p><strong>Job Description:</strong></p>
    <p><%= description %></p>
    <p><strong>Start Time:</strong> <%= startTime %></p>
    <p><strong>Workplace:</strong> <%= workplace %></p>
    <p><strong>Person Intake:</strong> <%= personIntake %></p>
    <p><strong>Qualifications:</strong> <%= qualifications %></p>
</body>
</html>

<%
    } else {
        out.println("<h3>Job post not found!</h3>");
    }

    // Close database connection
    if (rs != null) rs.close();
    if (stmt != null) stmt.close();
    if (conn != null) conn.close();
%>
