package com.redhat.cloudnative.inventory.impl;

import java.util.List;
import java.util.stream.Collectors;

import com.redhat.cloudnative.inventory.model.InventoryItem;

public class DataMapper {
    public static InventoryItem toInventoryItem (InventoryItemImpl from) {
        if (from == null) {
            return null;
        }

        InventoryItem to = new InventoryItem();
        to.setItemId(from.getItemId());
        to.setQuantity(from.getQuantity());

        return to;
    }

    public static List<InventoryItem> toInventoryItemList (List<InventoryItemImpl> from) {
        return from.stream()
                   .map(item -> toInventoryItem(item))
                   .collect(Collectors.toList());
    }
}