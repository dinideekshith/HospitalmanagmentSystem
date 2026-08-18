<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Patients | Hospital Care</title>
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
        <h2 class="text-primary mb-2">My Patients</h2>
        <div class="form-card" style="padding: 0; overflow: hidden;">
            <table class="data-table" style="margin-top: 0; box-shadow: none;">
                <thead>
                    <tr><th>Patient ID</th><th>Name</th><th>Email</th><th>Contact</th><th>Actions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${patients}">
                        <tr>
                            <td>#${p.id}</td>
                            <td><span style="font-weight: 500;">${p.name}</span></td>
                            <td>${p.email}</td>
                            <td>${p.mobileNumber}</td>
                            <td>
                                <a href="/doctor/add-medical-record?patientId=${p.id}" class="btn btn-sm btn-primary">Add Record</a>
                                <a href="/doctor/add-prescription?patientId=${p.id}" class="btn btn-sm btn-outline">Add Rx</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty patients}"><tr><td colspan="5" class="text-center">No patients found.</td></tr></c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
