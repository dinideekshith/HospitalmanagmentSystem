<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Equipment Requests | Admin Dashboard</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/admin/dashboard" class="nav-brand">
                <i class="fas fa-plus"></i> Hospital Care
            </a>
            <div class="nav-links">
                <a href="/admin/dashboard" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="dashboard-header">
            <h2 class="text-primary"><i class="fas fa-box-open"></i> Medical Equipment Requests</h2>
            <p class="text-secondary">Overview of all equipment requested by doctors across the hospital.</p>
        </div>

        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Requested By</th>
                    <th>Equipment Name</th>
                    <th>Quantity</th>
                    <th>Request Date</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="req" items="${equipmentRequests}">
                    <tr>
                        <td>#${req.id}</td>
                        <td><span style="font-weight: 500;">Dr. ${req.doctor.name}</span></td>
                        <td>${req.equipmentName}</td>
                        <td>${req.quantity}</td>
                        <td>${req.requestDate}</td>
                        <td>
                            <c:choose>
                                <c:when test="${req.status == 'PENDING'}">
                                    <span class="badge badge-warning">PENDING VENDOR</span>
                                </c:when>
                                <c:when test="${req.status == 'DELIVERED'}">
                                    <span class="badge badge-success">DELIVERED</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-primary">${req.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty equipmentRequests}">
                    <tr>
                        <td colspan="6" class="text-center">No equipment requests found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
