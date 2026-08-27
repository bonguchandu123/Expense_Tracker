package com.expense.tracker.dto;

import lombok.Data;
import java.util.List;

@Data
public class DashboardDTO {
    private Double totalIncome;
    private Double totalExpenses;
    private Double balance;
    private List<BudgetStatusDTO> budgetStatuses;
    private List<InsightDTO> personalizedInsights;
}
