package by.sysdialog.measurement.model;

import java.io.Serializable;
import java.time.LocalDateTime;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.validation.annotation.Validated;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.Data;

@Data
@Validated
public class Measurement implements Serializable {

  private static final long serialVersionUID = -1442236944551556338L;

  @JsonIgnore @NotBlank private String userId;

  @NotNull
  @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
  private LocalDateTime createdAt;

  @Valid @NotNull private BloodPressure bloodPressure;

  @Valid private Pulse pulse;
}
