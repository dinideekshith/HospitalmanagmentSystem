<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pending Approval - HMS</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="#" class="nav-brand"><i class="fas fa-user-md"></i> Doctor Portal</a>
            <div class="nav-links">
                <a href="/logout" class="btn btn-outline" style="padding: 0.5rem 1rem;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper" style="text-align: center; margin-top: 5rem;">
        <div class="auth-card" style="margin: 0 auto; max-width: 500px; padding: 3rem;">
            <i class="fas fa-clock" style="font-size: 4rem; color: var(--primary-teal); margin-bottom: 1rem;"></i>
            <h2 class="text-primary mb-2">Account Pending Approval</h2>
            <p class="text-secondary" style="margin-bottom: 2rem;">
                Hi <strong>${user.name}</strong>, your registration has been successfully received, but your account must be approved by an administrator before you can access the doctor dashboard.
            </p>
            <p class="text-secondary">
                Please check back later or contact the hospital administration.
            </p>
            <a href="/logout" class="btn btn-primary mt-4">Return to Login</a>
        </div>
    </div>
</body>
</html>
