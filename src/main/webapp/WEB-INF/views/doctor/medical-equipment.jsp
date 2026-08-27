<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Request Equipment | Hospital Care</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/doctor/dashboard" class="nav-brand"><i class="fas fa-plus"></i> Hospital Care</a>
            <div class="nav-links">
                <a href="/doctor/dashboard" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">&larr; Back</a>
            </div>
        </div>
    </nav>
    <div class="container dashboard-wrapper">
        <div class="form-card" style="max-width: 600px; margin: 2rem auto;">
            <div class="form-header">
                <i class="fas fa-stethoscope" style="background: #FFF; padding: 12px; border-radius: 8px; box-shadow: var(--shadow-sm);"></i>
                <div>
                    <h2 class="text-primary" style="font-size: 1.5rem; margin-bottom: 0.2rem;">Request Medical Equipment</h2>
                    <p class="text-secondary" style="font-size: 0.9rem;">Submit a request for hospital equipment and supplies.</p>
                </div>
            </div>
            <form action="/doctor/medical-equipment" method="post">
                <div class="form-group">
                    <label>Equipment Name</label>
                    <input type="text" name="equipmentName" class="form-control" required placeholder="e.g. Surgical Gloves, Scalpels">
                </div>
                <div class="form-group">
                    <label>Quantity Needed</label>
                    <input type="number" name="quantity" class="form-control" required min="1">
                </div>
                <div class="form-group">
                    <label>Request Date</label>
                    <input type="date" name="requestDate" class="form-control" required>
                </div>
                <div style="display: flex; justify-content: flex-end; gap: 1rem; margin-top: 2rem;">
                    <a href="/doctor/dashboard" class="btn btn-outline">Cancel</a>
                    <button type="submit" class="btn btn-primary">Submit Request</button>
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



