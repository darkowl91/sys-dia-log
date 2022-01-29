package by.sysdialog.measurement.model;

import java.io.Serializable;

import javax.validation.constraints.NotNull;
import javax.validation.constraints.Positive;

import org.springframework.validation.annotation.Validated;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Validated
public class Pulse implements Serializable {

  private static final long serialVersionUID = -7589911327428610091L;

  @Positive
  @NotNull
  @Schema(description = "Heart beat", example = "80")
  private Integer bpm;
}
