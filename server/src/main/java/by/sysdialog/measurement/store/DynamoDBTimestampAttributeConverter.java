package by.sysdialog.measurement.store;

import software.amazon.awssdk.enhanced.dynamodb.AttributeConverter;
import software.amazon.awssdk.enhanced.dynamodb.AttributeValueType;
import software.amazon.awssdk.enhanced.dynamodb.EnhancedType;
import software.amazon.awssdk.enhanced.dynamodb.internal.AttributeValues;
import software.amazon.awssdk.services.dynamodb.model.AttributeValue;

import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;

class DynamoDBTimestampAttributeConverter implements AttributeConverter<LocalDateTime> {

  private DynamoDBTimestampAttributeConverter() {
    super();
  }

  public static DynamoDBTimestampAttributeConverter create() {
    return new DynamoDBTimestampAttributeConverter();
  }

  @Override
  public AttributeValue transformFrom(LocalDateTime input) {
    return AttributeValues.numberValue(toEpoch(input));
  }

  @Override
  public LocalDateTime transformTo(AttributeValue input) {
    return toUtcDateTime(input.n());
  }

  @Override
  public EnhancedType<LocalDateTime> type() {
    return EnhancedType.of(LocalDateTime.class);
  }

  @Override
  public AttributeValueType attributeValueType() {
    return AttributeValueType.N;
  }

  private LocalDateTime toUtcDateTime(String value) {
    return LocalDateTime.ofInstant(Instant.ofEpochMilli(Long.parseLong(value)), ZoneOffset.UTC);
  }

  private long toEpoch(LocalDateTime dateTime) {
    return dateTime.toInstant(ZoneOffset.UTC).toEpochMilli();
  }
}
