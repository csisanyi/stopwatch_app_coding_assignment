import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/theme_provider.dart';
import '../provider/data_provider.dart';
import 'lap_tile.dart';

class LapList extends StatelessWidget {
  final DataProvider dataProvider;
  final DataProvider consumerDataProvider;
  final double containerWidth;

  const LapList({super.key, required this.dataProvider,required this.consumerDataProvider, required this.containerWidth});

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        children: consumerDataProvider.items.asMap().entries.map((entry) {
          int index = entry.key;
          String item = entry.value;

          return Container(
            width: containerWidth,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Provider.of<ThemeProvider>(context)
                        .dividerColor!,
                    // Border color
                    width: 2.0, // Border width
                  ),
                ),
              ),
              child: LapTile(dataProvider: dataProvider, index: index, item: item));
        }).toList(),
      ),
    );
  }
}