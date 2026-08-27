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
            <c:if test="${not empty error}">
                <div class="alert alert-error" style="color: red; margin-bottom: 15px; text-align: center;">${error}</div>
            </c:if>
            <form action="/patient/book-appointment" method="post" enctype="multipart/form-data">
                <div class="form-group">
                    <label>Select Doctor</label>
                    <select name="doctorId" id="doctorId" class="form-control" required>
                        <option value="">-- Choose a Doctor --</option>
                        <c:forEach var="doc" items="${doctors}">
                            <option value="${doc.userId}">Dr. ${doc.user.name} - ${doc.specialization} (Avail: ${doc.availabilitySchedule != null ? doc.availabilitySchedule : 'Not specified'})</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Preferred Date</label>
                    <input type="date" name="appointmentDate" id="appointmentDate" class="form-control" required>
                </div>
                <div class="form-group">
                    <label>Preferred Time</label>
                    <select name="appointmentTime" id="appointmentTime" class="form-control" required disabled>
                        <option value="">-- Select Date & Doctor First --</option>
                    </select>
                </div>
                
                <div class="form-group" style="margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid #E2E8F0;">
                    <label style="color: var(--primary-teal);"><i class="fas fa-file-upload"></i> Upload Past Prescription / Medical Records (Optional)</label>
                    <p style="font-size: 0.85rem; color: #718096; margin-bottom: 0.5rem;">Help your new doctor understand your medical history by uploading previous records.</p>
                    <input type="file" name="document" class="form-control" accept=".pdf,.png,.jpg,.jpeg">
                </div>
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem;">Request Appointment</button>
            </form>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const dateInput = document.getElementById('appointmentDate');
            const doctorSelect = document.getElementById('doctorId');
            const timeSelect = document.getElementById('appointmentTime');
            
            // Set minimum date to today (using local timezone, not UTC)
            const now = new Date();
            const year = now.getFullYear();
            const month = String(now.getMonth() + 1).padStart(2, '0');
            const day = String(now.getDate()).padStart(2, '0');
            const today = year + '-' + month + '-' + day;
            dateInput.setAttribute('min', today);
            
            function fetchAvailableSlots() {
                const doctorId = doctorSelect.value;
                const date = dateInput.value;
                
                if (doctorId && date) {
                    timeSelect.innerHTML = '<option value="">-- Loading available slots... --</option>';
                    timeSelect.disabled = true;
                    
                    fetch('/patient/available-slots?doctorId=' + doctorId + '&date=' + date)
                        .then(response => response.json())
                        .then(slots => {
                            timeSelect.innerHTML = '<option value="">-- Choose a Time Slot --</option>';
                            if (slots.length === 0) {
                                timeSelect.innerHTML = '<option value="">-- No slots available --</option>';
                                timeSelect.disabled = true;
                            } else {
                                slots.forEach(slot => {
                                    const option = document.createElement('option');
                                    option.value = slot;
                                    option.textContent = slot;
                                    timeSelect.appendChild(option);
                                });
                                timeSelect.disabled = false;
                            }
                        })
                        .catch(err => {
                            console.error('Error fetching slots:', err);
                            timeSelect.innerHTML = '<option value="">-- Error loading slots --</option>';
                        });
                } else {
                    timeSelect.innerHTML = '<option value="">-- Select Date & Doctor First --</option>';
                    timeSelect.disabled = true;
                }
            }
            
            dateInput.addEventListener('change', fetchAvailableSlots);
            doctorSelect.addEventListener('change', fetchAvailableSlots);
        });
    </script>
</body>
</html>
