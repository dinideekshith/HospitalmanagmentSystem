package in.sp.main.controller;

import in.sp.main.entity.Role;
import in.sp.main.entity.User;
import in.sp.main.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    @GetMapping("/")
    public String home() {
        return "index";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(@ModelAttribute User user, RedirectAttributes redirectAttributes) {
        if (userService.findByEmail(user.getEmail()) != null) {
            redirectAttributes.addFlashAttribute("error", "Email already exists!");
            return "redirect:/register";
        }
        userService.registerUser(user);
        redirectAttributes.addFlashAttribute("email", user.getEmail());
        return "redirect:/verify-otp";
    }

    @GetMapping("/verify-otp")
    public String verifyOtpPage() {
        return "verify-otp";
    }

    @PostMapping("/verify-otp")
    public String verifyOtp(@RequestParam String email, @RequestParam String otp, RedirectAttributes redirectAttributes) {
        boolean verified = userService.verifyOtp(email, otp);
        if (verified) {
            User user = userService.findByEmail(email);
            if (user != null && (user.getRole() == Role.DOCTOR || user.getRole() == Role.VENDOR) && !user.isApproved()) {
                redirectAttributes.addFlashAttribute("success", "Email verified! Your registration request has been sent to the Admin. You can log in once approved.");
            } else {
                redirectAttributes.addFlashAttribute("success", "Account verified successfully! Please login.");
            }
            return "redirect:/login";
        } else {
            redirectAttributes.addFlashAttribute("error", "Invalid OTP. Please try again.");
            redirectAttributes.addFlashAttribute("email", email);
            return "redirect:/verify-otp";
        }
    }
}
