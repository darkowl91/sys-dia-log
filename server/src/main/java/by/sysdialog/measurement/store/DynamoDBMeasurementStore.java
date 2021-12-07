package by.sysdialog.measurement.store;

import by.sysdialog.measurement.model.BloodPressure;
import by.sysdialog.measurement.model.Measurement;
import by.sysdialog.measurement.model.Pulse;
import by.sysdialog.measurement.store.config.StoreProps;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;
import software.amazon.awssdk.enhanced.dynamodb.DynamoDbAsyncTable;
import software.amazon.awssdk.enhanced.dynamodb.DynamoDbEnhancedAsyncClient;
import software.amazon.awssdk.enhanced.dynamodb.Key;
import software.amazon.awssdk.enhanced.dynamodb.TableSchema;
import software.amazon.awssdk.enhanced.dynamodb.mapper.StaticAttributeTags;
import software.amazon.awssdk.enhanced.dynamodb.model.Page;
import software.amazon.awssdk.enhanced.dynamodb.model.QueryConditional;
import software.amazon.awssdk.enhanced.dynamodb.model.QueryEnhancedRequest;

import java.time.LocalDateTime;
import java.time.ZoneOffset;

@Repository
public class DynamoDBMeasurementStore implements MeasurementStore {

  private final DynamoDbAsyncTable<Measurement> table;

  public DynamoDBMeasurementStore(StoreProps props, DynamoDbEnhancedAsyncClient client) {
    this.table = client.table(props.getTable(), schema());
  }

  private static TableSchema<Measurement> schema() {
    return TableSchema.builder(Measurement.class)
        .newItemSupplier(Measurement::new)
        .addAttribute(
            String.class,
            a ->
                a.name("userId")
                    .setter(Measurement::setUserId)
                    .getter(Measurement::getUserId)
                    .addTag(StaticAttributeTags.primaryPartitionKey()))
        .addAttribute(
            LocalDateTime.class,
            a ->
                a.name("timestamp")
                    .setter(Measurement::setCreatedAt)
                    .getter(Measurement::getCreatedAt)
                    .attributeConverter(DynamoDBTimestampAttributeConverter.create())
                    .addTag(StaticAttributeTags.primarySortKey()))
        .flatten(
            TableSchema.builder(BloodPressure.class)
                .newItemSupplier(BloodPressure::new)
                .addAttribute(
                    Integer.class,
                    a ->
                        a.name("diastolic")
                            .setter(BloodPressure::setDiastolic)
                            .getter(BloodPressure::getDiastolic))
                .addAttribute(
                    Integer.class,
                    a ->
                        a.name("systolic")
                            .setter(BloodPressure::setSystolic)
                            .getter(BloodPressure::getSystolic))
                .build(),
            Measurement::getBloodPressure,
            Measurement::setBloodPressure)
        .flatten(
            TableSchema.builder(Pulse.class)
                .newItemSupplier(Pulse::new)
                .addAttribute(
                    Integer.class, a -> a.name("bpm").setter(Pulse::setBpm).getter(Pulse::getBpm))
                .build(),
            Measurement::getPulse,
            Measurement::setPulse)
        .build();
  }

  @Override
  public Mono<Measurement> create(Measurement measurement) {
    return Mono.fromCompletionStage(table.updateItem(measurement));
  }

  @Override
  public Mono<Void> delete(Measurement measurement) {
    return Mono.fromCompletionStage(table.deleteItem(measurement)).then();
  }

  @Override
  public Flux<Measurement> findByDateFrom(String userId, LocalDateTime dateFrom) {
    var key = getKey(userId, dateFrom);

    var request =
        QueryEnhancedRequest.builder()
            .queryConditional(QueryConditional.sortGreaterThanOrEqualTo(key))
            .build();

    return Mono.from(table.query(request)).flatMapIterable(Page::items);
  }

  private Key getKey(String userId, LocalDateTime dateTime) {
    var timestamp = dateTime.toInstant(ZoneOffset.UTC).toEpochMilli();
    return Key.builder().partitionValue(userId).sortValue(timestamp).build();
  }
}
