<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Doctors - Admin Portal</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
        <c:if test="${not empty error}">
            <div class="alert alert-error" style="margin-bottom: 1rem;">${error}</div>
        </c:if>
        <c:if test="${not empty success}">
            <div class="alert alert-success" style="background-color: #C6F6D5; color: #22543D; padding: 1rem; border-radius: 8px; margin-bottom: 1rem; border: 1px solid #9AE6B4;">${success}</div>
        </c:if>
        <h2 class="text-primary">Registered Doctors</h2>
        <table class="data-table mt-2">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Mobile</th>
                    <th>Specialization</th>
                    <th>Experience</th>
                    <th>Status / Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="doctor" items="${doctors}">
                    <tr>
                        <td>Dr. ${doctor.user.name}</td>
                        <td>${doctor.user.email}</td>
                        <td>${doctor.user.mobileNumber}</td>
                        <td>${doctor.specialization != null ? doctor.specialization : 'Not Set'}</td>
                        <td>${doctor.experienceYears != null ? doctor.experienceYears : 0} Years</td>
                        <td>
                            <c:choose>
                                <c:when test="${doctor.user.locked}">
                                    <span class="badge badge-error mb-1" style="display:block; text-align:center;">Revoked</span>
                                    <form action="/admin/restore-access" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="${doctor.user.id}">
                                        <input type="hidden" name="returnUrl" value="/admin/doctors">
                                        <button type="submit" class="btn btn-sm btn-outline">Restore</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-success mb-1" style="display:block; text-align:center;">Active</span>
                                    <form action="/admin/revoke-access" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="${doctor.user.id}">
                                        <input type="hidden" name="returnUrl" value="/admin/doctors">
                                        <button type="submit" class="btn btn-sm btn-outline" style="border-color: #DD6B20; color: #DD6B20;">Revoke</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                            
                            <form action="/admin/delete-user" method="post" style="display:inline; margin-left: 0.5rem;" onsubmit="return confirm('WARNING: This will permanently delete the doctor and all their data from the database. Proceed?');">
                                <input type="hidden" name="id" value="${doctor.user.id}">
                                <input type="hidden" name="returnUrl" value="/admin/doctors">
                                <button type="submit" class="btn btn-sm btn-error"><i class="fas fa-trash"></i> Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
