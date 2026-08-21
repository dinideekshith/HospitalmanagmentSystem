<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Blood Bank Management - HMS</title>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
    <div class="container dashboard-wrapper">
        <h2 class="text-primary">Blood Bank Inventory</h2>
        
        <form action="/admin/blood-bank/update" method="POST" style="margin-bottom: 20px;">
            <input type="text" name="bloodGroup" placeholder="Blood Group (e.g., A+)" required>
            <input type="number" name="units" placeholder="Units to add" required>
            <button type="submit" class="btn btn-primary">Update Stock</button>
        </form>

        <table class="table">
            <thead>
                <tr>
                    <th>Blood Group</th>
                    <th>Available Units</th>
                    <th>Last Updated</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${inventory}">
                    <tr>
                        <td>${item.bloodGroup}</td>
                        <td>${item.unitsAvailable}</td>
                        <td>${item.lastUpdated}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <h2 class="text-primary" style="margin-top:40px;">Blood Requests</h2>
        <table class="table">
            <thead>
                <tr>
                    <th>Doctor</th>
                    <th>Patient</th>
                    <th>Group</th>
                    <th>Units</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="req" items="${requests}">
                    <tr>
                        <td>${req.doctor.user.name}</td>
                        <td>${req.patient.user.name}</td>
                        <td>${req.bloodGroup}</td>
                        <td>${req.unitsRequested}</td>
                        <td>${req.status}</td>
                        <td>
                            <c:if test="${req.status == 'PENDING'}">
                                <form action="/admin/blood-bank/process-request" method="POST" style="display:inline;">
                                    <input type="hidden" name="requestId" value="${req.id}">
                                    <input type="hidden" name="action" value="APPROVE">
                                    <button type="submit" class="btn btn-success">Approve</button>
                                </form>
                                <form action="/admin/blood-bank/process-request" method="POST" style="display:inline;">
                                    <input type="hidden" name="requestId" value="${req.id}">
                                    <input type="hidden" name="action" value="REJECT">
                                    <button type="submit" class="btn btn-danger">Reject</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
