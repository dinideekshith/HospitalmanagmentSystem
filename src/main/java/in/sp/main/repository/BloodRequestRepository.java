package in.sp.main.repository;

import in.sp.main.entity.BloodRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface BloodRequestRepository extends JpaRepository<BloodRequest, Long> {
    List<BloodRequest> findByDoctorUserId(Long doctorId);
    List<BloodRequest> findByPatientUserId(Long patientId);
    List<BloodRequest> findByStatus(String status);
}
