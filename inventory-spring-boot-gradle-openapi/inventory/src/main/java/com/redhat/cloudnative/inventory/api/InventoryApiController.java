package com.redhat.cloudnative.inventory.api;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.context.request.NativeWebRequest;

import io.micrometer.core.instrument.Metrics;

import java.util.List;
import java.util.Optional;

import com.redhat.cloudnative.inventory.impl.DataMapper;
import com.redhat.cloudnative.inventory.impl.InventoryApiImpl;
import com.redhat.cloudnative.inventory.impl.InventoryRepository;
import com.redhat.cloudnative.inventory.model.InventoryItem;
@javax.annotation.Generated(value = "org.openapitools.codegen.languages.SpringCodegen", date = "2019-02-24T17:36:36.165+01:00[Europe/Madrid]")

@Controller
@RequestMapping("${openapi.inventory.base-path:/api}")
public class InventoryApiController implements InventoryApi {

    private final NativeWebRequest request;

    @Autowired
    private InventoryRepository inventoryRepository;

    @Autowired
    private InventoryApiImpl inventoryApiImpl;

    @Autowired
    public InventoryApiController(NativeWebRequest request) {
        this.request = request;
    }

    @Override
    public Optional<NativeWebRequest> getRequest() {
        return Optional.ofNullable(request);
    }

    @Override
    public ResponseEntity<InventoryItem> inventoryItemIdGet(String itemId) {
        Metrics.counter("api.http.requests.total", "api", "inventory", "method", "GET", "endpoint", "/inventory/" + itemId).increment();

        InventoryItem item = DataMapper.toInventoryItem(inventoryApiImpl.inventoryItemIdGet(itemId, inventoryRepository));

        if (item == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);    
        }

        return new ResponseEntity<>(item, HttpStatus.OK);
    }

    @Override
    public ResponseEntity<List<InventoryItem>> inventoryGet() {
        Metrics.counter("api.http.requests.total", "api", "inventory", "method", "GET", "endpoint", "/inventory").increment();
        
        List<InventoryItem> items = DataMapper.toInventoryItemList(inventoryApiImpl.inventoryGet(inventoryRepository));
        return new ResponseEntity<>(items, HttpStatus.OK);
    }
}
