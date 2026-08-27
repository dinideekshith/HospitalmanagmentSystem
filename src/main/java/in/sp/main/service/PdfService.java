package in.sp.main.service;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import in.sp.main.entity.MedicalRecord;
import in.sp.main.entity.Prescription;
import org.springframework.stereotype.Service;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@Service
public class PdfService {

    @org.springframework.beans.factory.annotation.Autowired
    private in.sp.main.repository.DoctorRepository doctorRepository;
    
    @org.springframework.beans.factory.annotation.Autowired
    private in.sp.main.repository.PatientRepository patientRepository;

    public void exportPrescriptionToPdf(HttpServletResponse response, Prescription p) throws DocumentException, IOException {
        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();
        
        in.sp.main.entity.Doctor doctorInfo = doctorRepository.findById(p.getDoctor().getId()).orElse(null);
        in.sp.main.entity.Patient patientInfo = patientRepository.findById(p.getPatient().getId()).orElse(null);
        
        // Header Table
        PdfPTable headerTable = new PdfPTable(3);
        headerTable.setWidthPercentage(100);
        headerTable.setWidths(new float[]{4f, 2f, 4f});
        
        Font doctorNameFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, java.awt.Color.decode("#008080"));
        Font smallFont = FontFactory.getFont(FontFactory.HELVETICA, 10, java.awt.Color.DARK_GRAY);
        
        String qualifications = doctorInfo != null && doctorInfo.getQualification() != null ? doctorInfo.getQualification() : "M.B.B.S, M.D.";
        
        // Left - Doctor details
        com.lowagie.text.pdf.PdfPCell leftCell = new com.lowagie.text.pdf.PdfPCell();
        leftCell.setBorder(com.lowagie.text.Rectangle.NO_BORDER);
        leftCell.addElement(new Paragraph("Dr. " + p.getDoctor().getName(), doctorNameFont));
        leftCell.addElement(new Paragraph(qualifications + " | Reg. No: " + (10000 + p.getDoctor().getId()), smallFont));
        leftCell.addElement(new Paragraph("Mob. No: " + p.getDoctor().getMobileNumber(), smallFont));
        headerTable.addCell(leftCell);
        
