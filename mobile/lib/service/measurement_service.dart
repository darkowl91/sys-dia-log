import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/auth/auth_handler.dart';
import 'package:mobile/model/measurement.dart';
import 'package:mobile/service/converter/json_serializable_converter.dart';

part 'measurement_service.chopper.dart';

@ChopperApi(baseUrl: '/measurements')
abstract class MeasurementService extends ChopperService {
  static const String _baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://localhost:8080/api/v1',
  );

  static MeasurementService create({http.Client? httpClient}) {
    final client = ChopperClient(
      baseUrl: _baseUrl,
      client: httpClient,
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
