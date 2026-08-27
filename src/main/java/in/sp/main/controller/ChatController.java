package in.sp.main.controller;

import in.sp.main.entity.Appointment;
import in.sp.main.entity.ChatMessage;
import in.sp.main.entity.User;
import in.sp.main.repository.AppointmentRepository;
import in.sp.main.repository.ChatMessageRepository;
import in.sp.main.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Controller
public class ChatController {

    @Autowired
    private SimpMessageSendingOperations messagingTemplate;

    @Autowired
    private ChatMessageRepository chatMessageRepository;

    @Autowired
    private AppointmentRepository appointmentRepository;

    @Autowired
    private UserRepository userRepository;

    public static class ChatPayload {
        private Long senderId;
        private Long receiverId;
        private String content;
        
        public Long getSenderId() { return senderId; }
        public void setSenderId(Long senderId) { this.senderId = senderId; }
        public Long getReceiverId() { return receiverId; }
        public void setReceiverId(Long receiverId) { this.receiverId = receiverId; }
        public String getContent() { return content; }
        public void setContent(String content) { this.content = content; }
    }

    public static class UserDto {
        private Long id;
        private String name;
        public UserDto() {}
        public UserDto(Long id, String name) { this.id = id; this.name = name; }
        public Long getId() { return id; }
        public String getName() { return name; }
    }

    public static class ChatMessageDto {
        private Long id;
        private UserDto sender;
        private UserDto receiver;
        private String content;
        private String timestamp;
        
        public ChatMessageDto() {}
        public ChatMessageDto(ChatMessage msg) {
            this.id = msg.getId();
            if(msg.getSender() != null) this.sender = new UserDto(msg.getSender().getId(), msg.getSender().getName());
            if(msg.getReceiver() != null) this.receiver = new UserDto(msg.getReceiver().getId(), msg.getReceiver().getName());
            this.content = msg.getContent();
            this.timestamp = msg.getTimestamp() != null ? msg.getTimestamp().toString() : "";
        }
        public Long getId() { return id; }
        public UserDto getSender() { return sender; }
        public UserDto getReceiver() { return receiver; }
        public String getContent() { return content; }
        public String getTimestamp() { return timestamp; }
    }

    @MessageMapping("/chat.sendMessage")
    public void sendMessage(@Payload ChatPayload payload) {
        Long senderId = payload.getSenderId();
        Long receiverId = payload.getReceiverId();
        String content = payload.getContent();

        User sender = userRepository.findById(senderId).orElse(null);
        User receiver = userRepository.findById(receiverId).orElse(null);

        if (sender != null && receiver != null) {
            ChatMessage chatMessage = new ChatMessage();
            chatMessage.setSender(sender);
            chatMessage.setReceiver(receiver);
            chatMessage.setContent(content);
            chatMessage.setTimestamp(LocalDateTime.now());

            chatMessage = chatMessageRepository.save(chatMessage);
            ChatMessageDto dto = new ChatMessageDto(chatMessage);

            // Broadcast to the receiver's queue
            messagingTemplate.convertAndSend("/topic/messages/" + receiverId, dto);
            // Broadcast to the sender's queue
            messagingTemplate.convertAndSend("/topic/messages/" + senderId, dto);
        }
    }

    @GetMapping("/api/chat/{user1}/{user2}")
    @ResponseBody
    public List<ChatMessageDto> getChatHistory(@PathVariable Long user1, @PathVariable Long user2) {
        List<ChatMessage> messages = chatMessageRepository.findConversation(user1, user2);
        return messages.stream().map(ChatMessageDto::new).collect(java.util.stream.Collectors.toList());
    }
}
