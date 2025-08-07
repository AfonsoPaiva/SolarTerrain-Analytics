package com.solarterrain.backend.service;

import com.solarterrain.backend.model.Counter;
import org.springframework.stereotype.Service;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.atomic.AtomicInteger;

@Service
public class FirebaseService {

    private AtomicInteger localCounter = new AtomicInteger(0);

    public FirebaseService() {
        System.out.println("Serviço iniciado com contador local para desenvolvimento");
    }

    public CompletableFuture<Counter> getCounter() {
        CompletableFuture<Counter> future = new CompletableFuture<>();
        Counter counter = new Counter("counter", localCounter.get());
        future.complete(counter);
        return future;
    }

    public CompletableFuture<Counter> incrementCounter() {
        CompletableFuture<Counter> future = new CompletableFuture<>();
        int newValue = localCounter.incrementAndGet();
        Counter counter = new Counter("counter", newValue);
        future.complete(counter);
        return future;
    }
}
