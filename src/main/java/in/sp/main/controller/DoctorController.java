package in.sp.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import java.security.Principal;
import java.util.List;
import org.springframework.ui.Model;
import in.sp.main.entity.User;
import in.sp.main.entity.Doctor;
import in.sp.main.entity.Appointment;
import in.sp.main.service.UserService;
import in.sp.main.repository.DoctorRepository;
import in.sp.main.repository.AppointmentRepository;
import in.sp.main.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import in.sp.main.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

@Controller
@RequestMapping("/doctor")
public class DoctorController {

    @Autowired
    private UserService userService;
    
    @Autowired
    private DoctorRepository doctorRepository;
    
    @Autowired
    private AppointmentRepository appointmentRepository;
    
    @Autowired
    private EmailService emailService;
    
    @Autowired
    private in.sp.main.repository.LabTestRequestRepository labTestRequestRepository;
    
    @Autowired
    private in.sp.main.repository.EquipmentRequestRepository equipmentRequestRepository;
    
    @Autowired
    private in.sp.main.repository.MedicalRecordRepository medicalRecordRepository;

    @GetMapping("/dashboard")
    public String dashboard(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        if (!user.isApproved()) {
            return "redirect:/doctor/pending-approval";
        }
        model.addAttribute("user", user);
        
        Doctor doctor = doctorRepository.findById(user.getId()).orElse(null);
        model.addAttribute("doctor", doctor);
        
        List<Appointment> appointments = appointmentRepository.findByDoctorId(user.getId());
        model.addAttribute("appointments", appointments);
        
        long pendingCount = appointments.stream().filter(a -> "PENDING".equals(a.getStatus())).count();
        model.addAttribute("pendingCount", pendingCount);
        
        return "doctor/dashboard";
    }
    
    @GetMapping("/pending-approval")
    public String pendingApproval(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        if (user.isApproved()) {
            return "redirect:/doctor/dashboard";
        }
        model.addAttribute("user", user);
        return "doctor/pending-approval";
    }

    @GetMapping("/messages")
    public String messages(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        
        // Load contacts (patients the doctor has appointments with)
        List<Appointment> appointments = appointmentRepository.findByDoctorId(user.getId());
        List<User> patients = appointments.stream().map(Appointment::getPatient).distinct().toList();
        model.addAttribute("contacts", patients);
        
        return "doctor/messages";
    }
    
    @GetMapping("/profile")
    public String profile(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        if (!user.isApproved()) {
            return "redirect:/doctor/pending-approval";
        }
        model.addAttribute("user", user);
        Doctor doctor = doctorRepository.findById(user.getId()).orElse(new Doctor());
        model.addAttribute("doctor", doctor);
        return "doctor/profile";
    }
    
    @PostMapping("/profile")
    public String updateProfile(Principal principal, 
                                @RequestParam String name,
                                @RequestParam String email,
                                @RequestParam String mobileNumber,
                                @ModelAttribute Doctor doctorDetails) {
        User user = userService.findByEmail(principal.getName());
        
        // Update core user details
        user.setName(name);
        user.setEmail(email);
        user.setMobileNumber(mobileNumber);
        userService.saveUser(user);
        
        // Update doctor details
        Doctor doctor = doctorRepository.findById(user.getId()).orElse(new Doctor());
        doctor.setUser(user);
        doctor.setSpecialization(doctorDetails.getSpecialization());
        doctor.setQualification(doctorDetails.getQualification());
        doctor.setExperienceYears(doctorDetails.getExperienceYears());
        doctor.setAvailabilitySchedule(doctorDetails.getAvailabilitySchedule());
        doctorRepository.save(doctor);
        
        return "redirect:/doctor/dashboard";
    }
    
    @GetMapping("/appointment/accept/{id}")
    public String acceptAppointment(@PathVariable Long id, Principal principal) {
        Appointment appointment = appointmentRepository.findById(id).orElse(null);
        if (appointment != null && appointment.getDoctor().getEmail().equals(principal.getName())) {
            appointment.setStatus("CONFIRMED");
            appointmentRepository.save(appointment);
            
            String text = "Dear " + appointment.getPatient().getName() + ",\n\nYour appointment with Dr. " 
                    + appointment.getDoctor().getName() + " on " + appointment.getAppointmentDate() 
                    + " at " + appointment.getAppointmentTime() + " has been CONFIRMED.\n\nThank you.";
            emailService.sendEmail(appointment.getPatient().getEmail(), "Appointment Confirmed", text);
        }
        return "redirect:/doctor/dashboard";
    }
    
