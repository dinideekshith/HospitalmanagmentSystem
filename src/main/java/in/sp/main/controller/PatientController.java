package in.sp.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import java.security.Principal;
import java.util.List;
import org.springframework.ui.Model;
import in.sp.main.entity.User;
import in.sp.main.entity.Patient;
import in.sp.main.entity.Doctor;
import in.sp.main.entity.Appointment;
import in.sp.main.service.UserService;
import in.sp.main.repository.PatientRepository;
import in.sp.main.repository.DoctorRepository;
import in.sp.main.repository.AppointmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import in.sp.main.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
@RequestMapping("/patient")
public class PatientController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private PatientRepository patientRepository;
    
    @Autowired
    private DoctorRepository doctorRepository;
    
    @Autowired
    private AppointmentRepository appointmentRepository;

    @Autowired
    private in.sp.main.repository.MedicalRecordRepository medicalRecordRepository;

    @Autowired
    private in.sp.main.repository.PrescriptionRepository prescriptionRepository;

    @Autowired
    private in.sp.main.repository.LabTestRequestRepository labTestRequestRepository;

    @GetMapping("/dashboard")
    public String dashboard(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        
        return "patient/dashboard";
    }

    @GetMapping("/appointments")
    public String viewAppointments(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        model.addAttribute("appointments", appointmentRepository.findByPatientId(user.getId()));
        return "patient/appointments";
    }

    @GetMapping("/medical-records")
    public String viewMedicalRecords(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        model.addAttribute("medicalRecords", medicalRecordRepository.findByPatient(user));
        return "patient/medical-records";
    }

    @GetMapping("/prescriptions")
    public String viewPrescriptions(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        model.addAttribute("prescriptions", prescriptionRepository.findByPatient(user));
        return "patient/prescriptions";
    }

    @GetMapping("/lab-tests")
    public String viewLabTests(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        model.addAttribute("labTests", labTestRequestRepository.findByPatient(user));
        return "patient/lab-tests";
    }
    
    @GetMapping("/profile")
    public String profile(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        Patient patient = patientRepository.findById(user.getId()).orElse(new Patient());
        model.addAttribute("patient", patient);
        return "patient/profile";
    }
    
    @PostMapping("/profile")
    public String updateProfile(Principal principal, 
                                @RequestParam String name,
                                @RequestParam String email,
                                @RequestParam String mobileNumber,
                                @ModelAttribute Patient patientDetails) {
        User user = userService.findByEmail(principal.getName());
        
        // Update core user details
        user.setName(name);
        user.setEmail(email);
        user.setMobileNumber(mobileNumber);
        userService.saveUser(user);
        
        // Update patient details
        Patient patient = patientRepository.findById(user.getId()).orElse(new Patient());
        patient.setUser(user);
        patient.setBloodGroup(patientDetails.getBloodGroup());
        patient.setGender(patientDetails.getGender());
        patient.setDateOfBirth(patientDetails.getDateOfBirth());
        patient.setAddress(patientDetails.getAddress());
        patientRepository.save(patient);
        
        return "redirect:/patient/dashboard";
    }
    
    @GetMapping("/book-appointment")
    public String bookAppointmentPage(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        
        // Fetch all registered doctors who have a specialization set
        List<Doctor> doctors = doctorRepository.findAll();
        doctors.removeIf(d -> d.getSpecialization() == null || d.getSpecialization().isEmpty());
        model.addAttribute("doctors", doctors);
        
        return "patient/book-appointment";
    }
    
    @GetMapping("/available-slots")
    @org.springframework.web.bind.annotation.ResponseBody
    public java.util.List<String> getAvailableSlots(@RequestParam Long doctorId, @RequestParam String date) {
        java.util.List<String> allSlots = java.util.Arrays.asList(
            "10:00 - 11:00", "11:00 - 12:00", "12:00 - 13:00", 
            "13:00 - 14:00", "14:00 - 15:00", "15:00 - 16:00", "16:00 - 17:00"
        );
        
        java.util.List<Appointment> existing = appointmentRepository.findByDoctorId(doctorId);
        java.util.List<String> booked = existing.stream()
            .filter(a -> a.getAppointmentDate().equals(date) && !"CANCELLED".equals(a.getStatus()))
            .map(Appointment::getAppointmentTime)
            .toList();
            
        java.util.List<String> available = new java.util.ArrayList<>(allSlots);
        available.removeAll(booked);
        
        return available;
    }

    @PostMapping("/book-appointment")
    public String bookAppointment(Principal principal, 
                                  @RequestParam Long doctorId, 
                                  @RequestParam String appointmentDate, 
                                  @RequestParam String appointmentTime,
                                  org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        User patientUser = userService.findByEmail(principal.getName());
        Doctor doctor = doctorRepository.findById(doctorId).orElse(null);
        
        if (doctor != null) {
            // Check double booking
            boolean isBooked = appointmentRepository.findByDoctorId(doctorId).stream()
                .anyMatch(a -> a.getAppointmentDate().equals(appointmentDate) && 
                               a.getAppointmentTime().equals(appointmentTime) && 
                               !"CANCELLED".equals(a.getStatus()));
                               
            if (isBooked) {
                redirectAttributes.addFlashAttribute("error", "The selected time slot is already booked. Please choose another.");
                return "redirect:/patient/book-appointment";
            }
            
            Appointment appointment = new Appointment();
            appointment.setPatient(patientUser);
            appointment.setDoctor(doctor.getUser());
            appointment.setAppointmentDate(appointmentDate);
            appointment.setAppointmentTime(appointmentTime);
            appointment.setStatus("PENDING");
            appointmentRepository.save(appointment);
        }
        
        return "redirect:/patient/dashboard";
    }

    @Autowired
    private in.sp.main.service.PdfService pdfService;

    @GetMapping("/download-prescription")
    public void downloadPrescription(jakarta.servlet.http.HttpServletResponse response, @RequestParam Long id, Principal principal) throws java.io.IOException, com.lowagie.text.DocumentException {
        in.sp.main.entity.Prescription p = prescriptionRepository.findById(id).orElse(null);
        if (p != null && p.getPatient().getEmail().equals(principal.getName())) {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"prescription_" + id + ".pdf\"");
            pdfService.exportPrescriptionToPdf(response, p);
        }
    }

    @GetMapping("/download-record")
    public void downloadRecord(jakarta.servlet.http.HttpServletResponse response, @RequestParam Long id, Principal principal) throws java.io.IOException, com.lowagie.text.DocumentException {
        in.sp.main.entity.MedicalRecord r = medicalRecordRepository.findById(id).orElse(null);
        if (r != null && r.getPatient().getEmail().equals(principal.getName())) {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"medical_record_" + id + ".pdf\"");
            pdfService.exportMedicalRecordToPdf(response, r);
        }
    }
}
