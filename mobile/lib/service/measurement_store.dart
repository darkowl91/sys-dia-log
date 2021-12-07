import 'package:flutter/material.dart';
import 'package:mobile/model/measurement.dart';

class MeasurementStore extends ChangeNotifier {
  // final MeasurementService _apiService = MeasurementService.create();

  late List<Measurement> _data = [];

  List<Measurement> get data => List.of(_data);

  Measurement add(MeasurementBuilder builder) {
    final measurement = builder.build();

    _data.insert(0, measurement);

    notifyListeners();
    return measurement;
  }

  void remove(Measurement measurement) {
    _data.remove(measurement);

    notifyListeners();
  }

  Future<List<Measurement>> load() async {
    return _loadData()
        .then((value) => _data = value)
        .whenComplete(() => notifyListeners());
  }

  Future<List<Measurement>> _loadData() async {
    return Future.delayed(
        const Duration(seconds: 5),
        () => [
              MeasurementBuilder(100, 70, 60).build(
                  createdAt: DateTime.now().subtract(const Duration(days: 1))),
              MeasurementBuilder(110, 80, 60).build(
                  createdAt: DateTime.now().subtract(const Duration(days: 2))),
              MeasurementBuilder(120, 90, 60).build(
                  createdAt: DateTime.now().subtract(const Duration(days: 3))),
              MeasurementBuilder(130, 100, 60).build(
                  createdAt: DateTime.now().subtract(const Duration(days: 4))),
              MeasurementBuilder(140, 110, 60).build(
                  createdAt: DateTime.now().subtract(const Duration(days: 5)))
            ]);
  }
}
