package in.sp.main.service;

import in.sp.main.entity.Role;
import in.sp.main.entity.User;
import in.sp.main.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import in.sp.main.entity.Patient;
import in.sp.main.entity.Doctor;
import in.sp.main.entity.Vendor;
import in.sp.main.repository.PatientRepository;
import in.sp.main.repository.DoctorRepository;
import in.sp.main.repository.VendorRepository;
import java.util.Random;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private EmailService emailService;

    @Autowired
    private PatientRepository patientRepository;

    @Autowired
    private DoctorRepository doctorRepository;

    @Autowired
    private VendorRepository vendorRepository;

    public User registerUser(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        String otp = String.format("%04d", new Random().nextInt(10000));
        user.setOtpCode(otp);
        user.setVerified(false);
        
        if (user.getRole() == Role.DOCTOR || user.getRole() == Role.VENDOR) {
            user.setApproved(false);
        } else {
            user.setApproved(true);
        }
        
        User savedUser = userRepository.save(user);
        
        // Send OTP
        String text = "Dear " + user.getName() + ",\n\nYour OTP for registration is: " + otp + "\n\nThank you.";
        emailService.sendEmail(user.getEmail(), "Hospital Management System - OTP Verification", text);
        
        // Initialize child entities
        if (savedUser.getRole() == Role.PATIENT) {
            Patient p = new Patient();
            p.setUser(savedUser);
            patientRepository.save(p);
        } else if (savedUser.getRole() == Role.DOCTOR) {
            Doctor d = new Doctor();
            d.setUser(savedUser);
            doctorRepository.save(d);
        } else if (savedUser.getRole() == Role.VENDOR) {
            Vendor v = new Vendor();
            v.setUser(savedUser);
            vendorRepository.save(v);
        }
        
        return savedUser;
    }

    public boolean verifyOtp(String email, String otp) {
        User user = userRepository.findByEmail(email);
        if (user != null && otp.equals(user.getOtpCode())) {
            user.setVerified(true);
            user.setOtpCode(null);
            userRepository.save(user);
            return true;
        }
        return false;
    }

    public User findByEmail(String email) {
        return userRepository.findByEmail(email);
    }
    
    public User findById(Long id) {
        return userRepository.findById(id).orElse(null);
    }
    
    public User saveUser(User user) {
        return userRepository.save(user);
    }

    public java.util.List<User> getAllUsers() {
        return userRepository.findAll();
    }
}
