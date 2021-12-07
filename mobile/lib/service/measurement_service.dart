import 'package:chopper/chopper.dart';
import 'package:mobile/auth/auth_handler.dart';
import 'package:mobile/model/measurement.dart';

part 'measurement_service.chopper.dart';

@ChopperApi(baseUrl: '/measurements')
abstract class MeasurementService extends ChopperService {
  static MeasurementService create(String baseUrl, AuthHandler authHandler) {
    final client = ChopperClient(
        baseUrl: baseUrl,
        services: [_$MeasurementService()],
        converter: const JsonConverter(),
        interceptors: [authHandler, HttpLoggingInterceptor()]);
    return _$MeasurementService(client);
  }

  @Get()
  Future<Response<List<Measurement>>> getMeasurements(
      @Query("dateFrom") DateTime dateFrom);

  @Post()
  Future<Response<Measurement>> createMeasurement(
      @Body() Measurement measurement);

  @Delete(path: "/{id}")
  Future<Response> deleteMeasurement(@Path("id") DateTime createdAt);
}
