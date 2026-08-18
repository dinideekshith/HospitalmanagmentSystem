<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vendor Dashboard | Hospital Care</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/vendor/dashboard" class="nav-brand">
                <i class="fas fa-plus"></i> Hospital Care
            </a>
            <div class="nav-links">
                <div class="nav-profile">
                    <div class="avatar">
                        <c:out value="${user.name.substring(0,1).toUpperCase()}" />
                    </div>
                    <div>
                        <div style="font-weight: 600;">${user.name}</div>
                        <div style="font-size: 0.75rem; color: rgba(255,255,255,0.8);">Vendor (${vendor.vendorType})</div>
                    </div>
                </div>
                <a href="/vendor/profile" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">Profile</a>
                <a href="/logout" class="btn btn-primary" style="background: white; color: var(--primary-teal);">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="dashboard-header">
            <h2 class="text-primary">Vendor Portal</h2>
            <p class="text-secondary">Welcome, ${vendor.businessName != null ? vendor.businessName : user.name}. Manage your hospital requests below.</p>
        </div>
        
        <c:choose>
            <c:when test="${vendor.vendorType == 'Pharmacy' || vendor.vendorType == 'PHARMACY'}">
                <h3 class="mt-4 mb-2" style="color: var(--primary-teal);"><i class="fas fa-pills"></i> Pending Prescriptions to Fulfill</h3>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Patient Name</th>
                            <th>Doctor</th>
                            <th>Medicine</th>
                            <th>Dosage & Duration</th>
                            <th>Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${prescriptions}">
                            <tr>
                                <td><span style="font-weight: 500;">${p.patient.name}</span></td>
                                <td>Dr. ${p.doctor.name}</td>
                                <td>${p.medicineName}</td>
                                <td>${p.dosage} for ${p.duration}</td>
                                <td>${p.prescriptionDate}</td>
                                <td>
                                    <form action="/vendor/fulfill-prescription" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="${p.id}">
                                        <button type="submit" class="btn btn-sm btn-primary">Mark Fulfilled</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty prescriptions}">
                            <tr><td colspan="6" class="text-center">No pending prescriptions at this time.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </c:when>
            
            <c:when test="${vendor.vendorType == 'Diagnostic Lab' || vendor.vendorType == 'LAB'}">
                <h3 class="mt-4 mb-2" style="color: var(--primary-teal);"><i class="fas fa-vial"></i> Pending Lab Tests</h3>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Patient Name</th>
                            <th>Doctor</th>
                            <th>Test Name</th>
                            <th>Requested Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="t" items="${labTests}">
                            <tr>
                                <td><span style="font-weight: 500;">${t.patient.name}</span></td>
                                <td>Dr. ${t.doctor.name}</td>
                                <td><span class="badge badge-warning">${t.testName}</span></td>
                                <td>${t.requestDate}</td>
                                <td>
                                    <a href="/vendor/upload-results?id=${t.id}" class="btn btn-sm btn-primary">Upload Results</a>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty labTests}">
                            <tr><td colspan="5" class="text-center">No pending lab tests at this time.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </c:when>

            <c:when test="${vendor.vendorType == 'Surgical Supplier' || vendor.vendorType == 'SUPPLIER'}">
                <h3 class="mt-4 mb-2" style="color: var(--primary-teal);"><i class="fas fa-box-open"></i> Pending Equipment Requests</h3>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>Requested By</th>
                            <th>Equipment</th>
                            <th>Quantity</th>
                            <th>Date</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="req" items="${equipmentRequests}">
                            <tr>
                                <td>Dr. ${req.doctor.name}</td>
                                <td><span style="font-weight: 500;">${req.equipmentName}</span></td>
                                <td>${req.quantity}</td>
                                <td>${req.requestDate}</td>
                                <td>
                                    <form action="/vendor/deliver-equipment" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="${req.id}">
                                        <button type="submit" class="btn btn-sm btn-primary">Mark Delivered</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty equipmentRequests}">
                            <tr><td colspan="5" class="text-center">No pending equipment requests at this time.</td></tr>
                        </c:if>
                    </tbody>
                </table>
            </c:when>

            <c:otherwise>
                <div class="alert alert-warning mt-4">
                    Please go to your Profile and update your Vendor Type (PHARMACY, LAB, or SUPPLIER) to start receiving requests.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
