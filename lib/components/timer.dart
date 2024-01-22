import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/provider/data_provider.dart';

class Timer extends StatelessWidget{
  final DataProvider dataProvider;

  const Timer({super.key, required this.dataProvider});

  @override
  Widget build(BuildContext){
    return Consumer<DataProvider>(
      builder: (context, timerProvider, _) {
        return Text(
          timerProvider.formattedTime,
        );
      },
    );
  }

}