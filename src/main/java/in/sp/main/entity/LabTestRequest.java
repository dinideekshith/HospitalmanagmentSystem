package in.sp.main.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "lab_test_requests")
public class LabTestRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "patient_id", nullable = false)
    private User patient;

    @ManyToOne
    @JoinColumn(name = "doctor_id", nullable = false)
    private User doctor;

    private String testName;
    private LocalDate requestDate;
    
    // Advanced fields
    private String status; // REQUESTED, SAMPLE_COLLECTED, IN_PROGRESS, COMPLETED, CANCELLED
    private String sampleCollectionStatus; // PENDING, COLLECTED
    private String testStatus; // PENDING, PROCESSING, READY
    
    @Column(columnDefinition = "TEXT")
    private String results;
    
    private String reportUrl;
    private LocalDate completionDate;

    public LabTestRequest() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public User getPatient() { return patient; }
    public void setPatient(User patient) { this.patient = patient; }
    public User getDoctor() { return doctor; }
    public void setDoctor(User doctor) { this.doctor = doctor; }
    public String getTestName() { return testName; }
    public void setTestName(String testName) { this.testName = testName; }
    public LocalDate getRequestDate() { return requestDate; }
    public void setRequestDate(LocalDate requestDate) { this.requestDate = requestDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getResults() { return results; }
    public void setResults(String results) { this.results = results; }
    public String getSampleCollectionStatus() { return sampleCollectionStatus; }
    public void setSampleCollectionStatus(String sampleCollectionStatus) { this.sampleCollectionStatus = sampleCollectionStatus; }
    public String getTestStatus() { return testStatus; }
    public void setTestStatus(String testStatus) { this.testStatus = testStatus; }
    public String getReportUrl() { return reportUrl; }
    public void setReportUrl(String reportUrl) { this.reportUrl = reportUrl; }
    public LocalDate getCompletionDate() { return completionDate; }
    public void setCompletionDate(LocalDate completionDate) { this.completionDate = completionDate; }
}
