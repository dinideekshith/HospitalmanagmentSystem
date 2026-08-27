<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify OTP - Hospital Management System</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        /* Split Screen Layout matching Login/Register */
        .split-login-wrapper {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }
        
        .split-image-side {
            flex: 1;
            background: url('/images/doctor_portrait.jpg') no-repeat center center;
            background-size: cover;
            display: none;
        }
        
        @media (min-width: 768px) {
            .split-image-side {
                display: block;
            }
        }
        
        .split-form-side {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.95);
            padding: 2rem;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }
        
        .form-inner {
            width: 100%;
            max-width: 450px;
        }
        
        body::before {
            display: none !important;
        }
        body {
            background: #F0F6F6 !important;
        }
    </style>
</head>
<body>
    <div class="split-login-wrapper">
        <div class="split-image-side"></div>
        <div class="split-form-side">
            <div class="form-inner">
                <div class="auth-header mb-2">
                    <h2 class="text-primary" style="font-size: 2.5rem; margin-bottom: 0.5rem;">Verify Email</h2>
                    <p style="color: var(--text-secondary); margin-bottom: 2.5rem; font-size: 1.1rem;">We've sent an OTP to your email address.</p>
                </div>
                
                <c:if test="${error != null}">
                    <div class="alert alert-error" style="margin-bottom: 1.5rem;">${error}</div>
                </c:if>

                <c:if test="${demoOtp != null}">
                    <div class="alert" style="background: #E6FFFA; color: #319795; border: 1px solid #319795; margin-bottom: 1.5rem; padding: 1rem; border-radius: 8px;">
                        <strong>[Demo Mode]</strong> Your OTP is: <span style="font-size: 1.3rem; font-weight: bold; margin-left: 5px;">${demoOtp}</span>
                    </div>
                </c:if>

                <form action="/verify-otp" method="post">
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="email" class="form-control" style="background: #F7FAFC; border-color: #E2E8F0; color: #718096;" value="${email}" readonly required>
                    </div>
                    <div class="form-group">
                        <label>Enter OTP</label>
                        <input type="text" name="otp" class="form-control" style="background: white; border-color: #E2E8F0;" required placeholder="Enter 4-digit OTP" autofocus>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1.5rem; padding: 1rem; font-size: 1.1rem; border-radius: 8px;">Verify & Login</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
