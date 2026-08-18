<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Medical Records | Hospital Care</title>
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
            <h2 class="text-primary"><i class="fas fa-clipboard-list"></i> Medical Records</h2>
            <p class="text-secondary">Access your medical history and hospital records.</p>
        </div>
        
        <div style="display: grid; gap: 1.5rem; max-width: 900px; margin-top: 1.5rem;">
            <c:choose>
                <c:when test="${empty medicalRecords}">
                    <div class="form-card text-center" style="padding: 3rem;">
                        <i class="fas fa-folder-open text-secondary" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                        <h3 class="text-secondary">No Records Found</h3>
                        <p class="mt-1">You don't have any medical records yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="rec" items="${medicalRecords}">
                        <div class="form-card" style="padding: 1.5rem;">
                            <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 1rem;">
                                <div style="display: flex; align-items: center; gap: 1rem;">
                                    <div class="avatar" style="width: 48px; height: 48px; background: #E8F4F4; color: var(--primary-teal); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1.2rem;">
                                        <i class="fas fa-stethoscope"></i>
                                    </div>
                                    <div>
                                        <h3 style="font-size: 1.1rem; color: var(--text-primary);">Dr. ${rec.doctor.name}</h3>
                                        <span class="badge badge-primary">ID: #${rec.id}</span>
                                    </div>
                                </div>
                                <div style="text-align: right;">
                                    <div style="font-weight: 600; color: var(--text-primary);">${rec.recordDate}</div>
                                    <div style="font-size: 0.85rem; color: var(--text-secondary);">Record Date</div>
                                </div>
                            </div>
                            
                            <div style="margin-bottom: 1.5rem;">
                                <h4 style="color: var(--primary-teal); font-size: 1rem; margin-bottom: 0.5rem;">Diagnosis</h4>
                                <p style="font-size: 1.1rem; font-weight: 500; color: var(--text-primary);">${rec.diagnosis}</p>
                            </div>
                            
                            <div class="info-block" style="background: #F8FAFC; padding: 1.5rem; margin-bottom: 1.5rem;">
                                <div class="info-item" style="grid-column: 1 / -1;">
                                    <label><i class="fas fa-temperature-high"></i> Symptoms</label>
                                    <span style="color: var(--text-primary); font-weight: normal; display: block; margin-top: 0.5rem;">${rec.symptoms}</span>
                                </div>
                                <div class="info-item" style="grid-column: 1 / -1; border-top: 1px solid var(--border-color); padding-top: 1rem; margin-top: 0.5rem;">
                                    <label><i class="fas fa-procedures"></i> Treatment</label>
                                    <span style="color: var(--text-primary); font-weight: normal; display: block; margin-top: 0.5rem;">${rec.treatment}</span>
                                </div>
                            </div>
                            
                            <div style="display: flex; justify-content: flex-end; gap: 1rem;">
                                <a href="/patient/download-record?id=${rec.id}" class="btn btn-outline" style="font-size: 0.85rem; color: #E53E3E; border-color: #E53E3E;"><i class="fas fa-file-pdf"></i> Download PDF</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
