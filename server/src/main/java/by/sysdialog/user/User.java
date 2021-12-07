package by.sysdialog.user;

import lombok.Data;
import org.springframework.validation.annotation.Validated;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.io.Serializable;

@Data
@Validated
public class User implements Serializable {

  private static final long serialVersionUID = -162724995715294521L;

  @NotBlank private String userId;
  @NotBlank private String email;
  @NotNull private Boolean active;
}
