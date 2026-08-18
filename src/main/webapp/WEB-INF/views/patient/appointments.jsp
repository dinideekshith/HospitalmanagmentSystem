<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Appointments | Hospital Care</title>
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
            <h2 class="text-primary"><i class="far fa-calendar-alt"></i> My Appointments</h2>
            <p class="text-secondary">View your upcoming and previous appointments.</p>
        </div>
        
        <div class="form-card" style="padding: 0; overflow: hidden; margin-top: 1.5rem;">
            <table class="data-table" style="margin-top: 0; box-shadow: none;">
                <thead>
                    <tr>
                        <th>Doctor</th>
                        <th>Date & Time</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="app" items="${appointments}">
                        <tr>
                            <td><span style="font-weight: 500;">Dr. ${app.doctor.name}</span></td>
                            <td>${app.appointmentDate} <br><span style="font-size: 0.8rem; color: var(--text-secondary);">${app.appointmentTime}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${app.status == 'PENDING'}"><span class="badge badge-warning">Pending</span></c:when>
                                    <c:when test="${app.status == 'CONFIRMED'}"><span class="badge badge-success">Confirmed</span></c:when>
                                    <c:otherwise><span class="badge badge-danger">Rejected</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty appointments}">
                        <tr><td colspan="3" class="text-center">No appointments found. <a href="/patient/book-appointment" style="color: var(--primary-teal);">Book one now.</a></td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
