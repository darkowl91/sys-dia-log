import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/model/measurement.dart';

import 'measurement_service.dart';

class MeasurementStore extends ChangeNotifier {
  static final DateFormat isoLocalDateTime =
      DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");

  static final DateFormat isoLocalDate = DateFormat("yyyy-MM-dd");

  final MeasurementService _apiService;
  late List<Measurement> _data = [];

  MeasurementStore(this._apiService);

  List<Measurement> get data => _data;

  Future<Measurement> add(MeasurementBuilder builder) async {
    return _apiService
        .createMeasurement(builder.build())
        .then((resp) => {if (resp.isSuccessful) _data.insert(0, resp.body!)})
        .then((_) => _data[0])
        .whenComplete(() => notifyListeners());
  }

  void remove(Measurement measurement) async {
    _apiService
        .deleteMeasurement(isoLocalDateTime.format(measurement.createdAt!))
        .then((resp) => {if (resp.isSuccessful) _data.remove(measurement)})
        .whenComplete(() => notifyListeners());
  }

  Future<List<Measurement>> load() async {
    return _apiService
        .getMeasurements(isoLocalDate.format(_lastNDays(days: 7)))
        .then((resp) => _data = resp.body!)
        .whenComplete(() => notifyListeners());
  }

  DateTime _lastNDays({int days = 0}) {
    return DateTime.now().toUtc().subtract(Duration(days: days));
  }
}
