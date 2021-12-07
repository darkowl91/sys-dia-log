package by.sysdialog.measurement.model;

import lombok.Data;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.Positive;
import java.io.Serializable;

@Data
@Validated
public class Pulse implements Serializable {

  private static final long serialVersionUID = -7589911327428610091L;

  @Positive private int bpm;
}
