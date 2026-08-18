<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Patient Profile - HMS</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/patient/dashboard" class="nav-brand"><i class="fas fa-heartbeat"></i> Patient Portal</a>
            <div class="nav-links">
                <a href="/patient/dashboard" class="btn btn-outline" style="padding: 0.5rem 1rem;">Dashboard</a>
                <a href="/logout" class="btn btn-outline" style="padding: 0.5rem 1rem; margin-left: 10px;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <h2 class="text-primary">Update Profile</h2>
        
        <div class="auth-card" style="margin: 2rem auto; max-width: 600px; padding: 2rem;">
            <form action="/patient/profile" method="post">
                <h4 class="text-primary mb-1">Basic Details</h4>
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" class="form-control" value="${user.name}" required>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" class="form-control" value="${user.email}" required>
                </div>
                <div class="form-group">
                    <label>Mobile Number</label>
                    <input type="text" name="mobileNumber" class="form-control" value="${user.mobileNumber}" required>
                </div>
                
                <h4 class="text-primary mt-2 mb-1">Health Details</h4>
                <div class="form-group">
                    <label>Date of Birth</label>
                    <input type="date" name="dateOfBirth" class="form-control" value="${patient.dateOfBirth}" required>
                </div>
                <div class="form-group">
                    <label>Gender</label>
                    <select name="gender" class="form-control" required>
                        <option value="Male" ${patient.gender == 'Male' ? 'selected' : ''}>Male</option>
                        <option value="Female" ${patient.gender == 'Female' ? 'selected' : ''}>Female</option>
                        <option value="Other" ${patient.gender == 'Other' ? 'selected' : ''}>Other</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Blood Group</label>
                    <input type="text" name="bloodGroup" class="form-control" value="${patient.bloodGroup}" placeholder="e.g. O+" required>
                </div>
                <div class="form-group">
                    <label>Address</label>
                    <textarea name="address" class="form-control" rows="3" required>${patient.address}</textarea>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Save Profile</button>
            </form>
        </div>
    </div>
</body>
</html>
