<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - GasPOS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: url('https://www.theforage.com/blog/wp-content/uploads/2022/12/what-is-cybersecurity.jpg') no-repeat center center fixed;
            background-size: cover;
        }
        .login-card { 
            border-radius: 20px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.5); 
            padding: 40px; 
            margin-top: 100px; 
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
        .btn-cyber {
            background: linear-gradient(135deg, #00dbde 0%, #fc00ff 100%);
            color: white; border: none; font-weight: bold;
        }
        .btn-cyber:hover { opacity: 0.9; color: white; }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center">
    <div class="col-md-5 login-card text-center">
        <h3 class="fw-bold mb-3">GasPOS</h3>
        <p class="text-muted mb-4">Selamat datang. Silakan login untuk operasional.</p>
        <%
            String loginError = (String) session.getAttribute("loginError");
            if (loginError != null) {
                session.removeAttribute("loginError");
        %>
            <div class="alert alert-danger text-start small mb-3">
                <strong>Error:</strong> <%= loginError %>
            </div>
        <% } %>
        <form action="login" method="POST">
            <div class="mb-3 text-start">
                <label class="fw-bold">Username</label>
                <input type="text" class="form-control p-2" name="username" value="admin" required>
            </div>
            <div class="mb-4 text-start">
                <label class="fw-bold">Kata Sandi</label>
                <input type="password" class="form-control p-2" name="password" value="admin123" required>
            </div>
            <button type="submit" class="btn btn-cyber w-100 p-2">Masuk</button>
        </form>
    </div>
</div>
</body>
</html>