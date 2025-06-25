# 💫 Her Opportunite

**Her Opportunite** is a web-based platform built to **empower women** by providing resources, opportunities, legal awareness, and community support. It allows users to register, log in, create and manage posts, and access personalized content in a secure and user-friendly environment.

---

## 📌 Key Features

- 🔐 **User Authentication** – Sign up and log in via secure HTML forms processed by Java Servlets.
- 🏠 **Personalized Home Page** – After login, users are redirected to a custom homepage.
- 🖼️ **Profile Management** – View and manage your profile on a dedicated profile page.
- 📄 **Post Management** – Create, edit, and delete posts (JSP-based).
- 💼 **Job Description Page** – View opportunity/job descriptions.
- 📚 **Awareness Content** – Informational sections like `welcome.html` and `homepage.html`.

---

## 🛠️ Tech Stack

- **Frontend**: HTML, CSS
- **Backend**: Java Servlets, JSP
- **Server**: Apache Tomcat
- **Database**: MySQL (connected via JDBC)
- **Tools**: Eclipse IDE / IntelliJ IDEA

---

## 📁 Project Structure

Her-Opportunite/
│

├── createPost.jsp

├── deletePost.jsp

├── editPost.jsp

├── jobDescription.jsp

├── login.html

├── signup.html

├── home.html

├── homepage.html

├── profile.jsp

├── welcome.html

├── welcome.jsp

├── har.jpg, phic.jpg # Media files

│

├── LoginServlet.java

├── SignUpServlet.java

│

├── WEB-INF/

   │ ├── web.xml

   │ └── classes/
   
      │ ├── LoginServlet.class
      
      │ └── SignUpServlet.class



---

## ⚙️ Getting Started

### 🔧 Prerequisites

- JDK 8 or higher
- Apache Tomcat (v9+)
- MySQL (or any SQL RDBMS)
- Java IDE like Eclipse or IntelliJ IDEA

### 🛠️ Setup Instructions

1. **Clone the Repository**
   ```bash
   git clone https://github.com/Krajini/Her-Opportunite.git


Import into IDE

Open Eclipse or IntelliJ

Import the folder as a Dynamic Web Project

Configure Tomcat Server

Add Apache Tomcat v9 or v10 in your IDE

Deploy the project to the server

Setup the Database

Create a MySQL database (e.g., her_opportunite)

Create required tables (Users, Posts, etc.)

Update DB connection details in the Servlet code

Run the Application

Start the Tomcat server

Open in browser: http://localhost:8080/Her-Opportunite

🔮 Future Enhancements
✅ File upload with history tracking

✅ Add profile image on login

✅ Track and display user contributions

💬 Add community forum or discussion board

📱 Mobile-friendly responsive design

📧 Email verification & notifications
