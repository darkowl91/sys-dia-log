package by.sysdialog.measurement.store.config;

import lombok.AllArgsConstructor;
import lombok.Getter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.context.properties.ConstructorBinding;
import org.springframework.lang.Nullable;
import org.springframework.validation.annotation.Validated;
import software.amazon.awssdk.regions.Region;

import javax.validation.constraints.NotBlank;
import java.net.URI;

@AllArgsConstructor
@ConstructorBinding
@Getter
@Validated
@ConfigurationProperties(prefix = "store.dynamo")
public class StoreProps {

  @NotBlank private final String region;
  @NotBlank private final String table;
  @Nullable private final URI endPoint;

  public Region region() {
    return Region.of(this.region);
  }
}
