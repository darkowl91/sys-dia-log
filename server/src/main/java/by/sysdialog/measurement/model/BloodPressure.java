package by.sysdialog.measurement.model;

import lombok.Data;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.Positive;
import java.io.Serializable;

@Data
@Validated
public class BloodPressure implements Serializable {

  private static final long serialVersionUID = 4934671806220657020L;

  @Positive private int systolic;

  @Positive private int diastolic;
}
