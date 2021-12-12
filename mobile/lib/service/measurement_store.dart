import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/model/measurement.dart';

import 'measurement_service.dart';

class MeasurementStore extends ChangeNotifier {
  final MeasurementService _apiService = MeasurementService.create();

  late List<Measurement> _data = [];

  List<Measurement> get data => _data;

  Future<Measurement> add(MeasurementBuilder builder) async {
    return _apiService
        .createMeasurement(builder.build())
        .then((resp) => _data.insert(0, resp.body!))
        .then((_) => _data[0])
        .whenComplete(() => notifyListeners());
  }

  void remove(Measurement measurement) async {
    _apiService
        .deleteMeasurement(measurement.createdAt.toUtc().toIso8601String())
        .then((resp) => {if (resp.isSuccessful) _data.remove(measurement)})
        .whenComplete(() => notifyListeners());
  }

  Future<List<Measurement>> load() async {
    return _apiService
        .getMeasurements(_lastNDays(days: 7))
        .then((resp) => _data = resp.body!)
        .whenComplete(() => notifyListeners());
  }

  String _lastNDays({int days = 0}) {
    final date = DateTime.now().toUtc().subtract(Duration(days: days));
    return DateFormat("yyyy-MM-dd").format(date);
  }
}
