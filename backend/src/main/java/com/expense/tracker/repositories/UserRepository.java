package com.expense.tracker.repositories;

import com.expense.tracker.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.web.client.RestTemplate;

import java.util.List;
import java.util.Optional;

@Repository
public class UserRepository {

    @Autowired
    private RestTemplate supabaseRestTemplate;

    @Value("${supabase.url}")
    private String supabaseUrl;

    public Optional<User> findByEmail(String email) {
        String url = supabaseUrl + "/rest/v1/users?select=*&email=eq." + email;
        ResponseEntity<List<User>> response = supabaseRestTemplate.exchange(
                url,
                HttpMethod.GET,
                null,
                new ParameterizedTypeReference<List<User>>() {}
        );
        List<User> list = response.getBody();
        return list != null && !list.isEmpty() ? Optional.of(list.get(0)) : Optional.empty();
    }
}
