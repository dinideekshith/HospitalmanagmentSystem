package in.sp.main.service;

import in.sp.main.entity.Medicine;
import in.sp.main.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.util.List;

@Component
public class MedicineExpiryScheduler {

    @Autowired
    private MedicineRepository medicineRepository;

    // Run every day at midnight
    @Scheduled(cron = "0 0 0 * * ?")
    public void checkExpiredMedicines() {
        LocalDate today = LocalDate.now();
        List<Medicine> expired = medicineRepository.findByExpiryDateBefore(today);
        for(Medicine m : expired) {
            System.out.println("ALERT: Medicine expired -> " + m.getName() + " (Batch: " + m.getBatchNumber() + ")");
            // In real app, might update status column or notify admin via EmailService
        }
    }
}
