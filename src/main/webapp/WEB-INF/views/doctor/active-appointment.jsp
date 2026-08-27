<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Active Appointment | Hospital Care</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/doctor/dashboard" class="nav-brand"><i class="fas fa-plus"></i> Hospital Care</a>
            <div class="nav-links">
                <a href="/doctor/appointments" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">&larr; Back</a>
            </div>
        </div>
    </nav>
    <div class="container dashboard-wrapper">
        <h2 class="text-primary mb-2">Patient Profile: ${appointment.patient.name}</h2>
        <div class="card" style="margin-bottom: 2rem;">
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                <div>
                    <p><strong>Email:</strong> ${appointment.patient.email}</p>
                    <p><strong>Mobile:</strong> ${appointment.patient.mobileNumber}</p>
                    <p><strong>Gender:</strong> ${patientProfile.gender}</p>
                </div>
                <div>
                    <p><strong>Blood Group:</strong> <span style="color: #E53E3E; font-weight: bold;">${patientProfile.bloodGroup}</span></p>
                    <p><strong>Date of Birth:</strong> ${patientProfile.dateOfBirth}</p>
                    <p><strong>Address:</strong> ${patientProfile.address}</p>
                </div>
            </div>
            
            <c:if test="${not empty appointment.documentUrl}">
                <div style="margin-top: 1rem; padding-top: 1rem; border-top: 1px solid #E2E8F0;">
                    <h4 style="color: #4A5568; margin-bottom: 0.5rem;"><i class="fas fa-file-medical"></i> Patient Uploaded Document</h4>
                    <a href="${appointment.documentUrl}" target="_blank" class="btn btn-outline" style="border-color: #319795; color: #319795;"><i class="fas fa-download"></i> View / Download Document</a>
                </div>
            </c:if>
        </div>

        <h3 class="text-primary mb-2">Past Consultations & Medical Records</h3>
        <div class="form-card" style="padding: 0; overflow: hidden; margin-bottom: 2rem;">
            <table class="data-table" style="margin-top: 0; box-shadow: none;">
                <thead>
                    <tr><th>Date</th><th>Diagnosis</th><th>Treatment</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="rec" items="${pastRecords}">
                        <tr>
                            <td>${rec.recordDate}</td>
                            <td>${rec.diagnosis}</td>
                            <td>${rec.treatment}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pastRecords}"><tr><td colspan="3" class="text-center">No past records found.</td></tr></c:if>
                </tbody>
            </table>
        </div>

        <h3 class="text-primary mb-2">Past Prescriptions</h3>
        <div class="form-card" style="padding: 0; overflow: hidden; margin-bottom: 2rem;">
            <table class="data-table" style="margin-top: 0; box-shadow: none;">
                <thead>
                    <tr><th>Date</th><th>Medicines</th><th>Instructions</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="pres" items="${pastPrescriptions}">
                        <tr>
                            <td>${pres.prescriptionDate}</td>
                            <td>${pres.medicineName}</td>
                            <td>${pres.instructions}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pastPrescriptions}"><tr><td colspan="3" class="text-center">No past prescriptions found.</td></tr></c:if>
                </tbody>
            </table>
        </div>
        
        <div style="display:flex; gap:1rem;">
            <a href="/doctor/add-prescription?patientId=${appointment.patient.id}" class="btn btn-primary"><i class="fas fa-pills"></i> Add New Prescription</a>
            <a href="/doctor/add-medical-record?patientId=${appointment.patient.id}" class="btn btn-primary"><i class="fas fa-notes-medical"></i> Add New Record</a>
        </div>
    </div>
</body>
</html>
