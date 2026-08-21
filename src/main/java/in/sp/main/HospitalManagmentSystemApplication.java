package in.sp.main;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class HospitalManagmentSystemApplication {

    public static void main(String[] args) {
        SpringApplication.run(HospitalManagmentSystemApplication.class, args);
    }

}
