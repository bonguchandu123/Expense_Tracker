package com.expense.tracker.models;

import lombok.Data;
import com.fasterxml.jackson.annotation.JsonProperty;

@Data
public class Budget {
    private Long id;
    
    @JsonProperty("user_id")
    private Long userId;
    
    @JsonProperty("category_id")
    private Long categoryId;
    
    @JsonProperty("limit_amount")
    private Double limitAmount;
    
    private Integer month;
    private Integer year;
}
