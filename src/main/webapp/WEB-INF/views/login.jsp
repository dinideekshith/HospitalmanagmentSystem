<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Hospital Management System</title>
    <link rel="stylesheet" href="/css/style.css">
    <style>
        /* Split Screen Login Layout */
        .split-login-wrapper {
            display: flex;
            min-height: 100vh;
            width: 100%;
        }
        
        .split-image-side {
            flex: 1;
            background: url('/images/doctor_portrait.jpg') no-repeat center top;
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
        
        /* Disable the global blurred background for the login page to keep it clean */
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
                    <h2 class="text-primary" style="font-size: 2.5rem; margin-bottom: 0.5rem;">Welcome Back</h2>
                    <p style="color: var(--text-secondary); margin-bottom: 2.5rem; font-size: 1.1rem;">Please enter your credentials to login.</p>
                </div>
                
                <c:if test="${param.error != null}">
                    <div class="alert alert-error">Invalid email or password.</div>
                </c:if>
                <c:if test="${param.logout != null}">
                    <div class="alert alert-success">You have been logged out successfully.</div>
                </c:if>
                <c:if test="${success != null}">
                    <div class="alert alert-success">${success}</div>
                </c:if>

                <form action="/login" method="post">
                    <div class="form-group">
                        <label>Login As</label>
                        <select name="role" class="form-control" style="background: white; border-color: #E2E8F0;" required>
                            <option value="">-- Select Role --</option>
                            <option value="PATIENT">Patient</option>
                            <option value="DOCTOR">Doctor</option>
                            <option value="VENDOR">Vendor</option>
                            <option value="ADMIN">Admin</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Email Address</label>
                        <input type="email" name="username" class="form-control" style="background: white; border-color: #E2E8F0;" required placeholder="Enter your email">
                    </div>
                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" name="password" class="form-control" style="background: white; border-color: #E2E8F0;" required placeholder="Enter your password">
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1.5rem; padding: 1rem; font-size: 1.1rem; border-radius: 8px;">Login</button>
                </form>
                <p class="text-center mt-3" style="font-size: 1.05rem;">Don't have an account? <a href="/register" class="text-primary" style="font-weight: 600; text-decoration: none;">Register here</a></p>
            </div>
        </div>
    </div>
</body>
</html>
