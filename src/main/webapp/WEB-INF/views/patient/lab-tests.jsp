<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lab Results | Hospital Care</title>
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
            <h2 class="text-primary"><i class="fas fa-vial"></i> Lab Results</h2>
            <p class="text-secondary">View requested lab tests and diagnostic reports.</p>
        </div>
        
        <div class="form-card" style="padding: 0; overflow: hidden; margin-top: 1.5rem;">
            <table class="data-table" style="margin-top: 0; box-shadow: none;">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Test Name</th>
                        <th>Requested By</th>
                        <th>Status</th>
                        <th>Result Details</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="t" items="${labTests}">
                        <tr>
                            <td>${t.requestDate}</td>
                            <td><span style="font-weight: 500;">${t.testName}</span></td>
                            <td>Dr. ${t.doctor.name}</td>
                            <td><span class="badge ${t.status == 'PENDING' ? 'badge-warning' : 'badge-success'}">${t.status}</span></td>
                            <td>
                                <c:choose>
                                    <c:when test="${t.status == 'COMPLETED'}">
                                        <span style="color: var(--primary-teal); font-weight: 500;">${t.results}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-secondary" style="font-style: italic;">Awaiting results from laboratory...</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty labTests}">
                        <tr><td colspan="5" class="text-center">No lab tests requested.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
