package com.expense.tracker.dto;

import lombok.Data;
import com.expense.tracker.models.Category;

@Data
public class BudgetStatusDTO {
    private Category category;
    private Double limitAmount;
    private Double spentAmount;
    private String status; // "SAFE", "WARNING", "OVER BUDGET"
}
