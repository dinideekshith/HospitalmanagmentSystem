package in.sp.main.repository;

import in.sp.main.entity.EquipmentRequest;
import in.sp.main.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface EquipmentRequestRepository extends JpaRepository<EquipmentRequest, Long> {
    List<EquipmentRequest> findByDoctor(User doctor);
    List<EquipmentRequest> findByStatus(String status);
}
