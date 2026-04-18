<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
    <link rel="stylesheet" href="style.css?v=1">
</head>
<body>

<div class="login-container">
    <div class="login-card">
        <h2>Teacher  Login</h2>
        <form action="LoginServlet" method="post">
            <input type="text" name="user" placeholder="Username" required>
            <input type="password" name="pass" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <p class="footer-text"> 2026 Student Management</p>
    </div>
</div>

</body>
</html>