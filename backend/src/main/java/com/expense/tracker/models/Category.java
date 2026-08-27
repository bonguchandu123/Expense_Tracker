package com.expense.tracker.models;

import lombok.Data;

@Data
public class Category {
    private Long id;
    private String name;
    private String type;
    private String icon;
}
