<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Patient Dashboard | Hospital Care</title>
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
                <div class="nav-profile">
                    <div class="avatar">
                        <c:out value="${user.name.substring(0,1).toUpperCase()}" />
                    </div>
                    <div>
                        <div style="font-weight: 600;">${user.name}</div>
                        <div style="font-size: 0.75rem; color: rgba(255,255,255,0.8);">Patient</div>
                    </div>
                </div>
                <a href="/patient/messages" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;"><i class="fas fa-comments"></i> Chat / Messages</a>
                <a href="/logout" class="btn btn-primary" style="background: white; color: var(--primary-teal);">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="dashboard-header" style="background: var(--primary-teal); color: white; padding: 2.5rem 2rem; border-radius: 12px; margin-bottom: 2rem;">
            <h2 style="font-size: 2rem; margin-bottom: 0.5rem; color: white;">Welcome, ${user.name.split(' ')[0]} 👋</h2>
            <p style="color: rgba(255,255,255,0.8);">Manage your healthcare services from one place.</p>
        </div>
        
        <div style="margin-bottom: 2rem;">
            <h3 class="text-primary" style="font-size: 1.5rem; margin-bottom: 0.2rem;">Healthcare Services</h3>
            <p class="text-secondary" style="font-size: 0.9rem;">Everything you need for your healthcare</p>
        </div>
        
        <c:if test="${not empty param.sos}">
            <div class="alert alert-danger" style="background-color: #FED7D7; color: #C53030; border: 1px solid #FC8181; padding: 1rem; border-radius: 8px; margin-bottom: 2rem;">
                <i class="fas fa-exclamation-triangle"></i> <strong>EMERGENCY SOS TRIGGERED!</strong> The hospital administration has been alerted and an ambulance is being dispatched if available.
            </div>
        </c:if>
        
        <div class="dashboard-grid">
            <a href="/patient/profile" class="service-card">
                <div class="service-card-icon" style="background: #E8F4F4; color: var(--primary-teal);"><i class="fas fa-user"></i></div>
                <h3>My Profile</h3>
                <p>View and manage your personal information and account details.</p>
                <i class="fas fa-arrow-right" style="position: absolute; bottom: 1.5rem; right: 1.5rem; color: var(--primary-teal); opacity: 0.5;"></i>
            </a>
            
            <a href="/patient/book-appointment" class="service-card">
                <div class="service-card-icon" style="background: #EBF4FF; color: #4299E1;"><i class="fas fa-stethoscope"></i></div>
                <h3>Book Appointment</h3>
                <p>Find a doctor and schedule a hospital appointment easily.</p>
                <i class="fas fa-arrow-right" style="position: absolute; bottom: 1.5rem; right: 1.5rem; color: var(--primary-teal); opacity: 0.5;"></i>
            </a>
            
            <a href="/patient/appointments" class="service-card">
                <div class="service-card-icon" style="background: #F0FFF4; color: #48BB78;"><i class="far fa-calendar-alt"></i></div>
                <h3>My Appointments</h3>
                <p>View your upcoming and previous appointments.</p>
                <i class="fas fa-arrow-right" style="position: absolute; bottom: 1.5rem; right: 1.5rem; color: var(--primary-teal); opacity: 0.5;"></i>
            </a>
            
            <a href="/patient/medical-records" class="service-card">
                <div class="service-card-icon" style="background: #FFF5F5; color: #F56565;"><i class="fas fa-clipboard-list"></i></div>
                <h3>Medical Records</h3>
                <p>Access your medical history and hospital records.</p>
                <i class="fas fa-arrow-right" style="position: absolute; bottom: 1.5rem; right: 1.5rem; color: var(--primary-teal); opacity: 0.5;"></i>
            </a>
            
            <a href="/patient/prescriptions" class="service-card">
                <div class="service-card-icon" style="background: #FAF5FF; color: #9F7AEA;"><i class="fas fa-pills"></i></div>
                <h3>Prescriptions</h3>
                <p>View medicines and prescriptions provided by your doctor.</p>
                <i class="fas fa-arrow-right" style="position: absolute; bottom: 1.5rem; right: 1.5rem; color: var(--primary-teal); opacity: 0.5;"></i>
            </a>
            
            <a href="/patient/lab-tests" class="service-card">
                <div class="service-card-icon" style="background: #FFFAF0; color: #DD6B20;"><i class="fas fa-vial"></i></div>
                <h3>Lab Results</h3>
                <p>View requested lab tests and diagnostic reports.</p>
                <i class="fas fa-arrow-right" style="position: absolute; bottom: 1.5rem; right: 1.5rem; color: var(--primary-teal); opacity: 0.5;"></i>
            </a>
            
            <!-- NEW CARDS -->
            <form action="/patient/sos/trigger" method="POST" style="margin:0;">
                <button type="submit" class="service-card" style="width:100%; text-align:left; background: #FFF5F5; border: 2px solid #FEB2B2; cursor: pointer;">
                    <div class="service-card-icon" style="background: #FED7D7; color: #E53E3E;"><i class="fas fa-heartbeat"></i></div>
                    <h3 style="color: #C53030;">Emergency SOS</h3>
                    <p style="color: #E53E3E;">Trigger an immediate critical alert to the hospital.</p>
                </button>
            </form>
            
            <a href="/patient/ambulance/request" class="service-card">
                <div class="service-card-icon" style="background: #E6FFFA; color: #319795;"><i class="fas fa-ambulance"></i></div>
                <h3>Request Ambulance</h3>
                <p>Dispatch an ambulance to your location immediately.</p>
                <i class="fas fa-arrow-right" style="position: absolute; bottom: 1.5rem; right: 1.5rem; color: var(--primary-teal); opacity: 0.5;"></i>
            </a>
        </div>
        
        <!-- NEW WIDGETS -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 2rem;">
            <!-- Bed Selection -->
            <div class="card" style="background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
                <h3 style="color: var(--primary-teal); margin-bottom: 1rem;"><i class="fas fa-bed"></i> Bed Assignment</h3>
                <c:choose>
                    <c:when test="${not empty assignedBed}">
                        <div class="alert alert-success" style="background: #F0FFF4; border-left: 4px solid #48BB78; padding: 1rem;">
                            <strong>Bed Number:</strong> ${assignedBed.bedNumber} <br/>
                            <strong>Room:</strong> ${assignedBed.room.roomNumber} (${assignedBed.room.roomType})
                        </div>
                    </c:when>
                    <c:otherwise>
                        <form action="/patient/select-bed" method="POST">
                            <div class="form-group">
                                <label>Select Preferred Bed / Room Type:</label>
                                <select name="bedId" class="form-control" required style="width: 100%; padding: 0.75rem; border-radius: 8px; border: 1px solid #E2E8F0; margin-bottom: 1rem;">
                                    <option value="">-- Choose a Bed --</option>
                                    <c:forEach var="bed" items="${availableBeds}">
                                        <option value="${bed.id}">Room ${bed.room.roomNumber} (${bed.room.roomType}) - Bed ${bed.bedNumber}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <button type="submit" class="btn btn-primary" style="width: 100%;">Confirm Bed Selection</button>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Ambulance Tracker -->
            <div class="card" style="background: white; padding: 2rem; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05);">
                <h3 style="color: var(--primary-teal); margin-bottom: 1rem;"><i class="fas fa-ambulance"></i> Live Ambulance Tracker</h3>
                <c:choose>
                    <c:when test="${not empty ambulanceRequests}">
                        <c:forEach var="req" items="${ambulanceRequests}">
                            <div style="border: 1px solid #E2E8F0; padding: 1rem; border-radius: 8px; margin-bottom: 1rem;">
                                <strong>Status:</strong> 
                                <span class="badge" style="background: #4299E1; color: white; padding: 0.2rem 0.5rem; border-radius: 4px;">${req.status}</span><br/>
                                <c:if test="${not empty req.ambulance}">
                                    <strong>Driver:</strong> ${req.ambulance.driverName} (${req.ambulance.driverContact})<br/>
                                    <strong>Vehicle No:</strong> ${req.ambulance.vehicleNumber}<br/>
                                </c:if>
                                <div style="display: flex; justify-content: space-between; margin-top: 1rem; color: #A0AEC0; font-size: 0.8rem;">
                                    <span style="${req.status == 'CREATED' || req.status == 'ASSIGNED' ? 'color:#48BB78;font-weight:bold;' : ''}">Dispatched</span>
                                    <span>&rarr;</span>
                                    <span style="${req.status == 'ON_THE_WAY' ? 'color:#48BB78;font-weight:bold;' : ''}">Arriving</span>
                                    <span>&rarr;</span>
                                    <span style="${req.status == 'COMPLETED' ? 'color:#48BB78;font-weight:bold;' : ''}">Completed</span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p class="text-secondary">No active ambulance requests.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <p class="text-center mt-4 text-secondary" style="font-size: 0.8rem;">
            &copy; 2026 Hospital Care - Hospital Management System
        </p>
    </div>
</body>
</html>
