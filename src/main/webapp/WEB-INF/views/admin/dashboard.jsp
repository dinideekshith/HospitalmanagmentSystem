<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - HMS</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="#" class="nav-brand"><i class="fas fa-shield-alt"></i> Admin Portal</a>
            <div class="nav-links">
                <span style="color: var(--text-secondary); margin-right: 15px;">Welcome, ${user.name}</span>
                <a href="/logout" class="btn btn-outline" style="padding: 0.5rem 1rem;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <h2 class="text-primary">System Administration</h2>
        
        <div class="dashboard-grid">
            <div class="stat-card" style="cursor:pointer;" onclick="window.location.href='/admin/doctors'">
                <i class="fas fa-user-md"></i>
                <h3>${doctorCount}</h3>
                <p>Manage Doctors</p>
            </div>
            <div class="stat-card" style="cursor:pointer;" onclick="window.location.href='/admin/patients'">
                <i class="fas fa-users"></i>
                <h3>${patientCount}</h3>
                <p>Manage Patients</p>
            </div>
            <div class="stat-card" style="cursor:pointer;" onclick="window.location.href='/admin/vendors'">
                <i class="fas fa-store"></i>
                <h3>${vendorCount}</h3>
                <p>Manage Vendors</p>
            </div>
            <div class="stat-card" style="cursor:pointer;" onclick="window.location.href='/admin/pending-doctors'">
                <i class="fas fa-user-clock"></i>
                <h3>${pendingDoctorCount}</h3>
                <p>Pending Approvals</p>
            </div>
            <div class="stat-card" style="cursor:pointer;" onclick="window.location.href='/admin/equipment'">
                <i class="fas fa-box-open"></i>
                <h3>${equipmentRequestCount}</h3>
                <p>Equipment Requests</p>
            </div>
        </div>
    </div>
</body>
</html>