    @GetMapping("/appointment/reject/{id}")
    public String rejectAppointment(@PathVariable Long id, Principal principal) {
        Appointment appointment = appointmentRepository.findById(id).orElse(null);
        if (appointment != null && appointment.getDoctor().getEmail().equals(principal.getName())) {
            appointment.setStatus("REJECTED");
            appointmentRepository.save(appointment);
            
            String text = "Dear " + appointment.getPatient().getName() + ",\n\nUnfortunately, your appointment request with Dr. " 
                    + appointment.getDoctor().getName() + " on " + appointment.getAppointmentDate() 
                    + " has been REJECTED.\n\nPlease try booking another time.\n\nThank you.";
            emailService.sendEmail(appointment.getPatient().getEmail(), "Appointment Rejected", text);
        }
        return "redirect:/doctor/dashboard";
    }
    
    @GetMapping("/appointment/approve-video/{id}")
    public String approveVideoConsultation(@PathVariable Long id, Principal principal) {
        Appointment appointment = appointmentRepository.findById(id).orElse(null);
        if (appointment != null && appointment.getDoctor().getEmail().equals(principal.getName())) {
            appointment.setStatus("VIDEO_APPROVED");
            // Generate unique Jitsi meet URL
            appointment.setMeetUrl("HMS_Consult_" + java.util.UUID.randomUUID().toString());
            appointmentRepository.save(appointment);
        }
        return "redirect:/doctor/appointments";
    }
    
    // --- New Features (Phase 3) ---
    
    @Autowired
    private in.sp.main.repository.PrescriptionRepository prescriptionRepository;

    @GetMapping("/medical-records")
    public String medicalRecords(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        
        List<in.sp.main.entity.MedicalRecord> records = medicalRecordRepository.findByDoctor(user);
        model.addAttribute("records", records);
        
        return "doctor/medical-records"; 
    }

    @GetMapping("/appointments")
    public String viewAppointments(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        model.addAttribute("appointments", appointmentRepository.findByDoctorId(user.getId()));
        return "doctor/appointments";
    }

    @GetMapping("/appointment/view/{id}")
    public String viewActiveAppointment(@PathVariable Long id, Principal principal, Model model) {
        User doctorUser = userService.findByEmail(principal.getName());
        Appointment appointment = appointmentRepository.findById(id).orElse(null);
        if (appointment != null && appointment.getDoctor().getId().equals(doctorUser.getId())) {
            model.addAttribute("user", doctorUser);
            model.addAttribute("appointment", appointment);
            
            // Fetch comprehensive patient profile
            in.sp.main.entity.Patient patientProfile = patientRepository.findById(appointment.getPatient().getId()).orElse(null);
            model.addAttribute("patientProfile", patientProfile);
            
            // Full history for follow-up
            model.addAttribute("pastRecords", medicalRecordRepository.findByPatient(appointment.getPatient()));
            model.addAttribute("pastPrescriptions", prescriptionRepository.findByPatient(appointment.getPatient()));
            return "doctor/active-appointment";
        }
        return "redirect:/doctor/appointments";
    }

    @GetMapping("/patients")
    public String viewPatients(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        List<Appointment> appointments = appointmentRepository.findByDoctorId(user.getId());
        List<User> patients = appointments.stream().map(Appointment::getPatient).distinct().toList();
        model.addAttribute("patients", patients);
        return "doctor/patients";
    }

    @GetMapping("/laboratory-tests")
    public String viewLabTests(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        model.addAttribute("labTests", labTestRequestRepository.findByDoctor(user));
        return "doctor/laboratory-tests";
    }

    @GetMapping("/medical-equipment")
    public String requestEquipmentForm(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        return "doctor/medical-equipment";
    }

    @PostMapping("/medical-equipment")
    public String submitEquipmentRequest(@ModelAttribute in.sp.main.entity.EquipmentRequest request, Principal principal) {
        User user = userService.findByEmail(principal.getName());
        request.setDoctor(user);
        request.setStatus("PENDING");
        equipmentRequestRepository.save(request);
        return "redirect:/doctor/equipment-requests";
    }

