<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctor Dashboard | Hospital Care</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/doctor/dashboard" class="nav-brand">
                <i class="fas fa-plus"></i> Hospital Care
            </a>
            <div class="nav-links">
                <div class="nav-profile">
                    <div class="avatar">
                        <c:out value="${user.name.substring(0,1).toUpperCase()}" />
                    </div>
                    <div>
                        <div style="font-weight: 600;">Dr. ${user.name.split(' ')[0]}</div>
                        <div style="font-size: 0.75rem; color: rgba(255,255,255,0.8);">Doctor</div>
                    </div>
                </div>
                <a href="/doctor/profile" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">Profile</a>
                <a href="/logout" class="btn btn-primary" style="background: white; color: var(--primary-teal);">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="dashboard-header">
            <h2 class="text-primary">Doctor Services</h2>
        </div>
        
        <div class="dashboard-grid">
            <a href="/doctor/appointments" class="service-card">
                <div class="service-card-icon" style="background: #E8F4F4;"><i class="far fa-calendar-alt"></i></div>
                <h3>Appointments</h3>
                <p>View and manage your patient appointments.</p>
            </a>
            
            <a href="/doctor/patients" class="service-card">
                <div class="service-card-icon" style="background: #EBF4FF; color: #4299E1;"><i class="fas fa-user-injured"></i></div>
                <h3>My Patients</h3>
                <p>View patients assigned to your care.</p>
            </a>
            
            <a href="/doctor/prescriptions" class="service-card">
                <div class="service-card-icon" style="background: #FFF5F5; color: #F56565;"><i class="fas fa-capsules"></i></div>
                <h3>Prescriptions</h3>
                <p>Create and manage patient prescriptions.</p>
            </a>
            
            <a href="/doctor/medical-records" class="service-card">
                <div class="service-card-icon" style="background: #F0FFF4; color: #48BB78;"><i class="fas fa-notes-medical"></i></div>
                <h3>Medical Records</h3>
                <p>View and manage patient medical records.</p>
            </a>
            
            <a href="/doctor/laboratory-tests" class="service-card">
                <div class="service-card-icon" style="background: #FAF5FF; color: #9F7AEA;"><i class="fas fa-vial"></i></div>
                <h3>Laboratory Tests</h3>
                <p>Request laboratory tests and view test results.</p>
            </a>
            
            <a href="/doctor/medical-equipment" class="service-card" style="position: relative;">
                <span class="badge badge-success" style="position: absolute; top: 1rem; right: 1rem;">NEW</span>
                <div class="service-card-icon" style="background: #E6FFFA; color: #319795;"><i class="fas fa-stethoscope"></i></div>
                <h3>Medical Equipment</h3>
                <p>View available medical equipment and send requests.</p>
            </a>
            
            <a href="/doctor/equipment-requests" class="service-card">
                <div class="service-card-icon" style="background: #FFFAF0; color: #DD6B20;"><i class="fas fa-box-open"></i></div>
                <h3>My Equipment Requests</h3>
                <p>Track your submitted equipment requests.</p>
            </a>
            
            <a href="/doctor/equipment-delivery" class="service-card">
                <div class="service-card-icon" style="background: #EDF2F7; color: #4A5568;"><i class="fas fa-truck"></i></div>
                <h3>Equipment Delivery</h3>
                <p>Track equipment approval, dispatch and delivery status.</p>
            </a>
        </div>
        
        <div class="quick-actions">
            <h4 style="width: 100%; margin-bottom: 0.5rem; color: var(--text-secondary);">Quick Actions</h4>
            <a href="/doctor/appointments" class="btn">View Appointments</a>
            <a href="/doctor/patients" class="btn">View Patients</a>
            <a href="/doctor/prescriptions" class="btn">Prescriptions</a>
            <a href="/doctor/medical-equipment" class="btn">Request Equipment</a>
            <a href="/doctor/equipment-delivery" class="btn">Track Delivery</a>
        </div>
        
        <p class="text-center mt-4 text-secondary" style="font-size: 0.8rem;">
            Hospital Care Management System | Doctor Portal
        </p>
    </div>
</body>
</html>
