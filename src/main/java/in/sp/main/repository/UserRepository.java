package in.sp.main.repository;

import in.sp.main.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    User findByMobileNumber(String mobileNumber);
}
