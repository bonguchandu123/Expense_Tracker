package com.expense.tracker.dto;

import lombok.Data;
import lombok.AllArgsConstructor;

@Data
@AllArgsConstructor
public class InsightDTO {
    private String type; // "WARNING", "INFO", "SUCCESS"
    private String message;
}
