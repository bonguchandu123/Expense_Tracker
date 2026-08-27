package com.expense.tracker.models;

import lombok.Data;
import java.time.LocalDate;
import com.fasterxml.jackson.annotation.JsonProperty;

@Data
public class Transaction {
    private Long id;
    private Double amount;
    private LocalDate date;
    private String type;
    private String description;
    
    @JsonProperty("user_id")
    private Long userId;
    
    @JsonProperty("category_id")
    private Long categoryId;
}
