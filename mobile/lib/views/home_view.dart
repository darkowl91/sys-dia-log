import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:mobile/model/measurement.dart';
import 'package:mobile/service/measurement_store.dart';
import 'package:mobile/views/new_measurement_view.dart';
import 'package:mobile/widgets/items_list.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  static const String routeName = "home";

  const HomeView({Key? key}) : super(key: key);

  void _navigateAndAddNewMeasurement(BuildContext context) async {
    final buildResult = await Navigator.of(context)
        .pushNamed(NewMeasurementView.routeName) as MeasurementBuilder;

    final measurement =
        await Provider.of<MeasurementStore>(context, listen: false)
            .add(buildResult);

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: I18nText(
          'measurement.created',
          translationParams: {
            'createdAt':
                DateFormat.yMEd().format(measurement.createdAt!.toLocal())
          },
        ),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: FlutterI18n.translate(context, 'measurement.add'),
        child: const Icon(Icons.add),
        onPressed: () => _navigateAndAddNewMeasurement(context),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: Provider.of<MeasurementStore>(context, listen: false).load(),
          builder: (_, snap) => snap.connectionState == ConnectionState.waiting
              ? const CircularProgressIndicator()
              : snap.hasData
                  ? const ItemsList()
                  : I18nText('error'),
        ),
      ),
    );
  }
}
