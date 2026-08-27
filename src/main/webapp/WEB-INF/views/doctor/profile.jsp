<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctor Profile - HMS</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/doctor/dashboard" class="nav-brand"><i class="fas fa-user-md"></i> Doctor Portal</a>
            <div class="nav-links">
                <a href="/doctor/dashboard" class="btn btn-outline" style="padding: 0.5rem 1rem;">Dashboard</a>
                <a href="/logout" class="btn btn-outline" style="padding: 0.5rem 1rem; margin-left: 10px;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <h2 class="text-primary">Update Profile</h2>
        
        <div class="auth-card" style="margin: 2rem auto; max-width: 600px; padding: 2rem;">
            <form action="/doctor/profile" method="post">
                <h4 class="text-primary mb-1">Basic Details</h4>
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" class="form-control" value="${user.name}" required>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <div style="display: flex; gap: 10px;">
                        <input type="email" name="email" class="form-control" value="${user.email}" required style="flex: 1;">
                        <button type="button" class="btn btn-outline" style="border-color: #319795; color: #319795; white-space: nowrap;" onclick="alert('Verification OTP sent to your new email address! Please check your inbox.')">Double Verify</button>
                    </div>
                    <small class="text-secondary">If you change your email, you must double verify it using the button above.</small>
                </div>
                <div class="form-group mt-2">
                    <label>Mobile Number</label>
                    <input type="text" name="mobileNumber" class="form-control" value="${user.mobileNumber}" required>
                </div>
                
                <h4 class="text-primary mt-3 mb-1">Professional Details</h4>
                <div class="form-group">
                    <label>Hospital Role / Specialization</label>
                    <input type="text" name="specialization" class="form-control" value="${doctor.specialization}" placeholder="e.g. Head Cardiologist" required>
                </div>
                <div class="form-group">
                    <label>Qualification</label>
                    <input type="text" name="qualification" class="form-control" value="${doctor.qualification}" placeholder="e.g. MBBS, MD" required>
                </div>
                <div class="form-group">
                    <label>Experience (Years)</label>
                    <input type="number" name="experienceYears" class="form-control" value="${doctor.experienceYears}" required>
                </div>
                <div class="form-group">
                    <label>Availability Timings (e.g. Mon-Fri, 10 AM - 4 PM)</label>
                    <input type="text" name="availabilitySchedule" class="form-control" value="${doctor.availabilitySchedule}" placeholder="e.g. Mon-Fri, 10 AM to 4 PM" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Save Profile</button>
            </form>
        </div>
    </div>
</body>
</html>
