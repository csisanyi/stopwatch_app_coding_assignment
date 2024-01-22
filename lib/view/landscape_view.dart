import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/components/action_row.dart';
import 'package:stopwatch/components/lap_button_row.dart';
import 'package:stopwatch/components/lap_list.dart';
import 'package:stopwatch/components/timer.dart';

import '../provider/data_provider.dart';
import 'analogue_clock.dart';

class LandscapeView extends StatelessWidget {
  const LandscapeView({super.key});

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
            Timer(dataProvider: dataProvider)
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
                      child: LapList(dataProvider: dataProvider,consumerDataProvider: timerProvider, containerWidth: MediaQuery.of(context).size.width / 3,),
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
