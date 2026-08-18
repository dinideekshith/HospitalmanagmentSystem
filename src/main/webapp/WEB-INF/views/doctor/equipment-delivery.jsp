<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Equipment Delivery Tracking | Hospital Care</title>
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
        <h2 class="text-primary mb-2"><i class="fas fa-truck"></i> Equipment Delivery Tracking</h2>
        <div class="form-card" style="padding: 0; overflow: hidden;">
            <table class="data-table" style="margin-top: 0; box-shadow: none;">
                <thead>
                    <tr><th>Request Date</th><th>Equipment</th><th>Quantity</th><th>Delivery Status</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="req" items="${equipmentRequests}">
                        <tr>
                            <td>${req.requestDate}</td>
                            <td><span style="font-weight: 500;">${req.equipmentName}</span></td>
                            <td>${req.quantity}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${req.status == 'DELIVERED'}"><span style="color: var(--primary-teal); font-weight: 600;"><i class="fas fa-check-circle"></i> Delivered</span></c:when>
                                    <c:otherwise><span class="text-secondary" style="font-style: italic;"><i class="fas fa-spinner fa-spin"></i> In Transit (Pending Supplier)</span></c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty equipmentRequests}"><tr><td colspan="4" class="text-center">No delivery tracking available.</td></tr></c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
