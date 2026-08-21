package in.sp.main.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "blood_inventory")
public class BloodInventory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String bloodGroup;

    @Column(nullable = false)
    private int unitsAvailable;

    private LocalDateTime lastUpdated;

    public BloodInventory() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getBloodGroup() { return bloodGroup; }
    public void setBloodGroup(String bloodGroup) { this.bloodGroup = bloodGroup; }
    public int getUnitsAvailable() { return unitsAvailable; }
    public void setUnitsAvailable(int unitsAvailable) { this.unitsAvailable = unitsAvailable; }
    public LocalDateTime getLastUpdated() { return lastUpdated; }
    public void setLastUpdated(LocalDateTime lastUpdated) { this.lastUpdated = lastUpdated; }
}
