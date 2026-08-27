package com.expense.tracker.repositories;

import com.expense.tracker.models.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@Repository
public class TransactionRepository {

    @Autowired
    private RestTemplate supabaseRestTemplate;

    @Value("${supabase.url}")
    private String supabaseUrl;

    public List<Transaction> findByUserId(Long userId) {
        String url = supabaseUrl + "/rest/v1/transactions?select=*&user_id=eq." + userId;
        ResponseEntity<List<Transaction>> response = supabaseRestTemplate.exchange(
                url,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Transaction>>() {}
        );
        return response.getBody();
    }
    
    // For MVP, filtering by month/year via REST can be complex due to date parsing.
    // A simple workaround is to fetch all for the user and filter in the service layer,
    // or use Supabase PostgREST gte/lte filters.
    public List<Transaction> findByUserIdAndDateBetween(Long userId, String startDate, String endDate) {
        String url = supabaseUrl + "/rest/v1/transactions?select=*&user_id=eq." + userId + 
                     "&date=gte." + startDate + "&date=lte." + endDate;
        ResponseEntity<List<Transaction>> response = supabaseRestTemplate.exchange(
                url,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<Transaction>>() {}
        );
        return response.getBody();
    }

    public Transaction save(Transaction transaction) {
        String url = supabaseUrl + "/rest/v1/transactions";
        ResponseEntity<List<Transaction>> response = supabaseRestTemplate.exchange(
                url,
                HttpMethod.POST,
                new org.springframework.http.HttpEntity<>(transaction),
                new ParameterizedTypeReference<List<Transaction>>() {}
        );
        return response.getBody() != null && !response.getBody().isEmpty() ? response.getBody().get(0) : null;
    }
}
