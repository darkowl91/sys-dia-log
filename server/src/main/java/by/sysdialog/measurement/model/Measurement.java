package by.sysdialog.measurement.model;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.validation.annotation.Validated;

import com.fasterxml.jackson.annotation.JsonIgnore;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Validated
public class Measurement implements Serializable {

  private static final long serialVersionUID = -1442236944551556338L;

  @JsonIgnore
  @NotBlank
  @Schema(description = "User id")
  private String userId;

  @NotNull
  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
  @Schema(
      description = "Date and time of measurement",
      example = "2020-01-01T00:00:00",
      format = "date-time")
  private LocalDateTime createdAt;

  @Valid
  @NotNull
  @Schema(required = true)
  private BloodPressure bloodPressure;

  @Valid
  @Schema(required = false)
  private Pulse pulse;
}
