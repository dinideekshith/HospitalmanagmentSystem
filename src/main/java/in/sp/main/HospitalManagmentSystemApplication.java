package in.sp.main;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.security.crypto.password.PasswordEncoder;
import in.sp.main.entity.User;
import in.sp.main.entity.Role;
import in.sp.main.repository.UserRepository;

@SpringBootApplication
public class HospitalManagmentSystemApplication {

	public static void main(String[] args) {
		SpringApplication.run(HospitalManagmentSystemApplication.class, args);
	}

	@Bean
	CommandLineRunner initDatabase(UserRepository userRepository, PasswordEncoder passwordEncoder) {
		return args -> {
			if (userRepository.findByEmail("admin@hospital.com") == null) {
				User admin = new User();
				admin.setName("System Admin");
				admin.setEmail("admin@hospital.com");
				admin.setMobileNumber("0000000000");
				admin.setPassword(passwordEncoder.encode("admin123"));
				admin.setRole(Role.ADMIN);
				admin.setVerified(true);
				userRepository.save(admin);
				System.out.println("Default Admin created: admin@hospital.com / admin123");
			}
		};
	}
}
