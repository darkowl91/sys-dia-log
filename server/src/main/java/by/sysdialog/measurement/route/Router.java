package by.sysdialog.measurement.route;

import by.sysdialog.measurement.handler.MeasurementHandler;
import by.sysdialog.measurement.model.Measurement;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.headers.Header;
import io.swagger.v3.oas.annotations.media.ArraySchema;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import org.springdoc.core.annotations.RouterOperation;
import org.springdoc.core.annotations.RouterOperations;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.ServerResponse;

import static java.util.function.Predicate.not;
import static org.springframework.web.reactive.function.server.RequestPredicates.DELETE;
import static org.springframework.web.reactive.function.server.RequestPredicates.GET;
import static org.springframework.web.reactive.function.server.RequestPredicates.POST;
import static org.springframework.web.reactive.function.server.RequestPredicates.accept;
import static org.springframework.web.reactive.function.server.RequestPredicates.contentType;
import static org.springframework.web.reactive.function.server.RequestPredicates.path;
import static org.springframework.web.reactive.function.server.RequestPredicates.queryParam;
import static org.springframework.web.reactive.function.server.RouterFunctions.nest;
import static org.springframework.web.reactive.function.server.RouterFunctions.route;

@Configuration
public class Router {

  @RouterOperations({
    @RouterOperation(
        path = "/measurements",
        method = RequestMethod.POST,
        beanClass = MeasurementHandler.class,
        beanMethod = "create",
        consumes = "application/json",
        produces = "application/json",
        operation =
            @Operation(
                operationId = "create",
                summary = "Create new user measurement.",
                tags = {"UserMeasurement"},
                requestBody =
                    @RequestBody(
                        content = @Content(schema = @Schema(implementation = Measurement.class))),
                responses = {
                  @ApiResponse(
                      responseCode = "201",
                      headers = {
                        @Header(
                            name = "Location",
                            description = "New measurement resource location uri.")
                      },
                      description = "New measurement successfully created.",
                      content = @Content(schema = @Schema(implementation = Measurement.class))),
                })),
    @RouterOperation(
        path = "/measurements/{id}",
        method = RequestMethod.DELETE,
        beanClass = MeasurementHandler.class,
        beanMethod = "delete",
        operation =
            @Operation(
                operationId = "delete",
                summary = "Delete user measurement.",
                tags = {"UserMeasurement"},
                parameters = {@Parameter(required = true, name = "id", in = ParameterIn.PATH)},
                responses = {
                  @ApiResponse(
                      responseCode = "204",
                      description = "Measurement successfully deleted.",
                      content = @Content),
                  @ApiResponse(
                      responseCode = "404",
                      description = "Requested measurement does not exists.")
                })),
    @RouterOperation(
        path = "/measurements",
        method = RequestMethod.GET,
        beanClass = MeasurementHandler.class,
        beanMethod = "findByDateFrom",
        produces = "application/json",
        operation =
            @Operation(
                operationId = "findByDateFrom",
                summary = "Retrieves user measurements starting from specified date.",
                tags = {"UserMeasurement"},
                parameters = {
                  @Parameter(required = true, name = "dateFrom", in = ParameterIn.QUERY)
                },
                responses = {
                  @ApiResponse(
                      responseCode = "200",
                      description = "Get user measurements staring from date.",
                      content =
                          @Content(
                              array =
                                  @ArraySchema(
                                      uniqueItems = true,
                                      schema = @Schema(implementation = Measurement.class)))),
                }))
  })
  @Bean
  public RouterFunction<ServerResponse> measurementsRouter(MeasurementHandler measurementHandler) {
    return nest(
        path("/api/v1"),
        route(
                POST("/measurements")
                    .and(accept(MediaType.APPLICATION_JSON))
                    .and(contentType(MediaType.APPLICATION_JSON)),
                measurementHandler::create)
            .andRoute(
                GET("/measurements")
                    .and(accept(MediaType.APPLICATION_JSON))
                    .and(queryParam("dateFrom", not(String::isEmpty))),
                measurementHandler::findByDateFrom)
            .andRoute(
                DELETE("/measurements/{id}").and(accept(MediaType.APPLICATION_JSON)),
                measurementHandler::delete));
  }
}
