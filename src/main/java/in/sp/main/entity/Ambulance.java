package in.sp.main.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "ambulances")
public class Ambulance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String vehicleNumber;

    private String driverName;
    private String driverContact;

    @Column(nullable = false)
    private String status; // AVAILABLE, ASSIGNED, ON_THE_WAY, PATIENT_PICKED, ARRIVED, MAINTENANCE

    public Ambulance() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getVehicleNumber() { return vehicleNumber; }
    public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }
    public String getDriverName() { return driverName; }
    public void setDriverName(String driverName) { this.driverName = driverName; }
    public String getDriverContact() { return driverContact; }
    public void setDriverContact(String driverContact) { this.driverContact = driverContact; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
