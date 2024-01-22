import 'package:flutter/material.dart';
import 'package:stopwatch/provider/data_provider.dart';

class ActionRow extends StatelessWidget{
  final DataProvider dataProvider;

  const ActionRow({super.key, required this.dataProvider});

  @override
  Widget build(BuildContext context){
    return Row(
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
              Text("Start"),
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
    );
  }

}