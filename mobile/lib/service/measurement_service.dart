import 'package:chopper/chopper.dart';
import 'package:mobile/auth/auth_handler.dart';
import 'package:mobile/model/measurement.dart';
import 'package:mobile/service/converter/JsonSerializableConverter.dart';

part 'measurement_service.chopper.dart';

@ChopperApi(baseUrl: '/measurements')
abstract class MeasurementService extends ChopperService {
  static MeasurementService create() {
    final client = ChopperClient(
      baseUrl: const String.fromEnvironment(
        'BASE_URL',
        defaultValue: 'http://localhost:8080/api/v1',
      ),
      services: [_$MeasurementService()],
      converter: const JsonSerializableConverter(factories: {
        Measurement: Measurement.fromJsonFactory,
      }),
      errorConverter: const JsonConverter(),
      interceptors: [AuthHandler(), HttpLoggingInterceptor()],
    );
    return _$MeasurementService(client);
  }

  @Get()
  Future<Response<List<Measurement>>> getMeasurements(
      @Query("dateFrom") String dateFrom);

  @Post()
  Future<Response<Measurement>> createMeasurement(
      @Body() Measurement measurement);

  @Delete(path: "/{id}")
  Future<Response> deleteMeasurement(@Path("id") String createdAt);
}
