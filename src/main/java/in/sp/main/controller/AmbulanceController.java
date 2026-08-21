package in.sp.main.controller;

import in.sp.main.entity.Ambulance;
import in.sp.main.entity.AmbulanceRequest;
import in.sp.main.repository.AmbulanceRepository;
import in.sp.main.repository.AmbulanceRequestRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;

@Controller
public class AmbulanceController {

    @Autowired
    private AmbulanceRepository ambulanceRepository;

    @Autowired
    private AmbulanceRequestRepository ambulanceRequestRepository;

    @GetMapping("/admin/ambulances")
    public String viewAmbulances(Model model) {
        model.addAttribute("ambulances", ambulanceRepository.findAll());
        model.addAttribute("requests", ambulanceRequestRepository.findAll());
        return "admin/ambulances";
    }

    @PostMapping("/admin/ambulances/add")
    public String addAmbulance(@RequestParam String vehicleNumber, @RequestParam String driverName, @RequestParam String driverContact) {
        Ambulance amb = new Ambulance();
        amb.setVehicleNumber(vehicleNumber);
        amb.setDriverName(driverName);
        amb.setDriverContact(driverContact);
        amb.setStatus("AVAILABLE");
        ambulanceRepository.save(amb);
        return "redirect:/admin/ambulances?success";
    }

    @PostMapping("/admin/ambulances/assign")
    public String assignAmbulance(@RequestParam Long requestId, @RequestParam Long ambulanceId) {
        AmbulanceRequest req = ambulanceRequestRepository.findById(requestId).orElse(null);
        Ambulance amb = ambulanceRepository.findById(ambulanceId).orElse(null);
        if (req != null && amb != null && "AVAILABLE".equals(amb.getStatus())) {
            req.setAmbulance(amb);
            req.setStatus("ASSIGNED");
            amb.setStatus("ASSIGNED");
            ambulanceRepository.save(amb);
            ambulanceRequestRepository.save(req);
        }
        return "redirect:/admin/ambulances?assigned";
    }
}
