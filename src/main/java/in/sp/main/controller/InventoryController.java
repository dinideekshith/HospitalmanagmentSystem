package in.sp.main.controller;

import in.sp.main.entity.Medicine;
import in.sp.main.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;

@Controller
public class InventoryController {

    @Autowired
    private MedicineRepository medicineRepository;

    @GetMapping("/admin/inventory")
    public String viewInventory(Model model) {
        model.addAttribute("medicines", medicineRepository.findAll());
        return "admin/inventory";
    }

    @PostMapping("/admin/inventory/add")
    public String addMedicine(@RequestParam String name, @RequestParam String batchNumber,
                              @RequestParam int quantity, @RequestParam int minStock,
                              @RequestParam String expiryDate, @RequestParam double price) {
        Medicine m = new Medicine();
        m.setName(name);
        m.setBatchNumber(batchNumber);
        m.setQuantity(quantity);
        m.setMinStock(minStock);
        m.setExpiryDate(LocalDate.parse(expiryDate));
        m.setPrice(price);
        medicineRepository.save(m);
        return "redirect:/admin/inventory?success";
    }
}
