package in.sp.main.repository;

import in.sp.main.entity.Medicine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.time.LocalDate;

@Repository
public interface MedicineRepository extends JpaRepository<Medicine, Long> {
    Optional<Medicine> findByBatchNumber(String batchNumber);
    List<Medicine> findByVendorUserId(Long vendorId);
    List<Medicine> findByNameContainingIgnoreCase(String name);
    List<Medicine> findByExpiryDateBefore(LocalDate date);
}
