package com.expense.tracker.services;

import com.expense.tracker.dto.BudgetStatusDTO;
import com.expense.tracker.dto.DashboardDTO;
import com.expense.tracker.dto.InsightDTO;
import com.expense.tracker.models.Budget;
import com.expense.tracker.models.Category;
import com.expense.tracker.models.Transaction;
import com.expense.tracker.repositories.BudgetRepository;
import com.expense.tracker.repositories.CategoryRepository;
import com.expense.tracker.repositories.TransactionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class FinancialService {

    @Autowired
    private TransactionRepository transactionRepository;

    @Autowired
    private BudgetRepository budgetRepository;
    
    @Autowired
    private CategoryRepository categoryRepository;
    
    @Autowired
    private InsightService insightService;

    public DashboardDTO getDashboard(Long userId, Integer month, Integer year) {
        // Fetch all user transactions and filter in memory for simplicity 
        // (Supabase allows date filtering, but this avoids timezone/string format parsing complexities)
        List<Transaction> allTransactions = transactionRepository.findByUserId(userId);
        
        Double totalIncome = 0.0;
        Double totalExpenses = 0.0;
        List<Transaction> monthlyTransactions = new ArrayList<>();
        
        for (Transaction t : allTransactions) {
            LocalDate date = t.getDate();
            if (date != null && date.getMonthValue() == month && date.getYear() == year) {
                monthlyTransactions.add(t);
                if ("INCOME".equalsIgnoreCase(t.getType())) {
                    totalIncome += t.getAmount();
                } else if ("EXPENSE".equalsIgnoreCase(t.getType())) {
                    totalExpenses += t.getAmount();
                }
            }
        }
        
        List<Budget> budgets = budgetRepository.findByUserIdAndMonthAndYear(userId, month, year);
        List<BudgetStatusDTO> budgetStatuses = new ArrayList<>();
        
        for (Budget b : budgets) {
            // Calculate spent amount for this category in the month
            Double spent = 0.0;
            for (Transaction t : monthlyTransactions) {
                if (t.getCategoryId() != null && t.getCategoryId().equals(b.getCategoryId())) {
                    spent += t.getAmount();
                }
            }
            
            BudgetStatusDTO statusDTO = new BudgetStatusDTO();
            Optional<Category> categoryOpt = categoryRepository.findById(b.getCategoryId());
            statusDTO.setCategory(categoryOpt.orElse(null));
            statusDTO.setLimitAmount(b.getLimitAmount());
            statusDTO.setSpentAmount(spent);
            
            if (spent >= b.getLimitAmount()) {
                statusDTO.setStatus("OVER BUDGET");
            } else if (spent >= b.getLimitAmount() * 0.8) {
                statusDTO.setStatus("WARNING");
            } else {
                statusDTO.setStatus("SAFE");
            }
            budgetStatuses.add(statusDTO);
        }
        
        DashboardDTO dashboard = new DashboardDTO();
        dashboard.setTotalIncome(totalIncome);
        dashboard.setTotalExpenses(totalExpenses);
        dashboard.setBalance(totalIncome - totalExpenses);
        dashboard.setBudgetStatuses(budgetStatuses);
        dashboard.setPersonalizedInsights(insightService.generateInsights(totalIncome, totalExpenses, budgetStatuses));
        
        return dashboard;
    }
}
