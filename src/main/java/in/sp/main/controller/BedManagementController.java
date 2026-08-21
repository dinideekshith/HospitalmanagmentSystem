package in.sp.main.controller;

import in.sp.main.entity.Bed;
import in.sp.main.entity.Room;
import in.sp.main.repository.BedRepository;
import in.sp.main.repository.RoomRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class BedManagementController {

    @Autowired
    private RoomRepository roomRepository;

    @Autowired
    private BedRepository bedRepository;

    @GetMapping("/admin/beds")
    public String viewBeds(Model model) {
        model.addAttribute("rooms", roomRepository.findAll());
        model.addAttribute("beds", bedRepository.findAll());
        return "admin/beds";
    }

    @PostMapping("/admin/rooms/add")
    public String addRoom(@RequestParam String roomNumber, @RequestParam String roomType, @RequestParam int capacity) {
        Room r = new Room();
        r.setRoomNumber(roomNumber);
        r.setRoomType(roomType);
        r.setCapacity(capacity);
        roomRepository.save(r);
        return "redirect:/admin/beds?roomAdded";
    }

    @PostMapping("/admin/beds/add")
    public String addBed(@RequestParam String bedNumber, @RequestParam Long roomId) {
        Room r = roomRepository.findById(roomId).orElse(null);
        if (r != null) {
            Bed b = new Bed();
            b.setBedNumber(bedNumber);
            b.setRoom(r);
            b.setStatus("AVAILABLE");
            bedRepository.save(b);
        }
        return "redirect:/admin/beds?bedAdded";
    }
}
