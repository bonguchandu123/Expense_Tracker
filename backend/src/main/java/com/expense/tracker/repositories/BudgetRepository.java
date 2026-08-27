package com.expense.tracker.repositories;

import com.expense.tracker.models.Budget;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Repository
public class BudgetRepository {

    @Autowired
    private RestTemplate supabaseRestTemplate;

    @Value("${supabase.url}")
    private String supabaseUrl;

    public List<Budget> findByUserIdAndMonthAndYear(Long userId, Integer month, Integer year) {
        String url = supabaseUrl + "/rest/v1/budgets?select=*&user_id=eq." + userId + 
                     "&month=eq." + month + "&year=eq." + year;
        ResponseEntity<List<Budget>> response = supabaseRestTemplate.exchange(
                url,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Budget>>() {}
        );
        return response.getBody();
    }
}
