package in.sp.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import java.security.Principal;
import org.springframework.ui.Model;
import in.sp.main.entity.User;
import in.sp.main.entity.Vendor;
import in.sp.main.service.UserService;
import in.sp.main.repository.VendorRepository;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
@RequestMapping("/vendor")
public class VendorController {

    @Autowired
    private UserService userService;

    @Autowired
    private VendorRepository vendorRepository;

    @Autowired
    private in.sp.main.repository.PrescriptionRepository prescriptionRepository;

    @Autowired
    private in.sp.main.repository.LabTestRequestRepository labTestRequestRepository;

    @Autowired
    private in.sp.main.repository.EquipmentRequestRepository equipmentRequestRepository;

    @GetMapping("/dashboard")
    public String dashboard(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        if (!user.isApproved()) {
            return "redirect:/vendor/pending-approval";
        }
        model.addAttribute("user", user);
        
        Vendor vendor = vendorRepository.findById(user.getId()).orElse(null);
        model.addAttribute("vendor", vendor);
        
        if (vendor != null && vendor.getVendorType() != null) {
            String vType = vendor.getVendorType().toUpperCase();
            if (vType.contains("PHARMACY")) {
                model.addAttribute("prescriptions", prescriptionRepository.findByStatus("PENDING"));
            } else if (vType.contains("LAB")) {
                model.addAttribute("labTests", labTestRequestRepository.findByStatus("PENDING"));
            } else if (vType.contains("SUPPLIER")) {
                model.addAttribute("equipmentRequests", equipmentRequestRepository.findByStatus("PENDING"));
            }
        }
        
        return "vendor/dashboard";
    }

    @GetMapping("/profile")
    public String profile(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        if (!user.isApproved()) {
            return "redirect:/vendor/pending-approval";
        }
        model.addAttribute("user", user);
        Vendor vendor = vendorRepository.findById(user.getId()).orElse(new Vendor());
        model.addAttribute("vendor", vendor);
        return "vendor/profile";
    }
    
    @PostMapping("/profile")
    public String updateProfile(Principal principal, @ModelAttribute Vendor vendorDetails) {
        User user = userService.findByEmail(principal.getName());
        if (!user.isApproved()) {
            return "redirect:/vendor/pending-approval";
        }
        Vendor vendor = vendorRepository.findById(user.getId()).orElse(new Vendor());
        vendor.setUser(user);
        vendor.setBusinessName(vendorDetails.getBusinessName());
        vendor.setVendorType(vendorDetails.getVendorType());
        vendor.setAddress(vendorDetails.getAddress());
        vendorRepository.save(vendor);
        return "redirect:/vendor/dashboard";
    }

    @PostMapping("/fulfill-prescription")
    public String fulfillPrescription(@org.springframework.web.bind.annotation.RequestParam Long id, Principal principal) {
        in.sp.main.entity.Prescription p = prescriptionRepository.findById(id).orElse(null);
        if (p != null) {
            p.setStatus("FULFILLED");
            prescriptionRepository.save(p);
        }
        return "redirect:/vendor/dashboard";
    }

    @GetMapping("/upload-results")
    public String showUploadResultsForm(@org.springframework.web.bind.annotation.RequestParam Long id, Model model) {
        in.sp.main.entity.LabTestRequest labTest = labTestRequestRepository.findById(id).orElse(null);
        model.addAttribute("labTest", labTest);
        return "vendor/upload-results";
    }

    @PostMapping("/upload-results")
    public String uploadResults(@org.springframework.web.bind.annotation.RequestParam Long id, @org.springframework.web.bind.annotation.RequestParam String results) {
        in.sp.main.entity.LabTestRequest labTest = labTestRequestRepository.findById(id).orElse(null);
        if (labTest != null) {
            labTest.setResults(results);
            labTest.setStatus("COMPLETED");
            labTestRequestRepository.save(labTest);
        }
        return "redirect:/vendor/dashboard";
    }

    @GetMapping("/pending-approval")
    public String pendingApproval(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        if (user.isApproved()) {
            return "redirect:/vendor/dashboard";
        }
        model.addAttribute("user", user);
        return "vendor/pending-approval";
    }

    @PostMapping("/deliver-equipment")
    public String deliverEquipment(@org.springframework.web.bind.annotation.RequestParam Long id) {
        in.sp.main.entity.EquipmentRequest eq = equipmentRequestRepository.findById(id).orElse(null);
        if (eq != null) {
            eq.setStatus("DELIVERED");
            equipmentRequestRepository.save(eq);
        }
        return "redirect:/vendor/dashboard";
    }
}
