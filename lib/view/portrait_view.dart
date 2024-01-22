import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/components/action_row.dart';
import 'package:stopwatch/components/lap_button_row.dart';
import 'package:stopwatch/components/lap_tile.dart';
import 'package:stopwatch/components/timer.dart';

import '../provider/data_provider.dart';
import '../provider/theme_provider.dart';
import 'analogue_clock.dart';

class PortraitView extends StatelessWidget {
  const PortraitView({super.key});

  final double verticalDividerHeight = 10;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: AnalogueClock(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width),
        ),
        SizedBox(height: verticalDividerHeight),
        Timer(dataProvider: dataProvider),
        SizedBox(height: verticalDividerHeight),
        ActionRow(dataProvider: dataProvider),
        SizedBox(height: verticalDividerHeight),
        LapButtonRow(dataProvider: dataProvider),
        SizedBox(height: verticalDividerHeight),
        Consumer<DataProvider>(
          builder: (context, timerProvider, child) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 3 - 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: SingleChildScrollView(
                  child: Column(
                    children: timerProvider.items.asMap().entries.map((entry) {
                      int index = entry.key;
                      String item = entry.value;

                      return Container(
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
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
