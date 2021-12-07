// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations
class _$MeasurementService extends MeasurementService {
  _$MeasurementService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = MeasurementService;

  @override
  Future<Response<List<Measurement>>> getMeasurements(DateTime dateFrom) {
    final $url = '/measurements';
    final $params = <String, dynamic>{'dateFrom': dateFrom};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<List<Measurement>, Measurement>($request);
  }

  @override
  Future<Response<Measurement>> createMeasurement(Measurement measurement) {
    final $url = '/measurements';
    final $body = measurement;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<Measurement, Measurement>($request);
  }

  @override
  Future<Response<dynamic>> deleteMeasurement(DateTime createdAt) {
    final $url = '/measurements/${createdAt}';
    final $request = Request('DELETE', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
