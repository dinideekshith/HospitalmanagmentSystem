<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blood Bank | Doctor Portal</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
        .table th, .table td { padding: 1rem; text-align: left; border-bottom: 1px solid #E2E8F0; }
        .table th { background-color: #F7FAFC; font-weight: 600; color: #4A5568; }
        .badge { padding: 0.25rem 0.75rem; border-radius: 999px; font-size: 0.875rem; font-weight: 500; }
        .badge-pending { background-color: #FEFCBF; color: #975A16; }
        .badge-approved { background-color: #C6F6D5; color: #22543D; }
        .badge-rejected { background-color: #FED7D7; color: #822727; }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/doctor/dashboard" class="nav-brand">
                <i class="fas fa-plus"></i> Hospital Care
            </a>
            <div class="nav-links">
                <a href="/doctor/dashboard" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <div class="dashboard-header" style="background: darkred; color: white; padding: 2rem; border-radius: 12px; margin-bottom: 2rem;">
            <h2><i class="fas fa-tint"></i> Blood Bank Requests</h2>
            <p>Request blood units for critical patients.</p>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 2fr; gap: 2rem;">
            <div class="card" style="padding: 1.5rem; height: fit-content;">
                <h3 style="margin-bottom: 1.5rem; color: #2D3748;"><i class="fas fa-plus-circle"></i> New Request</h3>
                <form action="/doctor/blood-bank/request" method="POST">
                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Patient</label>
                        <select name="patientId" class="form-control" required style="width: 100%; padding: 0.75rem; border: 1px solid #E2E8F0; border-radius: 6px;">
                            <option value="">Select Patient</option>
                            <c:forEach items="${patients}" var="p">
                                <option value="${p.id}">${p.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Blood Group</label>
                        <select name="bloodGroup" class="form-control" required style="width: 100%; padding: 0.75rem; border: 1px solid #E2E8F0; border-radius: 6px;">
                            <option value="">Select</option>
                            <option value="A+">A+</option>
                            <option value="A-">A-</option>
                            <option value="B+">B+</option>
                            <option value="B-">B-</option>
                            <option value="O+">O+</option>
                            <option value="O-">O-</option>
                            <option value="AB+">AB+</option>
                            <option value="AB-">AB-</option>
                        </select>
                    </div>
                    
                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Units Required</label>
                        <input type="number" name="units" min="1" max="10" class="form-control" required style="width: 100%; padding: 0.75rem; border: 1px solid #E2E8F0; border-radius: 6px;">
                    </div>
                    
                    <div class="form-group" style="margin-bottom: 1.5rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Urgency</label>
                        <select name="urgency" class="form-control" required style="width: 100%; padding: 0.75rem; border: 1px solid #E2E8F0; border-radius: 6px;">
                            <option value="Routine">Routine</option>
                            <option value="Urgent">Urgent</option>
                            <option value="Critical">Critical</option>
                        </select>
                    </div>
                    
                    <button type="submit" class="btn" style="background: darkred; color: white; width: 100%;">Submit Request</button>
                </form>
            </div>
            
            <div class="card" style="padding: 1.5rem;">
                <h3 style="margin-bottom: 1.5rem; color: #2D3748;"><i class="fas fa-history"></i> My Requests</h3>
                <div style="overflow-x: auto;">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date</th>
                                <th>Patient</th>
                                <th>Blood Group</th>
                                <th>Units</th>
                                <th>Urgency</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${bloodRequests}" var="req">
                                <tr>
                                    <td>${req.requestDate}</td>
                                    <td>${req.patient.user.name}</td>
                                    <td><span style="color: darkred; font-weight: bold;">${req.bloodGroup}</span></td>
                                    <td>${req.unitsRequested}</td>
                                    <td>
                                        <span class="badge ${req.urgency == 'Critical' ? 'badge-rejected' : req.urgency == 'Urgent' ? 'badge-pending' : 'badge-approved'}">${req.urgency}</span>
                                    </td>
                                    <td>
                                        <span class="badge badge-${req.status.toLowerCase()}">${req.status}</span>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty bloodRequests}">
                                <tr>
                                    <td colspan="6" class="text-center" style="padding: 2rem; color: #A0AEC0;">No blood requests found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        
        <!-- NEW WIDGETS FOR FEATURE 3 -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 2rem; margin-top: 2rem;">
            <!-- Blood Inventory -->
            <div class="card" style="padding: 1.5rem;">
                <h3 style="margin-bottom: 1.5rem; color: #2D3748;"><i class="fas fa-boxes"></i> Live Blood Inventory</h3>
                <table class="table">
                    <thead>
                        <tr><th>Blood Group</th><th>Available Units</th></tr>
                    </thead>
                    <tbody>
                        <c:forEach var="inv" items="${bloodInventory}">
                            <tr>
                                <td><span style="font-weight:bold; color: darkred;">${inv.bloodGroup}</span></td>
                                <td>${inv.unitsAvailable}</td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty bloodInventory}"><tr><td colspan="2" class="text-center">Inventory data unavailable.</td></tr></c:if>
                    </tbody>
                </table>
            </div>
            
            <!-- Request Blood Test -->
            <div class="card" style="padding: 1.5rem; height: fit-content;">
                <h3 style="margin-bottom: 1.5rem; color: #2D3748;"><i class="fas fa-vial"></i> Request Blood Test / Sample</h3>
                <form action="/doctor/blood-bank/request-test" method="POST">
                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Patient</label>
                        <select name="patientId" class="form-control" required style="width: 100%; padding: 0.75rem; border: 1px solid #E2E8F0; border-radius: 6px;">
                            <option value="">Select Patient</option>
                            <c:forEach items="${patients}" var="p">
                                <option value="${p.id}">${p.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="form-group" style="margin-bottom: 1rem;">
                        <label style="display: block; margin-bottom: 0.5rem; font-weight: 500;">Test Details / Instructions</label>
                        <input type="text" name="testDetails" class="form-control" placeholder="e.g. CBC, Hemoglobin, Lipid Profile" required style="width: 100%; padding: 0.75rem; border: 1px solid #E2E8F0; border-radius: 6px;">
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%;">Submit Blood Test Request</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>
