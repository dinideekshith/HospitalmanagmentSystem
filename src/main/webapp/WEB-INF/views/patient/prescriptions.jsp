<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Prescriptions | Hospital Care</title>
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
                <a href="/patient/dashboard" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">&larr; Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="dashboard-header">
            <h2 class="text-primary"><i class="fas fa-pills"></i> My Prescriptions</h2>
            <p class="text-secondary">View medicines and prescriptions provided by your doctor.</p>
        </div>
        
        <div class="form-card" style="padding: 0; overflow: hidden; margin-top: 1.5rem;">
            <table class="data-table" style="margin-top: 0; box-shadow: none;">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Medicine</th>
                        <th>Dosage & Duration</th>
                        <th>Doctor</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${prescriptions}">
                        <tr>
                            <td>${p.prescriptionDate}</td>
                            <td><span style="font-weight: 500; color: var(--primary-teal);">${p.medicineName}</span></td>
                            <td>${p.dosage} for ${p.duration}</td>
                            <td>Dr. ${p.doctor.name}</td>
                            <td><span class="badge ${p.status == 'PENDING' ? 'badge-warning' : 'badge-success'}">${p.status}</span></td>
                            <td>
                                <a href="/patient/download-prescription?id=${p.id}" class="btn btn-sm btn-outline" style="color: #E53E3E; border-color: #E53E3E;">
                                    <i class="fas fa-file-pdf"></i> Download
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty prescriptions}">
                        <tr><td colspan="6" class="text-center">No prescriptions found.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
