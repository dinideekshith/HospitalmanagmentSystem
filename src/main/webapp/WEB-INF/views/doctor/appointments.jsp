<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctor Appointments | Hospital Care</title>
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
        <h2 class="text-primary mb-2">My Appointments</h2>
        <div class="form-card" style="padding: 0; overflow: hidden;">
            <table class="data-table" style="margin-top: 0; box-shadow: none;">
                <thead>
                    <tr><th>Patient Name</th><th>Date & Time</th><th>Status</th><th>Action</th></tr>
                </thead>
                <tbody>
                    <c:forEach var="app" items="${appointments}">
                        <tr>
                            <td><span style="font-weight: 500;">${app.patient.name}</span></td>
                            <td>${app.appointmentDate} <br><span style="font-size: 0.8rem; color: var(--text-secondary);">${app.appointmentTime}</span></td>
                            <td><span class="badge ${app.status == 'PENDING' ? 'badge-warning' : (app.status == 'REJECTED' ? 'badge-error' : 'badge-success')}">${app.status}</span></td>
                            <td>
                                <a href="/doctor/appointment/view/${app.id}" class="btn btn-sm btn-outline" style="padding: 0.3rem 0.6rem; font-size: 0.8rem; margin-right: 0.5rem; color:#4299E1; border-color:#4299E1;"><i class="fas fa-eye"></i> View Profile</a>
                                <c:if test="${app.status == 'PENDING'}">
                                    <a href="/doctor/appointment/accept/${app.id}" class="btn btn-sm btn-primary" style="padding: 0.3rem 0.6rem; font-size: 0.8rem; margin-right: 0.5rem;">Confirm</a>
                                    <a href="/doctor/appointment/reject/${app.id}" class="btn btn-sm btn-outline" style="padding: 0.3rem 0.6rem; font-size: 0.8rem; border-color: #F56565; color: #F56565;">Reject</a>
                                </c:if>
                                <c:if test="${app.status == 'VIDEO_REQUESTED'}">
                                    <a href="/doctor/appointment/approve-video/${app.id}" class="btn btn-sm btn-primary" style="padding: 0.3rem 0.6rem; font-size: 0.8rem;">Approve Video Request</a>
                                </c:if>
                                <c:if test="${app.status == 'VIDEO_APPROVED'}">
                                    <button class="btn btn-success" style="font-size: 0.8rem; padding: 0.3rem 0.6rem;" onclick="joinVideoConsult('${app.meetUrl}', ${app.id}, ${user.id})">Start Video & Chat</button>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty appointments}"><tr><td colspan="4" class="text-center">No appointments found.</td></tr></c:if>
                </tbody>
            </table>
        </div>
        
        <!-- Jitsi and Chat Container -->
        <div id="telemedicine-container" style="display:none; margin-top:2rem; grid-template-columns: 2fr 1fr; gap: 1rem;">
            <div id="jitsi-container" style="height: 500px; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.1);"></div>
            <div class="chat-container" style="display:flex; flex-direction:column; border: 1px solid #E2E8F0; border-radius: 12px; height: 500px; background: white;">
                <div style="padding: 1rem; background: var(--primary-teal); color: white; border-radius: 12px 12px 0 0;">
                    <h4 style="margin: 0;"><i class="fas fa-comments"></i> Consultation Chat</h4>
                </div>
                <div id="chat-messages" style="flex: 1; padding: 1rem; overflow-y: auto; display:flex; flex-direction:column; gap:0.5rem; background: #F7FAFC;"></div>
                <div style="padding: 1rem; border-top: 1px solid #E2E8F0; display:flex;">
                    <input type="text" id="chat-input" placeholder="Type a message..." style="flex:1; padding:0.5rem; border: 1px solid #CBD5E0; border-radius: 4px;" />
                    <button onclick="sendChatMessage()" class="btn btn-primary" style="margin-left: 0.5rem;"><i class="fas fa-paper-plane"></i></button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Scripts for Telemedicine -->
    <script src="https://meet.jit.si/external_api.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script>
        let currentAppointmentId = null;
        let currentUserId = null;
        let stompClient = null;

        function joinVideoConsult(meetUrl, appointmentId, userId) {
            document.getElementById('telemedicine-container').style.display = 'grid';
            
            const domain = 'meet.jit.si';
            const options = {
                roomName: meetUrl,
                parentNode: document.querySelector('#jitsi-container'),
                userInfo: { displayName: 'Dr. ${user.name}' }
            };
            const api = new JitsiMeetExternalAPI(domain, options);
            
            currentAppointmentId = appointmentId;
            currentUserId = userId;
            
            const socket = new SockJS('/ws-chat');
            stompClient = Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                stompClient.subscribe('/topic/appointment/' + appointmentId, function (message) {
                    showChatMessage(JSON.parse(message.body));
                });
                fetch('/api/chat/' + appointmentId)
                    .then(res => res.json())
                    .then(data => { data.forEach(msg => showChatMessage(msg)); });
            });
        }
        
        function sendChatMessage() {
            const input = document.getElementById('chat-input');
            const content = input.value.trim();
            if(content && stompClient) {
                stompClient.send("/app/chat.sendMessage", {}, JSON.stringify({
                    appointmentId: currentAppointmentId,
                    senderId: currentUserId,
                    content: content
                }));
                input.value = '';
            }
        }
        
        function showChatMessage(message) {
            const chatDiv = document.getElementById('chat-messages');
            const msgElem = document.createElement('div');
            msgElem.style.padding = '0.5rem 1rem';
            msgElem.style.borderRadius = '1rem';
            msgElem.style.maxWidth = '80%';
            if(message.sender.id == currentUserId) {
                msgElem.style.background = 'var(--primary-teal)';
                msgElem.style.color = 'white';
                msgElem.style.alignSelf = 'flex-end';
            } else {
                msgElem.style.background = '#E2E8F0';
                msgElem.style.color = '#2D3748';
                msgElem.style.alignSelf = 'flex-start';
            }
            msgElem.innerHTML = '<strong>' + message.sender.name + ':</strong> ' + message.content;
            chatDiv.appendChild(msgElem);
            chatDiv.scrollTop = chatDiv.scrollHeight;
        }
    </script>
    </div>
</body>
</html>
