<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Laboratory Tests | Hospital Care</title>
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
            <h2 class="text-primary">Laboratory Tests</h2>
            <a href="/doctor/request-lab-test" class="btn btn-primary"><i class="fas fa-plus"></i> Request New Test</a>
        </div>
        <div class="form-card" style="padding: 0; overflow: hidden;">
            <table class="data-table" style="margin-top: 0; box-shadow: none;">
                <thead>
                    <tr><th>Date</th><th>Patient</th><th>Test Name</th><th>Status</th><th>Results</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="t" items="${labTests}">
                        <tr>
                            <td>${t.requestDate}</td>
                            <td><span style="font-weight: 500;">${t.patient.name}</span></td>
                            <td>${t.testName}</td>
                            <td><span class="badge ${t.status == 'PENDING' ? 'badge-warning' : 'badge-success'}">${t.status}</span></td>
                            <td>${t.results != null ? t.results : '-'}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty labTests}"><tr><td colspan="5" class="text-center">No lab tests requested yet.</td></tr></c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
