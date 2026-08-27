package com.expense.tracker.controllers;

import com.expense.tracker.dto.DashboardDTO;
import com.expense.tracker.services.FinancialService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/dashboard")
@CrossOrigin(origins = "*")
public class DashboardController {

    @Autowired
    private FinancialService financialService;

    @GetMapping("/{userId}")
    public ResponseEntity<DashboardDTO> getDashboard(
            @PathVariable Long userId,
            @RequestParam Integer month,
            @RequestParam Integer year) {
        
        DashboardDTO dashboard = financialService.getDashboard(userId, month, year);
        return ResponseEntity.ok(dashboard);
    }
}
