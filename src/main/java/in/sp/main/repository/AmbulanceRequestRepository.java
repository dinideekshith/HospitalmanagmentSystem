package in.sp.main.repository;

import in.sp.main.entity.AmbulanceRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface AmbulanceRequestRepository extends JpaRepository<AmbulanceRequest, Long> {
    List<AmbulanceRequest> findByPatientUserId(Long patientId);
    List<AmbulanceRequest> findByAmbulanceId(Long ambulanceId);
    List<AmbulanceRequest> findByStatus(String status);
}
