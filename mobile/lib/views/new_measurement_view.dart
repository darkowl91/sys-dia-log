import 'package:flutter/material.dart';
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
                    const Text('Systolic'),
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
                    const Text('Diastolic'),
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
                    const Text('Pulse'),
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
        tooltip: 'Save Measurement',
        child: const Icon(
          Icons.save,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
    );
  }
}
