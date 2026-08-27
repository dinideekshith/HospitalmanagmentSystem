<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Medical Record | Hospital Care</title>
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
                <i class="fas fa-notes-medical" style="background: #FFF; padding: 12px; border-radius: 8px; box-shadow: var(--shadow-sm);"></i>
                <div>
                    <h2 class="text-primary" style="font-size: 1.5rem; margin-bottom: 0.2rem;">Add Medical Record</h2>
                    <p class="text-secondary" style="font-size: 0.9rem;">Add diagnosis, treatment and other medical information for your patient.</p>
                </div>
            </div>
            
            <form action="/doctor/add-medical-record" method="post">
                <div class="info-block">
                    <div class="info-item">
                        <label>Patient Name</label>
                        <span>${patientUser.name}</span>
                        <input type="hidden" name="patientId" value="${patientUser.id}">
                    </div>
                    <div class="info-item">
                        <label>Patient Email</label>
                        <span>${patientUser.email}</span>
                    </div>
                    <div class="info-item">
                        <label>Doctor</label>
                        <span>Dr. ${doctorUser.name}</span>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group mb-0">
                        <label>Diagnosis</label>
                        <input type="text" name="diagnosis" class="form-control" placeholder="Enter diagnosis" required>
                    </div>
                    <div class="form-group mb-0">
                        <label>Record Date</label>
                        <input type="date" name="recordDate" class="form-control" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Symptoms</label>
                    <textarea name="symptoms" class="form-control" placeholder="Enter patient's symptoms" required></textarea>
                </div>

                <div class="form-group">
                    <label>Treatment</label>
                    <textarea name="treatment" class="form-control" placeholder="Enter treatment / medicines / advice" required></textarea>
                </div>

                <div class="form-group">
                    <label>Doctor Notes</label>
                    <textarea name="doctorNotes" class="form-control" placeholder="Enter additional notes or instructions"></textarea>
                </div>

                <div style="display: flex; justify-content: flex-end; gap: 1rem; margin-top: 2rem;">
                    <a href="/doctor/medical-records" class="btn btn-outline">Cancel</a>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Record</button>
                </div>
            </form>
        </div>
    </div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const now = new Date();
        const year = now.getFullYear();
        const month = String(now.getMonth() + 1).padStart(2, '0');
        const day = String(now.getDate()).padStart(2, '0');
        const today = year + '-' + month + '-' + day;
        document.querySelectorAll('input[type="date"]').forEach(function(input) {
            if (!input.hasAttribute('min') || input.getAttribute('min') < today) {
                input.setAttribute('min', today);
            }
        });
    });
</script>
</body>
</html>



