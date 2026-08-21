<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ambulance Management - Admin Portal</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .form-grid-3 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 1rem;
            align-items: end;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2.5rem;
            margin-bottom: 1rem;
        }
    </style>
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
        <div class="dashboard-header">
            <h2 class="text-primary"><i class="fas fa-ambulance"></i> Ambulance Fleet Management</h2>
            <p class="text-secondary">Manage hospital ambulances and dispatch requests in real time.</p>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Ambulance vehicle added successfully to the fleet.
            </div>
        </c:if>

        <c:if test="${not empty param.assigned}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Ambulance has been assigned to the request successfully.
            </div>
        </c:if>

        <!-- Add Ambulance Form Card -->
        <div class="form-card" style="max-width: 100%; margin-bottom: 2rem;">
            <div class="form-header" style="margin-bottom: 1.25rem;">
                <i class="fas fa-plus-circle"></i>
                <h3 style="margin: 0; color: var(--primary-teal); font-size: 1.15rem;">Register New Ambulance</h3>
            </div>
            <form action="/admin/ambulances/add" method="POST">
                <div class="form-grid-3">
                    <div class="form-group" style="margin-bottom: 0;">
                        <label>Vehicle Number</label>
                        <input type="text" name="vehicleNumber" class="form-control" placeholder="e.g. DL-01-AB-1234" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label>Driver Name</label>
                        <input type="text" name="driverName" class="form-control" placeholder="e.g. Ramesh Kumar" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label>Driver Contact</label>
                        <input type="tel" name="driverContact" class="form-control" placeholder="e.g. +91 9876543210" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <button type="submit" class="btn btn-primary" style="width: 100%; height: 44px;">
                            <i class="fas fa-plus"></i> Add Ambulance
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Ambulance Fleet Table -->
        <div class="section-header" style="margin-top: 1rem;">
            <h3 class="text-primary"><i class="fas fa-truck-medical"></i> Available Fleet</h3>
        </div>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Vehicle Number</th>
                    <th>Driver Name</th>
                    <th>Driver Contact</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="amb" items="${ambulances}">
                    <tr>
                        <td><strong>${amb.vehicleNumber}</strong></td>
                        <td>${amb.driverName}</td>
                        <td>${amb.driverContact}</td>
                        <td>
                            <c:choose>
                                <c:when test="${amb.status == 'AVAILABLE'}">
                                    <span class="badge badge-success">Available</span>
                                </c:when>
                                <c:when test="${amb.status == 'ASSIGNED' || amb.status == 'ON_THE_WAY'}">
                                    <span class="badge badge-warning">${amb.status}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-primary">${amb.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty ambulances}">
                    <tr>
                        <td colspan="4" class="text-center" style="padding: 1.5rem;">No ambulances registered in the system yet.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <!-- Ambulance Requests Table -->
        <div class="section-header">
            <h3 class="text-primary"><i class="fas fa-bell"></i> Ambulance Requests & Dispatches</h3>
        </div>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Request ID</th>
                    <th>Patient Name</th>
                    <th>Pickup Location</th>
                    <th>Destination</th>
                    <th>Emergency Priority</th>
                    <th>Status</th>
                    <th>Assigned Ambulance</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="req" items="${requests}">
                    <tr>
                        <td>#REQ-${req.id}</td>
                        <td><strong>${req.patient != null ? req.patient.user.name : 'Unknown Patient'}</strong></td>
                        <td>${req.pickupLocation}</td>
                        <td>${req.destination}</td>
                        <td>
                            <c:choose>
                                <c:when test="${req.emergency}">
                                    <span class="badge badge-danger">EMERGENCY (SOS)</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-primary">Standard</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${req.status == 'COMPLETED'}">
                                    <span class="badge badge-success">Completed</span>
                                </c:when>
                                <c:when test="${req.status == 'ASSIGNED' || req.status == 'ON_THE_WAY'}">
                                    <span class="badge badge-warning">${req.status}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-danger">${req.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${req.ambulance != null}">
                                    <strong>${req.ambulance.vehicleNumber}</strong> (${req.ambulance.driverName})
                                </c:when>
                                <c:otherwise>
                                    <form action="/admin/ambulances/assign" method="POST" style="display: flex; gap: 6px; align-items: center;">
                                        <input type="hidden" name="requestId" value="${req.id}">
                                        <select name="ambulanceId" class="form-control" style="padding: 0.35rem 0.5rem; font-size: 0.85rem;" required>
                                            <option value="">Select Ambulance</option>
                                            <c:forEach var="availAmb" items="${ambulances}">
                                                <c:if test="${availAmb.status == 'AVAILABLE'}">
                                                    <option value="${availAmb.id}">${availAmb.vehicleNumber} (${availAmb.driverName})</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                        <button type="submit" class="btn btn-sm btn-primary" style="white-space: nowrap;">Assign</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty requests}">
                    <tr>
                        <td colspan="7" class="text-center" style="padding: 1.5rem;">No ambulance requests found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
