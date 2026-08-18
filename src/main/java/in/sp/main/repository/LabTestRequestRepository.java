package in.sp.main.repository;

import in.sp.main.entity.LabTestRequest;
import in.sp.main.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface LabTestRequestRepository extends JpaRepository<LabTestRequest, Long> {
    List<LabTestRequest> findByPatient(User patient);
    List<LabTestRequest> findByDoctor(User doctor);
    List<LabTestRequest> findByStatus(String status);
}
