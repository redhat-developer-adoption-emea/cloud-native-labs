package com.redhat.cloudnative.inventory.impl;

import java.util.List;
import java.util.Spliterator;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

@Service
public class InventoryApiImpl {
    @Bean
    InventoryApiImpl getInventoryApiImpl() {
        return new InventoryApiImpl();
    }

    public List<InventoryItemImpl> inventoryGet(InventoryRepository repository) {
        Spliterator<InventoryItemImpl> items = repository.findAll()
        .spliterator();

        return StreamSupport
                .stream(items, false)
                .collect(Collectors.toList());
    }

    public InventoryItemImpl inventoryItemIdGet(String itemId, InventoryRepository repository) {
        List<InventoryItemImpl> items = repository.findByItemId(itemId);

        return items.size() > 0 ? items.get(0) : null;
    }
   
}