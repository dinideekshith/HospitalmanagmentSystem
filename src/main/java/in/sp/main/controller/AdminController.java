package in.sp.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.security.Principal;
import java.util.List;
import org.springframework.ui.Model;
import in.sp.main.entity.User;
import in.sp.main.entity.Doctor;
import in.sp.main.entity.Patient;
import in.sp.main.entity.Vendor;
import in.sp.main.entity.EquipmentRequest;
import in.sp.main.service.UserService;
import in.sp.main.repository.DoctorRepository;
import in.sp.main.repository.PatientRepository;
import in.sp.main.repository.VendorRepository;
import in.sp.main.repository.EquipmentRequestRepository;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private EquipmentRequestRepository equipmentRequestRepository;

    @GetMapping("/dashboard")
    public String dashboard(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        
        model.addAttribute("doctorCount", doctorRepository.count());
        model.addAttribute("patientCount", patientRepository.count());
        model.addAttribute("vendorCount", vendorRepository.count());
        model.addAttribute("equipmentRequestCount", equipmentRequestRepository.count());
        
        long pendingCount = userService.getAllUsers().stream()
            .filter(u -> u.getRole() == in.sp.main.entity.Role.DOCTOR && !u.isApproved())
            .count();
        model.addAttribute("pendingDoctorCount", pendingCount);
        
        return "admin/dashboard";
    }

    @GetMapping("/doctors")
    public String listDoctors(Model model) {
        model.addAttribute("doctors", doctorRepository.findAll());
        return "admin/doctors";
    }

    @GetMapping("/patients")
    public String listPatients(Model model) {
        model.addAttribute("patients", patientRepository.findAll());
        return "admin/patients";
    }

    @GetMapping("/vendors")
    public String listVendors(Model model) {
        model.addAttribute("vendors", vendorRepository.findAll());
        return "admin/vendors";
    }

    @GetMapping("/pending-doctors")
    public String listPendingDoctors(Model model) {
        // Fetch users who are doctors and not approved
        List<User> pendingDoctors = userService.getAllUsers().stream()
                .filter(u -> u.getRole() == in.sp.main.entity.Role.DOCTOR && !u.isApproved())
                .toList();
        model.addAttribute("pendingDoctors", pendingDoctors);
        return "admin/pending-doctors";
    }

    @PostMapping("/approve-doctor")
    public String approveDoctor(@org.springframework.web.bind.annotation.RequestParam("id") Long id) {
        User user = userService.findById(id);
        if (user != null && user.getRole() == in.sp.main.entity.Role.DOCTOR) {
            user.setApproved(true);
            userService.saveUser(user);
        }
        return "redirect:/admin/pending-doctors";
    }

    @GetMapping("/equipment")
    public String listEquipmentRequests(Model model) {
        model.addAttribute("equipmentRequests", equipmentRequestRepository.findAll());
        return "admin/equipment";
    }
}
