<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Request Ambulance | Hospital Care</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/patient/dashboard" class="nav-brand">
                <i class="fas fa-plus"></i> Hospital Care
            </a>
            <div class="nav-links">
                <a href="/patient/dashboard" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="dashboard-header" style="background: var(--primary-teal); color: white; padding: 2rem; border-radius: 12px; margin-bottom: 2rem;">
            <h2><i class="fas fa-ambulance"></i> Request Ambulance</h2>
            <p>Dispatch an ambulance to your location immediately.</p>
        </div>
        
        <c:if test="${not empty param.success}">
            <div class="alert alert-success" style="background-color: #F0FFF4; color: #2F855A; border: 1px solid #9AE6B4; padding: 1rem; border-radius: 8px; margin-bottom: 2rem;">
                <i class="fas fa-check-circle"></i> Ambulance request submitted successfully! Help is on the way.
            </div>
        </c:if>

        <div class="card" style="padding: 2rem; max-width: 600px; margin: 0 auto;">
            <form action="/patient/ambulance/request" method="POST">
                <div class="form-group" style="margin-bottom: 1.5rem;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Pickup Location</label>
                    <textarea name="location" rows="3" class="form-control" placeholder="Enter exact pickup address" required style="width: 100%; padding: 0.75rem; border: 1px solid #E2E8F0; border-radius: 6px;"></textarea>
                </div>
                
                <div class="form-group" style="margin-bottom: 1.5rem;">
                    <label style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Type of Emergency</label>
                    <select name="emergencyType" class="form-control" required style="width: 100%; padding: 0.75rem; border: 1px solid #E2E8F0; border-radius: 6px;">
                        <option value="">Select Emergency Type</option>
                        <option value="Cardiac Arrest">Cardiac Arrest</option>
                        <option value="Accident / Trauma">Accident / Trauma</option>
                        <option value="Pregnancy">Pregnancy</option>
                        <option value="Severe Bleeding">Severe Bleeding</option>
                        <option value="Stroke">Stroke</option>
                        <option value="Other">Other</option>
                    </select>
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: 100%; padding: 1rem; font-size: 1.1rem;"><i class="fas fa-paper-plane"></i> Submit Request</button>
            </form>
        </div>
    </div>
</body>
</html>
