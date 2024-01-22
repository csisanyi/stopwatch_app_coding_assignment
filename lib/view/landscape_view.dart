import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/components/action_row.dart';
import 'package:stopwatch/components/lap_button_row.dart';

import '../provider/data_provider.dart';
import '../provider/theme_provider.dart';
import 'analogue_clock.dart';

class LandscapeView extends StatelessWidget {
  const LandscapeView({super.key});

  final double verticalDividerHeight = 10;

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                child: AnalogueClock(
                  height: MediaQuery.of(context).size.height / 1.7,
                  width: MediaQuery.of(context).size.width / 2,
                ),
              ),
            ),
            Consumer<DataProvider>(
              builder: (context, timerProvider, _) {
                return Text(
                  timerProvider.formattedTime,
                );
              },
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              ActionRow(dataProvider: dataProvider),
              LapButtonRow(dataProvider: dataProvider),
              Consumer<DataProvider>(
                builder: (context, timerProvider, child) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children:
                              timerProvider.items.asMap().entries.map((entry) {
                            int index = entry.key;
                            String item = entry.value;

                            return Container(
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Provider.of<ThemeProvider>(context)
                                        .dividerColor!,
                                    width: 2.0, // Border width
                                  ),
                                ),
                              ),
                              child: ListTile(
                                leading: Text(
                                    'Lap ${dataProvider.items.length - index}'),
                                trailing: Text(item),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
