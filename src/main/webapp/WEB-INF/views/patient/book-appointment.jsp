<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Appointment - HMS</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/patient/dashboard" class="nav-brand"><i class="fas fa-heartbeat"></i> Patient Portal</a>
            <div class="nav-links">
                <a href="/patient/dashboard" class="btn btn-outline" style="padding: 0.5rem 1rem;">Dashboard</a>
                <a href="/logout" class="btn btn-outline" style="padding: 0.5rem 1rem; margin-left: 10px;">Logout</a>
            </div>
        </div>
    </nav>

    <div class="container dashboard-wrapper">
        <h2 class="text-primary">Book an Appointment</h2>
        
        <div class="auth-card" style="margin: 2rem auto; max-width: 600px; padding: 2rem;">
            <form action="/patient/book-appointment" method="post">
                <div class="form-group">
                    <label>Select Doctor</label>
                    <select name="doctorId" class="form-control" required>
                        <option value="">-- Choose a Doctor --</option>
                        <c:forEach var="doc" items="${doctors}">
                            <option value="${doc.userId}">Dr. ${doc.user.name} - ${doc.specialization} (Avail: ${doc.availabilitySchedule != null ? doc.availabilitySchedule : 'Not specified'})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Preferred Date</label>
                    <input type="date" name="appointmentDate" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Preferred Time</label>
                    <input type="time" name="appointmentTime" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Request Appointment</button>
            </form>
        </div>
    </div>
</body>
</html>
