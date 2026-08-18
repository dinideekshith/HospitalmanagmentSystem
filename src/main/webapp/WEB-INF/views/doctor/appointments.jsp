<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctor Appointments | Hospital Care</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/doctor/dashboard" class="nav-brand"><i class="fas fa-plus"></i> Hospital Care</a>
            <div class="nav-links">
                <a href="/doctor/dashboard" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">&larr; Back</a>
            </div>
        </div>
    </nav>
    <div class="container dashboard-wrapper">
        <h2 class="text-primary mb-2">My Appointments</h2>
        <div class="form-card" style="padding: 0; overflow: hidden;">
            <table class="data-table" style="margin-top: 0; box-shadow: none;">
                <thead>
                    <tr><th>Patient Name</th><th>Date & Time</th><th>Status</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="app" items="${appointments}">
                        <tr>
                            <td><span style="font-weight: 500;">${app.patient.name}</span></td>
                            <td>${app.appointmentDate} <br><span style="font-size: 0.8rem; color: var(--text-secondary);">${app.appointmentTime}</span></td>
                            <td><span class="badge ${app.status == 'PENDING' ? 'badge-warning' : 'badge-success'}">${app.status}</span></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty appointments}"><tr><td colspan="3" class="text-center">No appointments found.</td></tr></c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
