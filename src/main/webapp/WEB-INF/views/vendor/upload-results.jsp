<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upload Lab Results | Hospital Care</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/vendor/dashboard" class="nav-brand">
                <i class="fas fa-plus"></i> Hospital Care
            </a>
            <div class="nav-links">
                <a href="/vendor/dashboard" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">&larr; Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="form-card" style="max-width: 600px; margin: 2rem auto;">
            <div class="form-header">
                <i class="fas fa-vial" style="background: #FFF; padding: 12px; border-radius: 8px; box-shadow: var(--shadow-sm);"></i>
                <div>
                    <h2 class="text-primary" style="font-size: 1.5rem; margin-bottom: 0.2rem;">Upload Lab Results</h2>
                    <p class="text-secondary" style="font-size: 0.9rem;">Submit diagnostic results for ${labTest.testName}.</p>
                </div>
            </div>
            
            <div style="background: #F8FAFC; padding: 1.5rem; border-radius: 8px; margin-bottom: 2rem;">
                <p><strong>Patient:</strong> ${labTest.patient.name}</p>
                <p><strong>Requested By:</strong> Dr. ${labTest.doctor.name}</p>
                <p><strong>Date Requested:</strong> ${labTest.requestDate}</p>
            </div>
            
            <form action="/vendor/upload-results" method="post">
                <input type="hidden" name="id" value="${labTest.id}">
                
                <div class="form-group">
                    <label>Test Results / Notes</label>
                    <textarea name="results" class="form-control" rows="5" placeholder="Enter the lab test results here..." required></textarea>
                </div>

                <div style="display: flex; justify-content: flex-end; gap: 1rem; margin-top: 2rem;">
                    <a href="/vendor/dashboard" class="btn btn-outline">Cancel</a>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-check"></i> Submit Results</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
