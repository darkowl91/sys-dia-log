import 'package:flutter/material.dart';
import 'package:mobile/model/measurement.dart';

import 'measurement_service.dart';

class MeasurementStore extends ChangeNotifier {
  final MeasurementService _apiService = MeasurementService.create();

  late List<Measurement> _data = [];

  List<Measurement> get data => List.of(_data);

  Future<Measurement> add(MeasurementBuilder builder) async {
    return _apiService
        .createMeasurement(builder.build())
        .then((resp) => _data.insert(0, resp.body!))
        .then((_) => _data[0])
        .whenComplete(() => notifyListeners());
  }

  void remove(Measurement measurement) async {
    _apiService
        .deleteMeasurement(measurement.createdAt)
        .then((resp) => {if (resp.isSuccessful) _data.remove(measurement)})
        .whenComplete(() => notifyListeners());
  }

  Future<List<Measurement>> load() async {
    return _apiService
        .getMeasurements(
            DateTime.now().subtract(const Duration(days: 7)).toUtc())
        .then((resp) => _data = resp.body!)
        .whenComplete(() => notifyListeners());
  }
}