    @GetMapping("/equipment-requests")
    public String viewEquipmentRequests(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        model.addAttribute("equipmentRequests", equipmentRequestRepository.findByDoctor(user));
        return "doctor/equipment-requests";
    }

    @GetMapping("/equipment-delivery")
    public String viewEquipmentDelivery(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        model.addAttribute("equipmentRequests", equipmentRequestRepository.findByDoctor(user));
        return "doctor/equipment-delivery";
    }

    @Autowired
    private in.sp.main.repository.BloodRequestRepository bloodRequestRepository;
    
    @Autowired
    private in.sp.main.repository.BloodInventoryRepository bloodInventoryRepository;
    
    @Autowired
    private in.sp.main.repository.PatientRepository patientRepository;

    @GetMapping("/blood-bank")
    public String bloodBank(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        model.addAttribute("bloodRequests", bloodRequestRepository.findByDoctorUserId(user.getId()));
        
        List<Appointment> appointments = appointmentRepository.findByDoctorId(user.getId());
        List<User> patients = appointments.stream().map(Appointment::getPatient).distinct().toList();
        model.addAttribute("patients", patients);
        
        model.addAttribute("bloodInventory", bloodInventoryRepository.findAll());
        
        return "doctor/blood-bank";
    }

    @PostMapping("/blood-bank/request")
    public String requestBlood(Principal principal, @RequestParam Long patientId, @RequestParam String bloodGroup, @RequestParam int units, @RequestParam String urgency) {
        User user = userService.findByEmail(principal.getName());
        Doctor doctor = doctorRepository.findById(user.getId()).orElse(null);
        in.sp.main.entity.Patient patient = patientRepository.findById(patientId).orElse(null);
        
        if (patient != null && doctor != null) {
            in.sp.main.entity.BloodRequest req = new in.sp.main.entity.BloodRequest();
            req.setDoctor(doctor);
            req.setPatient(patient);
            req.setBloodGroup(bloodGroup);
            req.setUnitsRequested(units);
            req.setUrgency(urgency);
            req.setRequestDate(java.time.LocalDateTime.now());
            req.setStatus("PENDING");
            bloodRequestRepository.save(req);
        }
        return "redirect:/doctor/blood-bank";
    }

    @PostMapping("/blood-bank/request-test")
    public String requestBloodTest(Principal principal, @RequestParam Long patientId, @RequestParam String testDetails) {
        User doctorUser = userService.findByEmail(principal.getName());
        User patientUser = userService.findById(patientId);
        
        in.sp.main.entity.LabTestRequest request = new in.sp.main.entity.LabTestRequest();
        request.setDoctor(doctorUser);
        request.setPatient(patientUser);
        request.setTestName("Blood Test: " + testDetails);
        request.setStatus("PENDING");
        request.setRequestDate(java.time.LocalDate.now());
        labTestRequestRepository.save(request);
        
        return "redirect:/doctor/blood-bank";
    }

    @GetMapping("/add-prescription")
    public String showAddPrescriptionForm(Principal principal, Model model) {
        User doctorUser = userService.findByEmail(principal.getName());
        model.addAttribute("user", doctorUser);
        
        List<Appointment> appointments = appointmentRepository.findByDoctorId(doctorUser.getId());
        List<User> patients = appointments.stream().map(Appointment::getPatient).distinct().toList();
        model.addAttribute("patients", patients);
        
        return "doctor/add-prescription";
    }

    @Autowired
    private in.sp.main.repository.MedicineRepository medicineRepository;

