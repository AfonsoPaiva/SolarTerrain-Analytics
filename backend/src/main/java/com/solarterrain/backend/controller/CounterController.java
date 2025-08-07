package com.solarterrain.backend.controller;

import com.solarterrain.backend.model.Counter;
import com.solarterrain.backend.service.FirebaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.concurrent.CompletableFuture;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = { "http://localhost:3000", "http://localhost:19006" })
public class CounterController {

    @Autowired
    private FirebaseService firebaseService;

    @GetMapping("/counter")
    public CompletableFuture<ResponseEntity<Counter>> getCounter() {
        return firebaseService.getCounter()
                .thenApply(counter -> ResponseEntity.ok(counter))
                .exceptionally(throwable -> ResponseEntity.internalServerError().build());
    }

    @PostMapping("/counter/increment")
    public CompletableFuture<ResponseEntity<Counter>> incrementCounter() {
        return firebaseService.incrementCounter()
                .thenApply(counter -> ResponseEntity.ok(counter))
                .exceptionally(throwable -> ResponseEntity.internalServerError().build());
    }
}
