package in.sp.main.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "emergency_requests")
public class EmergencyRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "patient_id")
    private Patient patient;

    @Column(nullable = false)
    private LocalDateTime requestTime;

    @Column(nullable = false)
    private String status; // CREATED, AMBULANCE_ASSIGNED, ON_THE_WAY, PATIENT_ARRIVED, DOCTOR_ASSIGNED, BED_ASSIGNED, COMPLETED

    @ManyToOne
    @JoinColumn(name = "ambulance_id")
    private Ambulance assignedAmbulance;

    @ManyToOne
    @JoinColumn(name = "doctor_id")
    private Doctor assignedDoctor;

    @ManyToOne
    @JoinColumn(name = "bed_id")
    private Bed assignedBed;

    private String patientBloodGroup; // If fetched quickly from patient profile

    public EmergencyRequest() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Patient getPatient() { return patient; }
    public void setPatient(Patient patient) { this.patient = patient; }
    public LocalDateTime getRequestTime() { return requestTime; }
    public void setRequestTime(LocalDateTime requestTime) { this.requestTime = requestTime; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Ambulance getAssignedAmbulance() { return assignedAmbulance; }
    public void setAssignedAmbulance(Ambulance assignedAmbulance) { this.assignedAmbulance = assignedAmbulance; }
    public Doctor getAssignedDoctor() { return assignedDoctor; }
    public void setAssignedDoctor(Doctor assignedDoctor) { this.assignedDoctor = assignedDoctor; }
    public Bed getAssignedBed() { return assignedBed; }
    public void setAssignedBed(Bed assignedBed) { this.assignedBed = assignedBed; }
    public String getPatientBloodGroup() { return patientBloodGroup; }
    public void setPatientBloodGroup(String patientBloodGroup) { this.patientBloodGroup = patientBloodGroup; }
}
