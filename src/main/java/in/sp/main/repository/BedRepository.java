package in.sp.main.repository;

import in.sp.main.entity.Bed;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BedRepository extends JpaRepository<Bed, Long> {
    List<Bed> findByRoomId(Long roomId);
    List<Bed> findByStatus(String status);
    Optional<Bed> findByBedNumber(String bedNumber);
    Optional<Bed> findByAssignedPatientUserId(Long patientId);
}
