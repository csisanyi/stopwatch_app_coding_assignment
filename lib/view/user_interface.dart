import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/view/landscape_view.dart';
import 'package:stopwatch/view/portrait_view.dart';
import '../provider/theme_provider.dart';

class UserInterface extends StatelessWidget {

  const UserInterface({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Stopwatch'),
          actions: [
            Consumer<ThemeProvider>(
            builder: (context, provider, _) {
              return ElevatedButton(
                onPressed: () {
                  provider.toggleTheme();
                },
                child: provider.getThemeIcon(),
              );
            }
            )
          ],
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          return orientation == Orientation.portrait
              ? PortraitView(portraitHeight: MediaQuery.of(context).size.height)
              : const LandscapeView();
        }));
  }
}
