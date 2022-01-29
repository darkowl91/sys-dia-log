package by.sysdialog.measurement.model;

import java.io.Serializable;

import javax.validation.constraints.Positive;

import org.springframework.validation.annotation.Validated;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

@Data
@Validated
public class BloodPressure implements Serializable {

  private static final long serialVersionUID = 4934671806220657020L;

  @Positive
  @Schema(
      description = "Systolic blood pressure",
      example = "120",
      format = "int32",
      required = true)
  private Integer systolic;

  @Positive
  @Schema(
      description = "Diastolic blood pressure",
      example = "80",
      format = "int32",
      required = true)
  private Integer diastolic;
}
