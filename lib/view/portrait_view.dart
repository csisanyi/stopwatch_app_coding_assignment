import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        AnalogueClock(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width),
        SizedBox(height: verticalDividerHeight),
        Consumer<DataProvider>(
          builder: (context, timerProvider, _) {
            return Text(
              timerProvider.formattedTime,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            );
          },
        ),
        SizedBox(height: verticalDividerHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
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
            ElevatedButton(
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
            ElevatedButton(
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
          ],
        ),
        SizedBox(height: verticalDividerHeight),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
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
            ElevatedButton(
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
          ],
        ),
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
                                color: Provider.of<ThemeProvider>(context).dividerColor!,
                                // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                          ),
                          child: ListTile(
                              leading: Text(
                                  'Lap ${dataProvider.items.length - index}'),
                              trailing: Text(item)));
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
