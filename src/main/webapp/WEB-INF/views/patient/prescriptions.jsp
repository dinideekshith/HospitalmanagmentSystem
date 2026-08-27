<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Prescriptions | Hospital Care</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .prescription-grid { display: grid; gap: 1.5rem; max-width: 1000px; margin-top: 2rem; }
        .prescription-card { background: white; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border: 1px solid #E2E8F0; overflow: hidden; }
        .p-header { background: #F7FAFC; padding: 1.5rem; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #E2E8F0; }
        .p-body { padding: 2rem 1.5rem; }
        
        .medicine-title { font-size: 1.4rem; color: #2D3748; font-weight: bold; margin-bottom: 1.5rem; display: flex; align-items: center; gap: 0.5rem; }
        .medicine-title i { color: var(--primary-teal); }
        
        .dosage-visual { display: flex; justify-content: space-around; background: #F0F6F6; padding: 1.5rem; border-radius: 12px; margin-bottom: 1.5rem; }
        .time-block { text-align: center; }
        .time-icon { font-size: 2rem; margin-bottom: 0.5rem; }
        .time-label { font-size: 0.85rem; color: #718096; font-weight: bold; text-transform: uppercase; letter-spacing: 1px; }
        .dosage-count { font-size: 1.5rem; font-weight: bold; color: var(--primary-teal); margin-top: 0.5rem; background: white; width: 40px; height: 40px; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin-left: auto; margin-right: auto; box-shadow: 0 2px 4px rgba(0,0,0,0.05); }
        
        .instructions-box { border-left: 4px solid var(--primary-teal); padding-left: 1rem; background: white; }
        .instructions-label { font-size: 0.85rem; color: #718096; font-weight: bold; text-transform: uppercase; margin-bottom: 0.25rem; }
        .instructions-text { font-size: 1.1rem; color: #2D3748; }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/patient/dashboard" class="nav-brand"><i class="fas fa-plus"></i> Hospital Care</a>
            <div class="nav-links">
                <a href="/patient/dashboard" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">&larr; Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="dashboard-header">
            <h2 class="text-primary"><i class="fas fa-pills"></i> My Visual Prescriptions</h2>
            <p class="text-secondary">Easy-to-understand visual guides on how and when to take your medicines.</p>
        </div>
        
        <div class="prescription-grid">
            <c:forEach var="p" items="${prescriptions}">
                <div class="prescription-card">
                    <div class="p-header">
                        <div>
                            <div style="font-weight: bold; color: #2D3748; font-size: 1.1rem;">Dr. ${p.doctor.name}</div>
                            <div style="color: #718096; font-size: 0.9rem;">Prescribed on: ${p.prescriptionDate}</div>
                        </div>
                        <div style="display: flex; gap: 1rem; align-items: center;">
                            <span class="badge ${p.status == 'PENDING' ? 'badge-warning' : 'badge-success'}">${p.status}</span>
                            <a href="/patient/download-prescription?id=${p.id}" class="btn btn-sm btn-outline" style="color: #E53E3E; border-color: #E53E3E;"><i class="fas fa-file-pdf"></i> Download PDF</a>
                        </div>
                    </div>
                    
                    <div class="p-body">
                        <div class="medicine-title">
                            <i class="fas fa-capsules"></i> ${p.medicineName}
                        </div>
                        
                        <div style="margin-bottom: 1rem; color: #4A5568;">
                            <strong>Duration:</strong> ${p.duration}
                        </div>
                        
                        <div class="dosage-visual">
                            <!-- We use a little JS trick in the JSP to parse dosage strings like 1-0-1 or 1-1-1 -->
                            <c:set var="m" value="1" />
                            <c:set var="a" value="0" />
                            <c:set var="n" value="1" />
                            <!-- Basic assumption parsing if it has dashes -->
                            <c:if test="${p.dosage.contains('-')}">
                                <c:set var="m" value="${p.dosage.split('-')[0]}" />
                                <c:set var="a" value="${p.dosage.split('-')[1]}" />
                                <c:set var="n" value="${p.dosage.split('-')[2]}" />
                            </c:if>
                            
                            <div class="time-block" style="opacity: ${m == '0' ? '0.4' : '1'}">
                                <div class="time-icon">🌅</div>
                                <div class="time-label">Morning</div>
                                <div class="dosage-count">${m}</div>
                            </div>
                            
                            <div class="time-block" style="opacity: ${a == '0' ? '0.4' : '1'}">
                                <div class="time-icon">☀️</div>
                                <div class="time-label">Afternoon</div>
                                <div class="dosage-count">${a}</div>
                            </div>
                            
                            <div class="time-block" style="opacity: ${n == '0' ? '0.4' : '1'}">
                                <div class="time-icon">🌙</div>
                                <div class="time-label">Night</div>
                                <div class="dosage-count">${n}</div>
                            </div>
                        </div>
                        
                        <div class="instructions-box">
                            <div class="instructions-label">Doctor's Instructions</div>
                            <div class="instructions-text">${p.instructions}</div>
                            <c:if test="${empty p.instructions || p.instructions == ''}">
                                <div class="instructions-text" style="color: #A0AEC0; font-style: italic;">No specific instructions provided.</div>
                            </c:if>
                            <c:if test="${not p.dosage.contains('-')}">
                                <div style="margin-top: 0.5rem; font-size: 0.9rem; color: #E53E3E;">
                                    <strong>Raw Dosage String:</strong> ${p.dosage}
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty prescriptions}">
                <div class="form-card text-center" style="padding: 3rem;">
                    <i class="fas fa-prescription-bottle text-secondary" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                    <h3 class="text-secondary">No Prescriptions Found</h3>
                    <p class="mt-1">You don't have any active prescriptions.</p>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>
