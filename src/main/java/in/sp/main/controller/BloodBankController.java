package in.sp.main.controller;

import in.sp.main.entity.BloodInventory;
import in.sp.main.entity.BloodRequest;
import in.sp.main.entity.Doctor;
import in.sp.main.entity.Patient;
import in.sp.main.entity.User;
import in.sp.main.repository.BloodInventoryRepository;
import in.sp.main.repository.BloodRequestRepository;
import in.sp.main.repository.DoctorRepository;
import in.sp.main.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.Optional;

@Controller
public class BloodBankController {

    @Autowired
    private BloodInventoryRepository bloodInventoryRepository;

    @Autowired
    private BloodRequestRepository bloodRequestRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private PatientRepository patientRepository;

    @GetMapping("/admin/blood-bank")
    public String viewBloodBank(Model model) {
        model.addAttribute("inventory", bloodInventoryRepository.findAll());
        model.addAttribute("requests", bloodRequestRepository.findAll());
        return "admin/blood-bank";
    }

    @PostMapping("/admin/blood-bank/update")
    public String updateBloodStock(@RequestParam String bloodGroup, @RequestParam int units) {
        Optional<BloodInventory> opt = bloodInventoryRepository.findByBloodGroup(bloodGroup);
        BloodInventory inventory = opt.orElse(new BloodInventory());
        inventory.setBloodGroup(bloodGroup);
        inventory.setUnitsAvailable(inventory.getUnitsAvailable() + units);
        inventory.setLastUpdated(LocalDateTime.now());
        bloodInventoryRepository.save(inventory);
        return "redirect:/admin/blood-bank?success";
    }

    @PostMapping("/admin/blood-bank/process-request")
    public String processBloodRequest(@RequestParam Long requestId, @RequestParam String action) {
        BloodRequest request = bloodRequestRepository.findById(requestId).orElse(null);
        if (request != null && "PENDING".equals(request.getStatus())) {
            if ("APPROVE".equals(action)) {
                BloodInventory inventory = bloodInventoryRepository.findByBloodGroup(request.getBloodGroup()).orElse(null);
                if (inventory != null && inventory.getUnitsAvailable() >= request.getUnitsRequested()) {
                    inventory.setUnitsAvailable(inventory.getUnitsAvailable() - request.getUnitsRequested());
                    bloodInventoryRepository.save(inventory);
                    request.setStatus("ISSUED");
                } else {
                    return "redirect:/admin/blood-bank?error=insufficient_stock";
                }
            } else {
                request.setStatus("REJECTED");
            }
            request.setProcessDate(LocalDateTime.now());
            bloodRequestRepository.save(request);
        }
        return "redirect:/admin/blood-bank?success";
    }
}