        // Center - Logo placeholder
        com.lowagie.text.pdf.PdfPCell centerCell = new com.lowagie.text.pdf.PdfPCell(new Paragraph("HOSPITAL CARE\nLOGO", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, java.awt.Color.decode("#2E8B57"))));
        centerCell.setBorder(com.lowagie.text.Rectangle.NO_BORDER);
        centerCell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        headerTable.addCell(centerCell);
        
        // Right - Clinic details
        com.lowagie.text.pdf.PdfPCell rightCell = new com.lowagie.text.pdf.PdfPCell();
        rightCell.setBorder(com.lowagie.text.Rectangle.NO_BORDER);
        rightCell.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_RIGHT);
        rightCell.addElement(new Paragraph("Hospital Care Clinic", doctorNameFont));
        rightCell.addElement(new Paragraph("Timing: 09:00 AM - 05:00 PM", smallFont));
        headerTable.addCell(rightCell);
        
        document.add(headerTable);
        
        // Horizontal Line
        document.add(new Paragraph("______________________________________________________________________________"));
        document.add(new Paragraph(" "));
        
        // Patient Info
        PdfPTable patientTable = new PdfPTable(2);
        patientTable.setWidthPercentage(100);
        patientTable.setWidths(new float[]{7f, 3f});
        
        com.lowagie.text.pdf.PdfPCell pLeft = new com.lowagie.text.pdf.PdfPCell();
        pLeft.setBorder(com.lowagie.text.Rectangle.NO_BORDER);
        Font boldSmall = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10);
        
        String gender = patientInfo != null && patientInfo.getGender() != null && !patientInfo.getGender().isEmpty() ? patientInfo.getGender() : "U";
        String address = patientInfo != null && patientInfo.getAddress() != null && !patientInfo.getAddress().isEmpty() ? patientInfo.getAddress() : "Not Provided";
        
        pLeft.addElement(new Paragraph("ID: " + p.getPatient().getId() + " - " + p.getPatient().getName().toUpperCase() + " (" + gender.substring(0, 1) + ")", boldSmall));
        pLeft.addElement(new Paragraph("Address: " + address, smallFont));
        pLeft.addElement(new Paragraph("Temp (deg): 37, BP: 120/80 mmHg", smallFont));
        patientTable.addCell(pLeft);
        
        com.lowagie.text.pdf.PdfPCell pRight = new com.lowagie.text.pdf.PdfPCell(new Paragraph("Date: " + p.getPrescriptionDate().toString(), boldSmall));
        pRight.setBorder(com.lowagie.text.Rectangle.NO_BORDER);
        pRight.setHorizontalAlignment(com.lowagie.text.Element.ALIGN_RIGHT);
        patientTable.addCell(pRight);
        
        document.add(patientTable);
        
        // Title
        Paragraph title = new Paragraph("PRESCRIPTION", FontFactory.getFont(FontFactory.HELVETICA, 16));
        title.setAlignment(com.lowagie.text.Element.ALIGN_CENTER);
        title.setSpacingBefore(15);
        title.setSpacingAfter(15);
        document.add(title);
        
        // Rx
        document.add(new Paragraph("Rx", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14)));
        document.add(new Paragraph(" "));
        
        // Medicine Table
        PdfPTable medTable = new PdfPTable(3);
        medTable.setWidthPercentage(100);
        medTable.setWidths(new float[]{4f, 3f, 3f});
        
        com.lowagie.text.pdf.PdfPCell h1 = new com.lowagie.text.pdf.PdfPCell(new Paragraph("Medicine Name", boldSmall));
        h1.setBorder(com.lowagie.text.Rectangle.BOTTOM);
        com.lowagie.text.pdf.PdfPCell h2 = new com.lowagie.text.pdf.PdfPCell(new Paragraph("Dosage", boldSmall));
        h2.setBorder(com.lowagie.text.Rectangle.BOTTOM);
        com.lowagie.text.pdf.PdfPCell h3 = new com.lowagie.text.pdf.PdfPCell(new Paragraph("Duration", boldSmall));
        h3.setBorder(com.lowagie.text.Rectangle.BOTTOM);
        
        medTable.addCell(h1);
        medTable.addCell(h2);
        medTable.addCell(h3);
        
        com.lowagie.text.pdf.PdfPCell c1 = new com.lowagie.text.pdf.PdfPCell(new Paragraph("1) " + p.getMedicineName(), boldSmall));
        c1.setBorder(com.lowagie.text.Rectangle.BOTTOM);
        c1.setPaddingTop(10);
        c1.setPaddingBottom(10);
        
        // Parse dosage nicely if possible
        String displayDosage = p.getDosage();
        if (displayDosage != null && displayDosage.contains("-")) {
            String[] parts = displayDosage.split("-");
            if(parts.length == 3) {
                displayDosage = parts[0] + " Morning, " + parts[1] + " Aft, " + parts[2] + " Night";
            }
        }
        
        com.lowagie.text.pdf.PdfPCell c2 = new com.lowagie.text.pdf.PdfPCell(new Paragraph(displayDosage, smallFont));
        c2.setBorder(com.lowagie.text.Rectangle.BOTTOM);
        c2.setPaddingTop(10);
        
        com.lowagie.text.pdf.PdfPCell c3 = new com.lowagie.text.pdf.PdfPCell(new Paragraph(p.getDuration(), smallFont));
        c3.setBorder(com.lowagie.text.Rectangle.BOTTOM);
        c3.setPaddingTop(10);
        
        medTable.addCell(c1);
        medTable.addCell(c2);
        medTable.addCell(c3);
        
        document.add(medTable);
        
        // Footer Advice
        document.add(new Paragraph(" "));
        document.add(new Paragraph("Advice Given:", boldSmall));
        document.add(new Paragraph("* " + (p.getInstructions() != null ? p.getInstructions() : "Please complete the full course."), smallFont));
        
        document.close();
    }
    
    public void exportMedicalRecordToPdf(HttpServletResponse response, MedicalRecord record) throws DocumentException, IOException {
        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();
        
        Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 24, java.awt.Color.decode("#008080"));
        Paragraph title = new Paragraph("HOSPITAL CARE", titleFont);
        title.setAlignment(Paragraph.ALIGN_CENTER);
        document.add(title);
        
        Font subTitleFont = FontFactory.getFont(FontFactory.HELVETICA, 12, java.awt.Color.GRAY);
        Paragraph subTitle = new Paragraph("Official Medical Record", subTitleFont);
        subTitle.setAlignment(Paragraph.ALIGN_CENTER);
        subTitle.setSpacingAfter(30);
        document.add(subTitle);
        
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(10f);
        
        table.addCell("Patient Name:");
        table.addCell(record.getPatient().getName());
        table.addCell("Doctor Name:");
        table.addCell("Dr. " + record.getDoctor().getName());
        table.addCell("Date:");
        table.addCell(record.getRecordDate().toString());
        table.addCell("Diagnosis:");
        table.addCell(record.getDiagnosis());
        table.addCell("Symptoms:");
        table.addCell(record.getSymptoms());
        table.addCell("Treatment:");
        table.addCell(record.getTreatment());
        
        document.add(table);
        document.close();
    }
}
