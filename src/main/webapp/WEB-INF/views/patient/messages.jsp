<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Communication Portal | Hospital Care</title>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .chat-layout { display: grid; grid-template-columns: 300px 1fr; height: calc(120vh - 125px); background: #F8FAFC; border-radius: 12px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .sidebar { background: white; border-right: 1px solid #E2E8F0; display: flex; flex-direction: column; }
        .sidebar-header { padding: 1.5rem; border-bottom: 1px solid #E2E8F0; }
        .contact-list { overflow-y: auto; flex: 1; }
        .contact-item { padding: 1rem 1.5rem; border-bottom: 1px solid #EDF2F7; cursor: pointer; transition: background 0.2s; }
        .contact-item:hover, .contact-item.active { background: #E6FFFA; }
        .contact-name { font-weight: 600; color: #2D3748; }
        .contact-role { font-size: 0.75rem; color: #319795; background: #E6FFFA; padding: 2px 6px; border-radius: 4px; display: inline-block; margin-top: 4px; }
        
        .chat-area { display: flex; flex-direction: column; background: #F7FAFC; }
        .chat-header { padding: 1.5rem; background: white; border-bottom: 1px solid #E2E8F0; display: flex; justify-content: space-between; align-items: center; }
        .messages-container { flex: 1; padding: 1.5rem; overflow-y: auto; display: flex; flex-direction: column; gap: 1rem; }
        
        .msg { max-width: 70%; padding: 0.75rem 1rem; border-radius: 12px; line-height: 1.4; position: relative; }
        .msg-sent { background: var(--primary-teal); color: white; align-self: flex-end; border-bottom-right-radius: 4px; }
        .msg-received { background: #E2E8F0; color: #2D3748; align-self: flex-start; border-bottom-left-radius: 4px; }
        .msg-time { font-size: 0.7rem; opacity: 0.7; margin-top: 4px; text-align: right; }
        
        .chat-input-area { padding: 1rem; background: white; border-top: 1px solid #E2E8F0; display: flex; gap: 0.5rem; }
        .chat-input { flex: 1; padding: 0.75rem 1rem; border: 1px solid #CBD5E0; border-radius: 999px; outline: none; }
        .chat-input:focus { border-color: var(--primary-teal); box-shadow: 0 0 0 3px rgba(49, 151, 149, 0.1); }
        .btn-send { background: var(--primary-teal); color: white; border: none; border-radius: 50%; width: 45px; height: 45px; display: flex; align-items: center; justify-content: center; cursor: pointer; }
        
        /* Utility */
        .empty-state { display: flex; align-items: center; justify-content: center; height: 100%; color: #A0AEC0; font-size: 1.2rem; flex-direction: column; gap: 1rem; }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="container">
            <a href="/patient/dashboard" class="nav-brand"><i class="fas fa-plus"></i> Hospital Care</a>
            <div class="nav-links">
                <a href="/patient/dashboard" class="btn btn-outline" style="border-color: rgba(255,255,255,0.5); color: white;">Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container" style="max-width: 1200px; margin-top: 2rem;">
        <h2 class="text-primary mb-2">COMMUNICATION PORTAL</h2>
        <h1 style="font-size: 2.5rem; margin-bottom: 2rem; color: #2D3748;">Chat Messages</h1>
        
        <div class="chat-layout">
            <!-- Sidebar -->
            <div class="sidebar">
                <div class="sidebar-header">
                    <h3 style="color: #4A5568; font-size: 1.2rem;">Conversations</h3>
                </div>
                <div class="contact-list">
                    <c:forEach var="contact" items="${contacts}">
                        <div class="contact-item" onclick="openChat(${contact.id}, '${contact.name}', '${contact.role}')">
                            <div class="contact-name">Dr. ${contact.name}</div>
                            <div class="contact-role">${contact.role}</div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty contacts}">
                        <div style="padding: 1.5rem; color: #A0AEC0;">No doctors available. Book an appointment first.</div>
                    </c:if>
                </div>
            </div>
            
            <!-- Chat Area -->
            <div class="chat-area" id="chat-area">
                <div class="empty-state">
                    <i class="far fa-comments" style="font-size: 4rem;"></i>
                    <p>Select a conversation to start chatting</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script>
        let currentUserId = ${user.id};
        let activeContactId = null;
        let stompClient = null;

        const socket = new SockJS('/ws-chat');
        stompClient = Stomp.over(socket);
        stompClient.connect({}, function (frame) {
            stompClient.subscribe('/topic/messages/' + currentUserId, function (messageOutput) {
                const message = JSON.parse(messageOutput.body);
                if(activeContactId && (message.sender.id == activeContactId || message.receiver.id == activeContactId)) {
                    appendMessage(message);
                }
            });
        });

        function openChat(contactId, contactName, contactRole) {
            activeContactId = contactId;
            
            const chatArea = document.getElementById('chat-area');
            chatArea.innerHTML = `
                <div class="chat-header">
                    <div>
                        <h3 style="margin: 0; color: #2D3748;">Dr. `+contactName+`</h3>
                        <span class="contact-role">`+contactRole+`</span>
                    </div>
                    <div style="display:flex; gap:0.5rem;">
                        <button onclick="requestVideoCall()" class="btn btn-outline" style="border-color: #48BB78; color: #48BB78; padding: 0.4rem 0.8rem; font-size: 0.8rem;">
                            <i class="fas fa-video"></i> Request Video Call
                        </button>
                        <button onclick="loadHistory()" class="btn btn-outline" style="border-color: #E2E8F0; color: #4A5568; padding: 0.4rem 0.8rem; font-size: 0.8rem;">
                            Refresh
                        </button>
                    </div>
                </div>
                <div class="messages-container" id="messages-container">
                    <div style="text-align:center; color:#A0AEC0;">Loading messages...</div>
                </div>
                <div class="chat-input-area">
                    <input type="text" id="chat-input" class="chat-input" placeholder="Type a message..." onkeypress="if(event.key === 'Enter') sendMessage()" />
                    <button onclick="sendMessage()" class="btn-send"><i class="fas fa-paper-plane"></i></button>
                </div>
            `;
            
            loadHistory();
        }

        function loadHistory() {
            if(!activeContactId) return;
            fetch('/api/chat/' + currentUserId + '/' + activeContactId)
                .then(res => res.json())
                .then(data => {
                    const container = document.getElementById('messages-container');
                    container.innerHTML = '';
                    data.forEach(msg => appendMessage(msg));
                    scrollToBottom();
                });
        }

        function appendMessage(message) {
            const container = document.getElementById('messages-container');
            if(!container) return;
            
            const isSentByMe = (message.sender.id == currentUserId);
            
            const msgDiv = document.createElement('div');
            msgDiv.className = 'msg ' + (isSentByMe ? 'msg-sent' : 'msg-received');
            
            let content = message.content;
            if(content.includes('meet.google.com')) {
                const urlRegex = /(https?:\/\/[^\s]+)/g;
                content = content.replace(urlRegex, function(url) {
                    return '<a href="' + url + '" target="_blank" style="color: inherit; text-decoration: underline; font-weight: bold;">' + url + '</a>';
                });
            }
            
            msgDiv.innerHTML = `
                <div>` + content + `</div>
                <div class="msg-time">` + formatTime(message.timestamp) + `</div>
            `;
            
            container.appendChild(msgDiv);
            scrollToBottom();
        }
        
        function scrollToBottom() {
            const container = document.getElementById('messages-container');
            if(container) {
                container.scrollTop = container.scrollHeight;
            }
        }

        function sendMessage() {
            const input = document.getElementById('chat-input');
            const content = input.value.trim();
            if(content && stompClient && activeContactId) {
                stompClient.send("/app/chat.sendMessage", {}, JSON.stringify({
                    senderId: currentUserId,
                    receiverId: activeContactId,
                    content: content
                }));
                input.value = '';
            }
        }
        
        function requestVideoCall() {
            const content = "[SYSTEM] The patient has requested a video consultation. Please send a Google Meet link if you are available.";
            if(stompClient && activeContactId) {
                stompClient.send("/app/chat.sendMessage", {}, JSON.stringify({
                    senderId: currentUserId,
                    receiverId: activeContactId,
                    content: content
                }));
            }
        }

        function formatTime(timestampStr) {
            if(!timestampStr) return '';
            const date = new Date(timestampStr);
            return date.toLocaleTimeString([], {hour: '2-digit', minute:'2-digit'});
        }
    </script>
</body>
</html>
