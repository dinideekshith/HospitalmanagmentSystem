<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Request Lab Test | Hospital Care</title>
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
                    <div>
                        <div style="font-weight: 600;">Dr. ${user.name.split(' ')[0]}</div>
                        <div style="font-size: 0.75rem; color: rgba(255,255,255,0.8);">Doctor</div>
                    </div>
                    <div class="avatar">
                        <c:out value="${user.name.substring(0,1).toUpperCase()}" />
                    </div>
                </div>
                <a href="/logout" class="btn btn-outline" style="border-color: white; color: white;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div style="max-width: 800px; margin: 0 auto; margin-bottom: 1rem;">
            <a href="/doctor/prescriptions" class="text-primary" style="text-decoration: none; font-weight: 500;">&larr; Back to Prescriptions</a>
        </div>
        
        <div class="form-card">
            <div class="form-header">
                <i class="fas fa-vial" style="background: #FFF; padding: 12px; border-radius: 8px; box-shadow: var(--shadow-sm);"></i>
                <div>
                    <h2 class="text-primary" style="font-size: 1.5rem; margin-bottom: 0.2rem;">Request Laboratory Test</h2>
                    <p class="text-secondary" style="font-size: 0.9rem;">Send a laboratory test request for your patient.</p>
                </div>
            </div>
            
            <form action="/doctor/request-lab-test" method="post">
                <div class="form-row">
                    <div class="form-group mb-0">
                        <label>Patient Name</label>
                        <select name="patientId" class="form-control" required>
                            <option value="">Select a Patient</option>
                            <c:forEach var="pat" items="${patients}">
                                <option value="${pat.id}" ${param.patientId == pat.id ? 'selected' : ''}>${pat.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group mb-0">
                        <label>Request Date</label>
                        <input type="date" name="requestDate" class="form-control" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Test Name</label>
                    <input type="text" name="testName" class="form-control" placeholder="e.g. Complete Blood Count (CBC), Lipid Panel" required>
                </div>

                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;"><i class="fas fa-paper-plane"></i> Send Laboratory Test Request</button>
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



