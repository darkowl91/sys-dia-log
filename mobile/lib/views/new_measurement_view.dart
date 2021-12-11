import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:mobile/model/measurement.dart';
import 'package:numberpicker/numberpicker.dart';

class NewMeasurementView extends StatefulWidget {
  static const String routeName = "new_measurement";

  const NewMeasurementView({Key? key}) : super(key: key);

  @override
  _NewMeasurementState createState() => _NewMeasurementState();
}

class _NewMeasurementState extends State<NewMeasurementView> {
  late int _systolic = 120;
  late int _diastolic = 80;
  late int _pulse = 65;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    I18nText('pressure.systolic'),
                    NumberPicker(
                        minValue: 20,
                        maxValue: 200,
                        value: _systolic,
                        onChanged: (v) => setState(() {
                              _systolic = v;
                            }))
                  ],
                )),
                Expanded(
                    child: Column(
                  children: [
                    I18nText('pressure.diastolic'),
                    NumberPicker(
                        axis: Axis.vertical,
                        minValue: 20,
                        maxValue: 200,
                        value: _diastolic,
                        onChanged: (v) => setState(() {
                              _diastolic = v;
                            }))
                  ],
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    I18nText('pulse.name'),
                    NumberPicker(
                        minValue: 20,
                        maxValue: 220,
                        value: _pulse,
                        onChanged: (v) => setState(() {
                              _pulse = v;
                            }))
                  ],
                ))
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(
            context, MeasurementBuilder(_systolic, _diastolic, _pulse)),
        tooltip: FlutterI18n.translate(context, 'measurement.save'),
        child: const Icon(
          Icons.save,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
