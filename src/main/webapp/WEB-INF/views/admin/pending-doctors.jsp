<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pending Doctor Approvals - HMS</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/admin/dashboard" class="nav-brand"><i class="fas fa-shield-alt"></i> Admin Portal</a>
            <div class="nav-links">
                <a href="/admin/dashboard" class="btn btn-outline" style="padding: 0.5rem 1rem;">Dashboard</a>
                <a href="/logout" class="btn btn-outline" style="padding: 0.5rem 1rem; margin-left: 10px;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <h2 class="text-primary mb-2">Pending Doctor Approvals</h2>
        
        <table class="data-table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="doctor" items="${pendingDoctors}">
                    <tr>
                        <td>${doctor.id}</td>
                        <td><span style="font-weight: 500;">${doctor.name}</span></td>
                        <td>${doctor.email}</td>
                        <td>${doctor.mobileNumber}</td>
                        <td>
                            <form action="/admin/approve-doctor" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="${doctor.id}">
                                <button type="submit" class="btn btn-sm btn-primary">Approve</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty pendingDoctors}">
                    <tr>
                        <td colspan="5" class="text-center">No pending doctor registrations.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
