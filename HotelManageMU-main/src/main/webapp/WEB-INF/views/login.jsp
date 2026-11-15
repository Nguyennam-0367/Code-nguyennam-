<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
     <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Đăng nhập - YOU'LL NEVER WALK ALONE HOTEL</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
     <body class="login-page">

        <div class="login-box">
            <div class="logo">
                <h1>YOU'LL NEVER WALK ALONE</h1>
                <span>HOTEL</span>
            </div>

            <h2>ĐĂNG NHẬP</h2>

            <% if (request.getAttribute("loi") != null) { %>
                <p class="login-error"><%= request.getAttribute("loi") %></p>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/login">
                <label for="tenDangNhap">Tên đăng nhập</label>
                <input type="text" id="tenDangNhap" name="tenDangNhap" required autofocus>

                <label for="matKhau">Mật khẩu</label>
                <input type="password" id="matKhau" name="matKhau" required>

                <button type="submit">ĐĂNG NHẬP</button>
            </form>
        </div>

</body>
</html>