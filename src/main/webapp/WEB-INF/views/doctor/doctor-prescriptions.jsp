<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Prescriptions | Hospital Care</title>
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
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="dashboard-header" style="display: flex; justify-content: space-between; align-items: flex-end;">
            <div>
                <h2 class="text-primary" style="display: flex; align-items: center; gap: 10px;">
                    <span style="font-size: 1.8rem;">💊</span> My Prescriptions
                </h2>
                <p class="text-secondary mt-1">View and manage prescriptions created for your patients.</p>
            </div>
            <div style="display: flex; gap: 1rem;">
                <a href="/doctor/add-prescription" class="btn btn-primary"><i class="fas fa-plus"></i> Add Prescription</a>
                <a href="/doctor/dashboard" class="btn btn-outline">&larr; Dashboard</a>
            </div>
        </div>
        
        <div style="display: grid; gap: 1.5rem; max-width: 800px;">
            <c:choose>
                <c:when test="${empty prescriptions}">
                    <div class="form-card text-center" style="padding: 3rem;">
                        <i class="fas fa-prescription text-secondary" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                        <h3 class="text-secondary">No Prescriptions Found</h3>
                        <p class="mt-1">You haven't created any prescriptions yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="presc" items="${prescriptions}">
                        <div class="form-card" style="padding: 1.5rem;">
                            <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 1rem;">
                                <div style="display: flex; align-items: center; gap: 1rem;">
                                    <div class="avatar" style="width: 48px; height: 48px; background: #E8F4F4; color: var(--primary-teal); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1.2rem;">
                                        <c:out value="${presc.patient.name.substring(0,1).toUpperCase()}" />
                                    </div>
                                    <div>
                                        <h3 style="font-size: 1.1rem; color: var(--text-primary);">${presc.patient.name}</h3>
                                        <p style="font-size: 0.85rem; color: var(--text-secondary);">${presc.patient.email}</p>
                                    </div>
                                </div>
                                <div style="font-weight: 500; color: var(--primary-teal); font-size: 0.9rem;">
                                    ${presc.prescriptionDate}
                                </div>
                            </div>
                            
                            <div class="info-block" style="background: transparent; padding: 0; margin-bottom: 1.5rem;">
                                <div class="info-item">
                                    <label>Medicine</label>
                                    <span style="color: var(--text-primary);">${presc.medicineName}</span>
                                </div>
                                <div class="info-item">
                                    <label>Dosage</label>
                                    <span style="color: var(--text-primary);">${presc.dosage}</span>
                                </div>
                                <div class="info-item">
                                    <label>Duration</label>
                                    <span style="color: var(--text-primary);">${presc.duration}</span>
                                </div>
                                <div class="info-item">
                                    <label>Status</label>
                                    <span class="badge ${presc.status == 'PENDING' ? 'badge-warning' : 'badge-success'}">${presc.status}</span>
                                </div>
                            </div>
                            
                            <div class="info-item" style="margin-bottom: 1.5rem;">
                                <label>Instructions</label>
                                <p style="font-size: 0.95rem; color: var(--text-secondary); background: #F8FAFC; padding: 1rem; border-radius: var(--radius-sm); border: 1px solid var(--border-color);">${presc.instructions}</p>
                            </div>
                            
                            <div style="display: flex; justify-content: flex-end; gap: 1rem;">
                                <a href="/doctor/request-lab-test?patientId=${presc.patient.id}" class="btn btn-primary" style="font-size: 0.85rem;"><i class="fas fa-vial"></i> Request Lab Test</a>
                                <a href="/doctor/download-prescription?id=${presc.id}" class="btn btn-outline" style="font-size: 0.85rem; color: #E53E3E; border-color: #E53E3E;"><i class="fas fa-file-pdf"></i> Download PDF</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
