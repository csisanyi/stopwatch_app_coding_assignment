import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data_provider.dart';

class LapButtonRow extends StatelessWidget {
  final DataProvider dataProvider;

  const LapButtonRow({super.key, required this.dataProvider});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Consumer<DataProvider>(
          builder: (context, dataProvider, _) {
            return dataProvider.running
                ? ElevatedButton(
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
                  )
                : ElevatedButton(
                    onPressed: () {},
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flag,
                          color: Colors.grey, // Set the desired color
                        ),
                        Text(
                          'Lap',
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration
                                  .lineThrough // Set the desired color
                              ),
                        ),
                      ],
                    ),
                  );
          },
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
    ]);
  }
}
