<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Prescription | Hospital Care</title>
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
                <span style="font-weight: 500; font-size: 0.9rem;">Doctor Panel</span>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="form-card">
            <div class="form-header">
                <i class="fas fa-pills" style="background: #FFF; padding: 12px; border-radius: 8px; box-shadow: var(--shadow-sm);"></i>
                <div>
                    <h2 class="text-primary" style="font-size: 1.5rem; margin-bottom: 0.2rem;">Create Prescription</h2>
                    <p class="text-secondary" style="font-size: 0.9rem;">Write a new medical prescription for your patient.</p>
                </div>
            </div>
            
            <form action="/doctor/add-prescription" method="post">
                <div class="form-group">
                    <label>Patient</label>
                    <select name="patientId" class="form-control" required>
                        <option value="">Select a Patient</option>
                        <c:forEach var="pat" items="${patients}">
                            <option value="${pat.id}">${pat.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-row">
                    <div class="form-group mb-0">
                        <label>Medicine Name</label>
                        <input type="text" name="medicineName" class="form-control" placeholder="e.g. Amoxicillin" required>
                    </div>
                    <div class="form-group mb-0">
                        <label>Dosage</label>
                        <input type="text" name="dosage" class="form-control" placeholder="e.g. 500mg, twice daily" required>
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group mb-0">
                        <label>Duration</label>
                        <input type="text" name="duration" class="form-control" placeholder="e.g. 7 days" required>
                    </div>
                    <div class="form-group mb-0">
                        <label>Date</label>
                        <input type="date" name="prescriptionDate" class="form-control" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Instructions (For Patient/Pharmacy)</label>
                    <textarea name="instructions" class="form-control" placeholder="Enter instructions for taking the medicine or pharmacy notes..." required></textarea>
                </div>

                <div style="display: flex; justify-content: flex-end; gap: 1rem; margin-top: 2rem;">
                    <a href="/doctor/prescriptions" class="btn btn-outline">Cancel</a>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-check"></i> Create Prescription</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
