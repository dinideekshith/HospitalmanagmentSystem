<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bed & Room Management - Admin Portal</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .forms-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }
        @media (max-width: 768px) {
            .forms-container {
                grid-template-columns: 1fr;
            }
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
            <h2 class="text-primary"><i class="fas fa-bed"></i> Bed & Room Management</h2>
            <p class="text-secondary">Manage hospital wards, room types, capacities, and individual patient bed allocations.</p>
        </div>

        <c:if test="${not empty param.roomAdded}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Room added successfully.
            </div>
        </c:if>

        <c:if test="${not empty param.bedAdded}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Bed added successfully to the designated room.
            </div>
        </c:if>

        <!-- Forms Container (Add Room & Add Bed) -->
        <div class="forms-container">
            <!-- Add Room Form -->
            <div class="form-card" style="max-width: 100%; margin: 0;">
                <div class="form-header" style="margin-bottom: 1.25rem;">
                    <i class="fas fa-door-open"></i>
                    <h3 style="margin: 0; color: var(--primary-teal); font-size: 1.15rem;">Add New Room</h3>
                </div>
                <form action="/admin/rooms/add" method="POST">
                    <div class="form-group">
                        <label>Room Number / Ward ID</label>
                        <input type="text" name="roomNumber" class="form-control" placeholder="e.g. 101, ICU-1" required>
                    </div>
                    <div class="form-group">
                        <label>Room Type</label>
                        <select name="roomType" class="form-control" required>
                            <option value="GENERAL">General Ward</option>
                            <option value="PRIVATE">Private Room</option>
                            <option value="SEMI_PRIVATE">Semi-Private Room</option>
                            <option value="ICU">Intensive Care Unit (ICU)</option>
                            <option value="EMERGENCY">Emergency Care</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Bed Capacity</label>
                        <input type="number" name="capacity" class="form-control" placeholder="e.g. 4" min="1" required>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">
                        <i class="fas fa-plus"></i> Add Room
                    </button>
                </form>
            </div>

            <!-- Add Bed Form -->
            <div class="form-card" style="max-width: 100%; margin: 0;">
                <div class="form-header" style="margin-bottom: 1.25rem;">
                    <i class="fas fa-bed"></i>
                    <h3 style="margin: 0; color: var(--primary-teal); font-size: 1.15rem;">Add New Bed</h3>
                </div>
                <form action="/admin/beds/add" method="POST">
                    <div class="form-group">
                        <label>Bed Identifier</label>
                        <input type="text" name="bedNumber" class="form-control" placeholder="e.g. B-101-A, ICU-03" required>
                    </div>
                    <div class="form-group">
                        <label>Assign to Room</label>
                        <select name="roomId" class="form-control" required>
                            <option value="">Select Target Room</option>
                            <c:forEach var="r" items="${rooms}">
                                <option value="${r.id}">Room ${r.roomNumber} (${r.roomType}) - Cap: ${r.capacity}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group" style="visibility: hidden; margin-bottom: 0;">
                        <!-- Alignment placeholder -->
                        <label>&nbsp;</label>
                        <input type="text" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">
                        <i class="fas fa-plus"></i> Add Bed
                    </button>
                </form>
            </div>
        </div>

        <!-- Beds Table -->
        <div class="section-header" style="margin-top: 1rem;">
            <h3 class="text-primary"><i class="fas fa-list-check"></i> Hospital Beds Overview</h3>
        </div>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Bed Number</th>
                    <th>Room Number</th>
                    <th>Room Type</th>
                    <th>Status</th>
                    <th>Assigned Patient</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="b" items="${beds}">
                    <tr>
                        <td><strong>${b.bedNumber}</strong></td>
                        <td>Room ${b.room.roomNumber}</td>
                        <td><span class="badge badge-primary">${b.room.roomType}</span></td>
                        <td>
                            <c:choose>
                                <c:when test="${b.status == 'AVAILABLE'}">
                                    <span class="badge badge-success">Available</span>
                                </c:when>
                                <c:when test="${b.status == 'OCCUPIED'}">
                                    <span class="badge badge-danger">Occupied</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-warning">${b.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${b.assignedPatient != null}">
                                    <strong>${b.assignedPatient.user.name}</strong>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-secondary">-</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty beds}">
                    <tr>
                        <td colspan="5" class="text-center" style="padding: 1.5rem;">No beds added to the system yet.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>

        <!-- Rooms Table -->
        <div class="section-header">
            <h3 class="text-primary"><i class="fas fa-hospital"></i> Hospital Rooms & Wards</h3>
        </div>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Room ID</th>
                    <th>Room Number</th>
                    <th>Room Type</th>
                    <th>Capacity</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="r" items="${rooms}">
                    <tr>
                        <td>#RM-${r.id}</td>
                        <td><strong>Room ${r.roomNumber}</strong></td>
                        <td><span class="badge badge-primary">${r.roomType}</span></td>
                        <td>${r.capacity} Beds</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty rooms}">
                    <tr>
                        <td colspan="4" class="text-center" style="padding: 1.5rem;">No rooms configured in the system yet.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
