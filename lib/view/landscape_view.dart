import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: AnalogueClock(
                height: MediaQuery.of(context).size.height / 1.7,
                width: MediaQuery.of(context).size.width / 2,
              ),
            ),
            SizedBox(
              height: verticalDividerHeight,
            ),
            Consumer<DataProvider>(
              builder: (context, timerProvider, _) {
                return Text(
                  timerProvider.formattedTime,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                );
              },
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        dataProvider.startTimer();
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow),
                          Text('Start'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        dataProvider.pauseTimer();
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.pause),
                          Text('Pause'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        dataProvider.resetTimer();
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.refresh),
                          Text('Reset'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        dataProvider.addItemToList();
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.flag),
                          Text('Lap'),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        dataProvider.clearList();
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.clear),
                          Text('Clear'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Consumer<DataProvider>(
                builder: (context, timerProvider, child) {
                  return Expanded(
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
                                  color: Provider.of<ThemeProvider>(context).dividerColor!,
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
