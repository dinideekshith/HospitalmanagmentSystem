<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pharmacy & Inventory Management - Admin Portal</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .form-grid-6 {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1rem;
            align-items: end;
        }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 2.5rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/admin/dashboard" class="nav-brand"><i class="fas fa-shield-alt"></i> Admin Portal</a>
            <div class="nav-links">
                <a href="/admin/dashboard" class="btn btn-outline" style="padding: 0.5rem 1rem;">Dashboard</a>
                <a href="/logout" class="btn btn-outline" style="padding: 0.5rem 1rem; margin-left: 10px;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="dashboard-header">
            <h2 class="text-primary"><i class="fas fa-pills"></i> Pharmacy & Medicine Inventory</h2>
            <p class="text-secondary">Track drug stock levels, batch details, expiration dates, and low stock threshold alerts.</p>
        </div>

        <c:if test="${not empty param.success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> Medicine added to inventory successfully.
            </div>
        </c:if>

        <!-- Add Medicine Form Card -->
        <div class="form-card" style="max-width: 100%; margin-bottom: 2rem;">
            <div class="form-header" style="margin-bottom: 1.25rem;">
                <i class="fas fa-plus-circle"></i>
                <h3 style="margin: 0; color: var(--primary-teal); font-size: 1.15rem;">Add New Medicine Stock</h3>
            </div>
            <form action="/admin/inventory/add" method="POST">
                <div class="form-grid-6">
                    <div class="form-group" style="margin-bottom: 0;">
                        <label>Medicine Name</label>
                        <input type="text" name="name" class="form-control" placeholder="e.g. Paracetamol 500mg" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label>Batch Number</label>
                        <input type="text" name="batchNumber" class="form-control" placeholder="e.g. BATCH-2026-09" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label>Quantity</label>
                        <input type="number" name="quantity" class="form-control" placeholder="Units" min="0" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label>Min Stock Alert</label>
                        <input type="number" name="minStock" class="form-control" placeholder="Min threshold" min="0" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label>Expiry Date</label>
                        <input type="date" name="expiryDate" class="form-control" required>
                    </div>
                    <div class="form-group" style="margin-bottom: 0;">
                        <label>Price (₹)</label>
                        <input type="number" step="0.01" name="price" class="form-control" placeholder="e.g. 45.50" min="0" required>
                    </div>
                </div>
                <div style="margin-top: 1.25rem; text-align: right;">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add Medicine
                    </button>
                </div>
            </form>
        </div>

        <!-- Medicine List Table -->
        <div class="section-header" style="margin-top: 1rem;">
            <h3 class="text-primary"><i class="fas fa-boxes"></i> Medicine Stock Status</h3>
        </div>
        <table class="data-table">
            <thead>
                <tr>
                    <th>Medicine Name</th>
                    <th>Batch No</th>
                    <th>Available Stock</th>
                    <th>Min Threshold</th>
                    <th>Expiry Date</th>
                    <th>Unit Price</th>
                    <th>Status</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="m" items="${medicines}">
                    <tr>
                        <td><strong>${m.name}</strong></td>
                        <td><code>${m.batchNumber}</code></td>
                        <td>${m.quantity} Units</td>
                        <td>${m.minStock} Units</td>
                        <td>${m.expiryDate}</td>
                        <td>₹${m.price}</td>
                        <td>
                            <c:choose>
                                <c:when test="${m.quantity <= m.minStock}">
                                    <span class="badge badge-danger"><i class="fas fa-exclamation-triangle"></i> LOW STOCK</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-success"><i class="fas fa-check"></i> In Stock</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty medicines}">
                    <tr>
                        <td colspan="7" class="text-center" style="padding: 1.5rem;">No medicines currently found in inventory.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
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