    @PostMapping("/add-prescription")
    public String addPrescription(@ModelAttribute in.sp.main.entity.Prescription prescription, 
                                 @RequestParam Long patientId, Principal principal, org.springframework.web.servlet.mvc.support.RedirectAttributes redirectAttributes) {
        User doctorUser = userService.findByEmail(principal.getName());
        User patientUser = userService.findById(patientId);
        
        prescription.setDoctor(doctorUser);
        prescription.setPatient(patientUser);
        prescription.setStatus("PENDING"); // Pending fulfillment by Pharmacy
        prescriptionRepository.save(prescription);
        
        // --- Inventory Integration: Deduct stock automatically ---
        try {
            List<in.sp.main.entity.Medicine> matchingMedicines = medicineRepository.findAll().stream()
                .filter(m -> m.getName().toLowerCase().contains(prescription.getMedicineName().toLowerCase()))
                .toList();
                
            if (!matchingMedicines.isEmpty()) {
                in.sp.main.entity.Medicine medicine = matchingMedicines.get(0);
                // Deduct 1 pack/course from inventory
                if (medicine.getQuantity() > 0) {
                    medicine.setQuantity(medicine.getQuantity() - 1);
                    medicineRepository.save(medicine);
                    redirectAttributes.addFlashAttribute("success", "Prescription saved and 1 unit deducted from Pharmacy Inventory.");
                } else {
                    redirectAttributes.addFlashAttribute("error", "Prescription saved, but " + medicine.getName() + " is OUT OF STOCK in Pharmacy!");
                }
            } else {
                redirectAttributes.addFlashAttribute("success", "Prescription saved successfully.");
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("success", "Prescription saved successfully.");
        }
        
        return "redirect:/doctor/prescriptions";
    }

    @GetMapping("/add-medical-record")
    public String showAddMedicalRecordForm(@RequestParam Long patientId, Principal principal, Model model) {
        User doctorUser = userService.findByEmail(principal.getName());
        User patientUser = userService.findById(patientId);
        model.addAttribute("user", doctorUser);
        model.addAttribute("doctorUser", doctorUser);
        model.addAttribute("patientUser", patientUser);
        return "doctor/add-medical-record";
    }

    @PostMapping("/add-medical-record")
    public String addMedicalRecord(@ModelAttribute in.sp.main.entity.MedicalRecord record, 
                                   @RequestParam Long patientId, Principal principal) {
        User doctorUser = userService.findByEmail(principal.getName());
        User patientUser = userService.findById(patientId);
        
        record.setDoctor(doctorUser);
        record.setPatient(patientUser);
        medicalRecordRepository.save(record);
        
        return "redirect:/doctor/medical-records";
    }

    @GetMapping("/prescriptions")
    public String prescriptions(Principal principal, Model model) {
        User user = userService.findByEmail(principal.getName());
        model.addAttribute("user", user);
        
        List<in.sp.main.entity.Prescription> prescriptions = prescriptionRepository.findByDoctor(user);
        model.addAttribute("prescriptions", prescriptions);
        
        return "doctor/doctor-prescriptions";
    }

    @GetMapping("/request-lab-test")
    public String showRequestLabTestForm(@RequestParam(required = false) Long patientId, Principal principal, Model model) {
        User doctorUser = userService.findByEmail(principal.getName());
        model.addAttribute("user", doctorUser);
        
        // Fetch all patients the doctor has appointments with
        List<Appointment> appointments = appointmentRepository.findByDoctorId(doctorUser.getId());
        List<User> patients = appointments.stream().map(Appointment::getPatient).distinct().toList();
        model.addAttribute("patients", patients);
        
        return "doctor/request-lab-test";
    }

    @PostMapping("/request-lab-test")
    public String requestLabTest(@ModelAttribute in.sp.main.entity.LabTestRequest request, 
                                 @RequestParam Long patientId, Principal principal) {
        User doctorUser = userService.findByEmail(principal.getName());
        User patientUser = userService.findById(patientId);
        
        request.setDoctor(doctorUser);
        request.setPatient(patientUser);
        request.setStatus("PENDING");
        labTestRequestRepository.save(request);
        
        return "redirect:/doctor/dashboard"; // Or to a lab tests page
    }

    @Autowired
    private in.sp.main.service.PdfService pdfService;

    @GetMapping("/download-prescription")
    public void downloadPrescription(jakarta.servlet.http.HttpServletResponse response, @RequestParam Long id, Principal principal) throws java.io.IOException, com.lowagie.text.DocumentException {
        in.sp.main.entity.Prescription p = prescriptionRepository.findById(id).orElse(null);
        if (p != null && p.getDoctor().getEmail().equals(principal.getName())) {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"prescription_" + id + ".pdf\"");
            pdfService.exportPrescriptionToPdf(response, p);
        }
    }

    @GetMapping("/download-record")
    public void downloadRecord(jakarta.servlet.http.HttpServletResponse response, @RequestParam Long id, Principal principal) throws java.io.IOException, com.lowagie.text.DocumentException {
        in.sp.main.entity.MedicalRecord r = medicalRecordRepository.findById(id).orElse(null);
        if (r != null && r.getDoctor().getEmail().equals(principal.getName())) {
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=\"medical_record_" + id + ".pdf\"");
            pdfService.exportMedicalRecordToPdf(response, r);
        }
    }
}
