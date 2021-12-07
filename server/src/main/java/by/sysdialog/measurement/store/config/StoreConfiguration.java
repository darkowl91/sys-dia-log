package by.sysdialog.measurement.store.config;

import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import software.amazon.awssdk.auth.credentials.AwsCredentialsProvider;
import software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider;
import software.amazon.awssdk.enhanced.dynamodb.DynamoDbEnhancedAsyncClient;
import software.amazon.awssdk.services.dynamodb.DynamoDbAsyncClient;
import software.amazon.awssdk.services.dynamodb.DynamoDbAsyncClientBuilder;

import java.util.Optional;

@Configuration
@EnableConfigurationProperties(StoreProps.class)
public class StoreConfiguration {

  @Bean
  public DynamoDbEnhancedAsyncClient dynamoDbEnhancedAsyncClient(DynamoDbAsyncClient client) {
    return DynamoDbEnhancedAsyncClient.builder().dynamoDbClient(client).build();
  }

  @Bean
  public DynamoDbAsyncClient dynamoDbAsyncClient(
      StoreProps props, AwsCredentialsProvider credentialsProvider) {

    DynamoDbAsyncClientBuilder builder =
        DynamoDbAsyncClient.builder()
            .region(props.region())
            .credentialsProvider(credentialsProvider);

    Optional.ofNullable(props.getEndPoint()).ifPresent(builder::endpointOverride);

    return builder.build();
  }

  @Bean
  public AwsCredentialsProvider credentialsProvider() {
    return DefaultCredentialsProvider.create();
  }
}
