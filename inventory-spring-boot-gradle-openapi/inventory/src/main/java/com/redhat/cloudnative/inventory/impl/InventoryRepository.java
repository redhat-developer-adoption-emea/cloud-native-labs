package com.redhat.cloudnative.inventory.impl;

import org.springframework.data.repository.CrudRepository;

import java.util.List;

public interface InventoryRepository extends CrudRepository<InventoryItemImpl, Integer> {
    public List<InventoryItemImpl> findAll();
    public List<InventoryItemImpl> findByItemId(String itemId);
}
