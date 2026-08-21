package in.sp.main.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "beds")
public class Bed {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String bedNumber;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private Room room;

    @Column(nullable = false)
    private String status; // AVAILABLE, OCCUPIED, MAINTENANCE

    @OneToOne
    @JoinColumn(name = "patient_id")
    private Patient assignedPatient;

    public Bed() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getBedNumber() { return bedNumber; }
    public void setBedNumber(String bedNumber) { this.bedNumber = bedNumber; }
    public Room getRoom() { return room; }
    public void setRoom(Room room) { this.room = room; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Patient getAssignedPatient() { return assignedPatient; }
    public void setAssignedPatient(Patient assignedPatient) { this.assignedPatient = assignedPatient; }
}
