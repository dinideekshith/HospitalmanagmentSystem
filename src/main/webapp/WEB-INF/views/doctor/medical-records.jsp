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
                    <span style="font-size: 1.8rem;">📋</span> Patient Medical Records
                </h2>
                <p class="text-secondary mt-1">View and manage clinical records for your patients.</p>
            </div>
            <div style="display: flex; gap: 1rem;">
                <a href="/doctor/dashboard" class="btn btn-outline">&larr; Dashboard</a>
            </div>
        </div>
        
        <div style="display: grid; gap: 1.5rem; max-width: 900px;">
            <c:choose>
                <c:when test="${empty records}">
                    <div class="form-card text-center" style="padding: 3rem;">
                        <i class="fas fa-folder-open text-secondary" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                        <h3 class="text-secondary">No Records Found</h3>
                        <p class="mt-1">You haven't created any medical records yet.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="rec" items="${records}">
                        <div class="form-card" style="padding: 1.5rem;">
                            <div style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid var(--border-color); padding-bottom: 1rem; margin-bottom: 1rem;">
                                <div style="display: flex; align-items: center; gap: 1rem;">
                                    <div class="avatar" style="width: 48px; height: 48px; background: #E8F4F4; color: var(--primary-teal); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 1.2rem;">
                                        <c:out value="${rec.patient.name.substring(0,1).toUpperCase()}" />
                                    </div>
                                    <div>
                                        <h3 style="font-size: 1.1rem; color: var(--text-primary);">${rec.patient.name}</h3>
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
                                <c:if test="${not empty rec.doctorNotes}">
                                    <div class="info-item" style="grid-column: 1 / -1; border-top: 1px solid var(--border-color); padding-top: 1rem; margin-top: 0.5rem;">
                                        <label><i class="fas fa-user-md"></i> Doctor's Notes (Private)</label>
                                        <span style="color: var(--text-secondary); font-style: italic; display: block; margin-top: 0.5rem;">${rec.doctorNotes}</span>
                                    </div>
                                </c:if>
                            </div>
                            
                            <div style="display: flex; justify-content: flex-end; gap: 1rem;">
                                <a href="/doctor/download-record?id=${rec.id}" class="btn btn-outline" style="font-size: 0.85rem; color: #E53E3E; border-color: #E53E3E;"><i class="fas fa-file-pdf"></i> Download PDF</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
