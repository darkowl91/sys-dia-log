import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:mobile/model/measurement.dart';
import 'package:mobile/service/measurement_store.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  final Measurement item;

  const ListItem(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("${item.bloodPressure.systolic}"),
            Text("${item.bloodPressure.diastolic}")
          ],
        ),
      ),
      title: I18nText('pressure.hypertension'),
      isThreeLine: true,
      subtitle: Row(
        children: [
          Text(DateFormat.yMEd().format(item.createdAt.toLocal())),
          const Spacer(),
          Text("${item.pulse.bpm} BPM"
          ),
          const Spacer()
        ],
      ),
      // trailing: const Icon(Icons.more_horiz),
      trailing: PopupMenuButton(
          icon: const Icon(Icons.more_horiz),
          tooltip: FlutterI18n.translate(context, 'measurement.edit'),
          itemBuilder: (context) =>
          [
            PopupMenuItem(
              child: ListTile(
                  leading: const Icon(Icons.delete_forever),
                  title: I18nText('measurement.delete')),
                  onTap: () =>
                      Provider.of<MeasurementStore>(context, listen: false)
                          .remove(item),
                ),
              ]),
    );
  }
}
