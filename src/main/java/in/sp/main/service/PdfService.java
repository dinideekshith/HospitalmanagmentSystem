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

    public void exportPrescriptionToPdf(HttpServletResponse response, Prescription p) throws DocumentException, IOException {
        Document document = new Document();
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();
        
        Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 24, java.awt.Color.decode("#008080"));
        Paragraph title = new Paragraph("HOSPITAL CARE", titleFont);
        title.setAlignment(Paragraph.ALIGN_CENTER);
        document.add(title);
        
        Font subTitleFont = FontFactory.getFont(FontFactory.HELVETICA, 12, java.awt.Color.GRAY);
        Paragraph subTitle = new Paragraph("Official Medical Prescription", subTitleFont);
        subTitle.setAlignment(Paragraph.ALIGN_CENTER);
        subTitle.setSpacingAfter(30);
        document.add(subTitle);
        
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10f);
        table.setSpacingAfter(10f);
        
        table.addCell("Patient Name:");
        table.addCell(p.getPatient().getName());
        table.addCell("Doctor Name:");
        table.addCell("Dr. " + p.getDoctor().getName());
        table.addCell("Date:");
        table.addCell(p.getPrescriptionDate().toString());
        table.addCell("Medicine:");
        table.addCell(p.getMedicineName());
        table.addCell("Dosage:");
        table.addCell(p.getDosage());
        table.addCell("Duration:");
        table.addCell(p.getDuration());
        table.addCell("Instructions:");
        table.addCell(p.getInstructions());
        
        document.add(table);
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
