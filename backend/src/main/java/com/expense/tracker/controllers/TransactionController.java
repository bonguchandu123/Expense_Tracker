package com.expense.tracker.controllers;

import com.expense.tracker.models.Transaction;
import com.expense.tracker.repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/transactions")
@CrossOrigin(origins = "*")
public class TransactionController {

    @Autowired
    private TransactionRepository transactionRepository;

    @GetMapping("/{userId}")
    public ResponseEntity<List<Transaction>> getTransactions(@PathVariable Long userId) {
        return ResponseEntity.ok(transactionRepository.findByUserId(userId));
    }
    
    @PostMapping("/")
    public ResponseEntity<Transaction> addTransaction(@RequestBody Transaction transaction) {
        return ResponseEntity.ok(transactionRepository.save(transaction));
    }
}
