<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vendor Profile - HMS</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/vendor/dashboard" class="nav-brand"><i class="fas fa-store"></i> Vendor Portal</a>
            <div class="nav-links">
                <a href="/vendor/dashboard" class="btn btn-outline" style="padding: 0.5rem 1rem;">Dashboard</a>
                <a href="/logout" class="btn btn-outline" style="padding: 0.5rem 1rem; margin-left: 10px;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <h2 class="text-primary">Update Profile</h2>
        
        <div class="auth-card" style="margin: 2rem auto; max-width: 600px; padding: 2rem;">
            <form action="/vendor/profile" method="post">
                <div class="form-group">
                    <label>Business Name</label>
                    <input type="text" name="businessName" class="form-control" value="${vendor.businessName}" placeholder="e.g. Apollo Pharmacy" required>
                </div>
                <div class="form-group">
                    <label>Vendor Type</label>
                    <select name="vendorType" class="form-control" required>
                        <option value="Pharmacy" ${vendor.vendorType == 'Pharmacy' ? 'selected' : ''}>Pharmacy</option>
                        <option value="Diagnostic Lab" ${vendor.vendorType == 'Diagnostic Lab' ? 'selected' : ''}>Diagnostic Lab</option>
                        <option value="Surgical Supplier" ${vendor.vendorType == 'Surgical Supplier' ? 'selected' : ''}>Surgical Supplier</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>Business Address</label>
                    <textarea name="address" class="form-control" rows="3" required>${vendor.address}</textarea>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Save Profile</button>
            </form>
        </div>
    </div>
</body>
</html>
