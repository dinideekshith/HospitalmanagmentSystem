<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Emergency SOS Alerts - Admin Portal</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .sos-badge-active {
            background-color: #FED7D7;
            color: #C53030;
            animation: pulse 1.8s infinite;
        }
        @keyframes pulse {
            0% { transform: scale(1); box-shadow: 0 0 0 0 rgba(229, 62, 62, 0.4); }
            70% { transform: scale(1.03); box-shadow: 0 0 0 6px rgba(229, 62, 62, 0); }
            100% { transform: scale(1); box-shadow: 0 0 0 0 rgba(229, 62, 62, 0); }
        }
        .emergency-row-active {
            background: rgba(254, 215, 215, 0.25) !important;
            border-left: 4px solid #E53E3E;
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
            <h2 class="text-primary" style="color: #E53E3E;"><i class="fas fa-heartbeat"></i> Emergency SOS & Critical Response</h2>
            <p class="text-secondary">Real-time monitoring of all incoming patient emergency alerts and rapid response deployments.</p>
        </div>

        <table class="data-table">
            <thead>
                <tr>
                    <th>Alert ID</th>
                    <th>Patient Name</th>
                    <th>Contact</th>
                    <th>Blood Group</th>
                    <th>Triggered Time</th>
                    <th>Ambulance</th>
                    <th>Assigned Doctor</th>
                    <th>Assigned Bed</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="e" items="${emergencies}">
                    <tr class="${e.status != 'COMPLETED' ? 'emergency-row-active' : ''}">
                        <td><strong>#SOS-${e.id}</strong></td>
                        <td>
                            <span style="font-weight: 600;">
                                <c:choose>
                                    <c:when test="${e.patient != null && e.patient.user != null}">
                                        ${e.patient.user.name}
                                    </c:when>
                                    <c:otherwise>Unknown</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${e.patient != null && e.patient.user != null}">
                                    ${e.patient.user.mobileNumber}
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="badge badge-warning" style="font-weight: 700;">
                                <c:choose>
                                    <c:when test="${not empty e.patientBloodGroup}">
                                        ${e.patientBloodGroup}
                                    </c:when>
                                    <c:when test="${e.patient != null && not empty e.patient.bloodGroup}">
                                        ${e.patient.bloodGroup}
                                    </c:when>
                                    <c:otherwise>N/A</c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>${e.requestTime}</td>
                        <td>
                            <c:choose>
                                <c:when test="${e.assignedAmbulance != null}">
                                    <i class="fas fa-ambulance text-primary"></i> ${e.assignedAmbulance.vehicleNumber}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-secondary">Not Assigned</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${e.assignedDoctor != null && e.assignedDoctor.user != null}">
                                    <i class="fas fa-user-md text-primary"></i> Dr. ${e.assignedDoctor.user.name}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-secondary">Not Assigned</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${e.assignedBed != null}">
                                    <i class="fas fa-bed text-primary"></i> Bed ${e.assignedBed.bedNumber}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-secondary">Not Assigned</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${e.status == 'COMPLETED'}">
                                    <span class="badge badge-success">Completed</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge sos-badge-active">${e.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty emergencies}">
                    <tr>
                        <td colspan="9" class="text-center" style="padding: 1.5rem;">No active emergency SOS alerts found.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>
</body>
</html>
