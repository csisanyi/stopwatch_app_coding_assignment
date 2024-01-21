import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/view/landscape_view.dart';
import 'package:stopwatch/view/portrait_view.dart';
import '../provider/theme_provider.dart';

class UserInterface extends StatelessWidget {
  const UserInterface({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Stopwatch'),
          actions: [
            ElevatedButton(
              onPressed: () {
                themeProvider.toggleTheme();
              },
              child: themeProvider.getThemeIcon(),
            )
          ],
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? const PortraitView()
              : const LandscapeView();
        }));
  }
}
