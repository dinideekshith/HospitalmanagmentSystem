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
import in.sp.main.repository.AmbulanceRepository;
import in.sp.main.repository.BedRepository;
import in.sp.main.repository.EmergencyRequestRepository;
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

    @Autowired
    private AmbulanceRepository ambulanceRepository;

    @Autowired
    private BedRepository bedRepository;

    @Autowired
    private EmergencyRequestRepository emergencyRequestRepository;

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
        
        long pendingVendorCount = userService.getAllUsers().stream()
            .filter(u -> u.getRole() == in.sp.main.entity.Role.VENDOR && !u.isApproved())
            .count();
        model.addAttribute("pendingVendorCount", pendingVendorCount);
        
        // New Analytics
        model.addAttribute("ambulanceCount", ambulanceRepository.count());
        model.addAttribute("bedCount", bedRepository.count());
        model.addAttribute("emergencyCount", emergencyRequestRepository.count());
        
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

    @GetMapping("/pending-vendors")
    public String listPendingVendors(Model model) {
        List<User> pendingVendors = userService.getAllUsers().stream()
                .filter(u -> u.getRole() == in.sp.main.entity.Role.VENDOR && !u.isApproved())
                .toList();
        model.addAttribute("pendingVendors", pendingVendors);
        return "admin/pending-vendors";
    }

    @PostMapping("/approve-vendor")
    public String approveVendor(@org.springframework.web.bind.annotation.RequestParam("id") Long id) {
        User user = userService.findById(id);
        if (user != null && user.getRole() == in.sp.main.entity.Role.VENDOR) {
            user.setApproved(true);
            userService.saveUser(user);
        }
        return "redirect:/admin/pending-vendors";
    }

    @GetMapping("/equipment")
    public String listEquipmentRequests(Model model) {
        model.addAttribute("equipmentRequests", equipmentRequestRepository.findAll());
        return "admin/equipment";
    }

    @PostMapping("/revoke-access")
    public String revokeAccess(@org.springframework.web.bind.annotation.RequestParam("id") Long id, @org.springframework.web.bind.annotation.RequestParam("returnUrl") String returnUrl) {
        User user = userService.findById(id);
        if (user != null) {
            user.setLocked(true);
            userService.saveUser(user);
        }
        return "redirect:" + returnUrl;
    }

    @PostMapping("/restore-access")
    public String restoreAccess(@org.springframework.web.bind.annotation.RequestParam("id") Long id, @org.springframework.web.bind.annotation.RequestParam("returnUrl") String returnUrl) {
        User user = userService.findById(id);
        if (user != null) {
            user.setLocked(false);
            userService.saveUser(user);
        }
        return "redirect:" + returnUrl;
    }

    @PostMapping("/delete-user")
    public String deleteUser(@org.springframework.web.bind.annotation.RequestParam("id") Long id, @org.springframework.web.bind.annotation.RequestParam("returnUrl") String returnUrl, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        try {
            userService.deleteUser(id);
            redirectAttributes.addFlashAttribute("success", "User successfully deleted from the database.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete user. They may have dependent records (e.g., appointments).");
        }
        return "redirect:" + returnUrl;
    }
}
