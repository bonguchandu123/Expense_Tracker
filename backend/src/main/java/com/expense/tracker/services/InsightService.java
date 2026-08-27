package com.expense.tracker.services;

import com.expense.tracker.dto.BudgetStatusDTO;
import com.expense.tracker.dto.InsightDTO;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class InsightService {

    public List<InsightDTO> generateInsights(Double income, Double expenses, List<BudgetStatusDTO> budgetStatuses) {
        List<InsightDTO> insights = new ArrayList<>();
        
        // Basic Rule-based AI Engine
        if (expenses > income) {
            insights.add(new InsightDTO("WARNING", "You have spent more than your income this month!"));
        } else if (income > 0 && (expenses / income) > 0.8) {
            insights.add(new InsightDTO("INFO", "You have used more than 80% of your income. Consider saving more."));
        }
        
        for (BudgetStatusDTO b : budgetStatuses) {
            if ("OVER BUDGET".equals(b.getStatus())) {
                double exceeded = b.getSpentAmount() - b.getLimitAmount();
                insights.add(new InsightDTO("WARNING", "You have exceeded your " + b.getCategory().getName() + " budget by ₹" + exceeded + "."));
            }
        }
        
        if (insights.isEmpty()) {
            insights.add(new InsightDTO("SUCCESS", "You are doing great! All your expenses are within the budget."));
        }
        
        return insights;
    }
}
