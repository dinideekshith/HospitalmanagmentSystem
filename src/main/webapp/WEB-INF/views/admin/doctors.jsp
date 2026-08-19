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
                                        <button type="submit" class="btn btn-sm btn-outline">Restore Access</button>
                                    </form>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-success mb-1" style="display:block; text-align:center;">Active</span>
                                    <form action="/admin/revoke-access" method="post" style="display:inline;">
                                        <input type="hidden" name="id" value="${doctor.user.id}">
                                        <input type="hidden" name="returnUrl" value="/admin/doctors">
                                        <button type="submit" class="btn btn-sm btn-error">Revoke Access</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
