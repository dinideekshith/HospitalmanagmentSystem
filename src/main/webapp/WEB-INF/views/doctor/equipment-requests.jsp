<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Equipment Requests | Hospital Care</title>
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
        <div style="display: flex; justify-content: space-between; align-items: center;" class="mb-2">
            <h2 class="text-primary">My Equipment Requests</h2>
            <a href="/doctor/medical-equipment" class="btn btn-primary"><i class="fas fa-plus"></i> New Request</a>
        </div>
        <div class="form-card" style="padding: 0; overflow: hidden;">
            <table class="data-table" style="margin-top: 0; box-shadow: none;">
                <thead>
                    <tr><th>Date</th><th>Equipment Name</th><th>Quantity</th><th>Status</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="req" items="${equipmentRequests}">
                        <tr>
                            <td>${req.requestDate}</td>
                            <td><span style="font-weight: 500;">${req.equipmentName}</span></td>
                            <td>${req.quantity}</td>
                            <td><span class="badge ${req.status == 'PENDING' ? 'badge-warning' : 'badge-success'}">${req.status}</span></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty equipmentRequests}"><tr><td colspan="4" class="text-center">No equipment requests found.</td></tr></c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
