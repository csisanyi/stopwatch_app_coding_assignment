import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/provider/data_provider.dart';

class LapTile extends StatelessWidget{
  final DataProvider dataProvider;
  final int index;
  final String item;

  const LapTile({super.key, required this.dataProvider, required this.index, required this.item});

  @override
  Widget build(BuildContext){
    return ListTile(
      leading: Text(
          'Lap ${dataProvider.items.length - index}'),
      trailing: Text(item),
    );
  }

}