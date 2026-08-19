<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pending Approval - Vendor</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body style="display: flex; align-items: center; justify-content: center; min-height: 100vh; background-color: #F0F6F6;">
    <div class="auth-card text-center" style="max-width: 500px; padding: 40px;">
        <h2 class="text-primary mb-2">Account Pending Approval</h2>
        <p style="color: var(--text-secondary); margin-bottom: 30px; font-size: 1.1rem;">
            Hello <strong>${user.name}</strong>, your account has been successfully verified, but it is currently pending approval by the Hospital Administrator. 
            <br><br>
            Please check back later once the Admin has reviewed and approved your vendor access request.
        </p>
        <a href="/logout" class="btn btn-primary" style="padding: 10px 30px; font-weight: 600;">Logout</a>
    </div>
</body>
</html>
