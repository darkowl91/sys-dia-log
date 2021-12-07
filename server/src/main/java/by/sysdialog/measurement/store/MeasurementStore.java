package by.sysdialog.measurement.store;

import by.sysdialog.measurement.model.Measurement;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.time.LocalDateTime;

public interface MeasurementStore {

  Mono<Measurement> create(Measurement measurement);

  Mono<Void> delete(Measurement measurement);

  Flux<Measurement> findByDateFrom(String userId, LocalDateTime dateFrom);
}
