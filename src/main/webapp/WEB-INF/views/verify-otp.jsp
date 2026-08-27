<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - Hospital Management System</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="auth-wrapper">
        <div class="auth-card">
            <div class="auth-header">
                <h2 class="text-primary">Verify Your Email</h2>
                <p>We've sent an OTP to your email address.</p>
            </div>

            <c:if test="${error != null}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <c:if test="${demoOtp != null}">
                <div class="alert" style="background: #E6FFFA; color: #319795; border: 1px solid #319795;">
                    <strong>[Demo Mode]</strong> Your OTP is: <span style="font-size: 1.2rem; font-weight: bold;">${demoOtp}</span>
                </div>
            </c:if>

            <form action="/verify-otp" method="post">
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" class="form-control" value="${email}" readonly required>
                </div>
                <div class="form-group">
                    <label>Enter OTP</label>
                    <input type="text" name="otp" class="form-control" required placeholder="4-digit OTP">
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Verify & Login</button>
            </form>
        </div>
    </div>
</body>
</html>
