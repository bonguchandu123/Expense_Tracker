package com.expense.tracker.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.ClientHttpRequestInterceptor;
import org.springframework.web.client.RestTemplate;

import java.util.ArrayList;
import java.util.List;

@Configuration
public class SupabaseConfig {

    @Value("${supabase.url}")
    private String supabaseUrl;

    @Value("${supabase.service.key}")
    private String supabaseKey;

    @Bean
    public RestTemplate supabaseRestTemplate() {
        RestTemplate restTemplate = new RestTemplate();
        List<ClientHttpRequestInterceptor> interceptors = restTemplate.getInterceptors();
        if (interceptors == null) {
            interceptors = new ArrayList<>();
        }
        interceptors.add((request, body, execution) -> {
            request.getHeaders().add("apikey", supabaseKey);
            request.getHeaders().add("Authorization", "Bearer " + supabaseKey);
            request.getHeaders().add("Content-Type", "application/json");
            request.getHeaders().add("Prefer", "return=representation");
            return execution.execute(request, body);
        });
        restTemplate.setInterceptors(interceptors);
        return restTemplate;
    }
}
