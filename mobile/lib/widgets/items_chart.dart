import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:mobile/model/measurement.dart';

class ItemsChart extends StatelessWidget {
  final List<Measurement> data;

  const ItemsChart(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      // width: 340,
      height: 170,
      child: TimeSeriesChart(
        _buildSeriesList(data),
        primaryMeasureAxis: const NumericAxisSpec(renderSpec: NoneRenderSpec()),
        defaultRenderer: BarRendererConfig<DateTime>(
            groupingType: BarGroupingType.stacked,
            barRendererDecorator: BarLabelDecorator()),
      ),
    );
  }

  List<Series<Measurement, DateTime>> _buildSeriesList(
      List<Measurement> items) {
    return [
      Series(
          id: 'diastolic',
          data: items,
          labelAccessorFn: (Measurement it, _) =>
              it.bloodPressure.diastolic.toString(),
          domainFn: (Measurement it, _) => it.createdAt.toLocal(),
          measureFn: (Measurement it, _) => it.bloodPressure.diastolic),
      Series(
          id: 'systolic',
          data: items,
          labelAccessorFn: (Measurement it, _) =>
              it.bloodPressure.systolic.toString(),
          domainFn: (Measurement it, _) => it.createdAt.toLocal(),
          measureFn: (Measurement it, _) => it.bloodPressure.systolic),
    ];
  }
}
