<%@ page import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.html"); // Redirect to login if not logged in
        return;
    }

    int postId = Integer.parseInt(request.getParameter("postId"));

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_management", "root", "Rajini@1432");

        // Delete the post
        String query = "DELETE FROM posts WHERE id = ? AND username = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, postId);
        stmt.setString(2, username);
        stmt.executeUpdate();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h3>Error: " + e.getMessage() + "</h3>");
    }

    // Redirect back to the createPost page
    response.sendRedirect("createPost.jsp");
%>
