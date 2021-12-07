package by.sysdialog.measurement.handler;

import by.sysdialog.measurement.model.Measurement;
import by.sysdialog.measurement.store.MeasurementStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.beanvalidation.SpringValidatorAdapter;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.server.ServerRequest;
import org.springframework.web.reactive.function.server.ServerResponse;
import org.springframework.web.server.ServerWebInputException;
import reactor.core.publisher.Mono;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.time.temporal.TemporalAccessor;
import java.util.Optional;
import java.util.function.Predicate;

import static org.springframework.web.reactive.function.server.ServerResponse.noContent;
import static org.springframework.web.reactive.function.server.ServerResponse.ok;

@Component
public class MeasurementHandler {

  private final MeasurementStore measurementStore;
  private final SpringValidatorAdapter measurementValidator;

  @Autowired
  public MeasurementHandler(
      MeasurementStore measurementStore, SpringValidatorAdapter measurementValidator) {
    this.measurementStore = measurementStore;
    this.measurementValidator = measurementValidator;
  }

  public Mono<ServerResponse> create(ServerRequest req) {
    return req.principal()
        .flatMap(
            principal ->
                req.bodyToMono(Measurement.class)
                    .map(
                        measurement -> {
                          measurement.setUserId(principal.getName());
                          measurement.setCreatedAt(LocalDateTime.now(ZoneOffset.UTC));
                          return measurement;
                        })
                    .doOnNext(this::validate)
                    .map(measurementStore::create)
                    .flatMap(m -> ok().body(BodyInserters.fromProducer(m, Measurement.class))));
  }

  public Mono<ServerResponse> delete(ServerRequest req) {
    var prmId =
        Optional.of(req.pathVariable("id"))
            .filter(Predicate.not(String::isBlank))
            .map(s -> tryParse(DateTimeFormatter.ISO_LOCAL_DATE_TIME, s))
            .map(LocalDateTime::from)
            .orElseThrow(() -> new ServerWebInputException("invalid id parameter"));

    return req.principal()
        .map(
            principal -> {
              Measurement measurement = new Measurement();
              measurement.setUserId(principal.getName());
              measurement.setCreatedAt(prmId);
              return measurement;
            })
        .doOnNext(this::validate)
        .map(measurementStore::delete)
        .then(noContent().build());
  }

  public Mono<ServerResponse> findByDateFrom(ServerRequest req) {
    var prmDateFrom =
        req.queryParam("dateFrom")
            .filter(Predicate.not(String::isBlank))
            .map(s -> tryParse(DateTimeFormatter.ISO_LOCAL_DATE, s))
            .map(LocalDate::from)
            .map(LocalDate::atStartOfDay)
            .orElseThrow(() -> new ServerWebInputException("invalid dateFrom parameter"));

    return req.principal()
        .map(principal -> measurementStore.findByDateFrom(principal.getName(), prmDateFrom))
        .flatMap(f -> ok().body(BodyInserters.fromProducer(f, Measurement.class)));
  }

  private void validate(Measurement measurement) {
    Errors errors = new BeanPropertyBindingResult(measurement, "measurement");
    ValidationUtils.invokeValidator(measurementValidator, measurement, errors);
    if (errors.hasErrors()) {
      throw new ServerWebInputException(errors.toString());
    }
  }

  private TemporalAccessor tryParse(DateTimeFormatter formatter, String input) {
    try {
      return formatter.parse(input);
    } catch (DateTimeParseException ex) {
      return null;
    }
  }
}
