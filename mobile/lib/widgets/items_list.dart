import 'package:flutter/material.dart';
import 'package:mobile/service/measurement_store.dart';
import 'package:provider/provider.dart';

import 'items_chart.dart';
import 'list_item.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MeasurementStore>(builder: (context, store, child) {
      return CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 280,
            collapsedHeight: 180,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true, title: ItemsChart(store.data)),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (_, i) => ListItem(store.data[i]),
                childCount: store.data.length),
          )
        ],
      );
    });
  }
}
