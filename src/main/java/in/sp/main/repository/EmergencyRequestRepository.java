package in.sp.main.repository;

import in.sp.main.entity.EmergencyRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface EmergencyRequestRepository extends JpaRepository<EmergencyRequest, Long> {
    List<EmergencyRequest> findByPatientUserId(Long patientId);
    List<EmergencyRequest> findByStatus(String status);
}
