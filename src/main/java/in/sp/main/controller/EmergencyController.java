package in.sp.main.controller;

import in.sp.main.entity.EmergencyRequest;
import in.sp.main.entity.Patient;
import in.sp.main.entity.User;
import in.sp.main.repository.EmergencyRequestRepository;
import in.sp.main.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
public class EmergencyController {

    @Autowired
    private EmergencyRequestRepository emergencyRequestRepository;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private in.sp.main.service.UserService userService;

    @PostMapping("/patient/sos/trigger")
    public String triggerSos(@AuthenticationPrincipal UserDetails userDetails) {
        User user = userService.findByEmail(userDetails.getUsername());
        Patient patient = patientRepository.findById(user.getId()).orElse(null);
        if (patient != null) {
            EmergencyRequest req = new EmergencyRequest();
            req.setPatient(patient);
            req.setPatientBloodGroup(patient.getBloodGroup());
            req.setRequestTime(LocalDateTime.now());
            req.setStatus("CRITICAL_PENDING");
            emergencyRequestRepository.save(req);
        }
        return "redirect:/patient/dashboard?sos=triggered";
    }

    @GetMapping("/admin/emergency")
    public String viewEmergencies(Model model) {
        model.addAttribute("emergencies", emergencyRequestRepository.findAll());
        return "admin/emergency";
    }
}
