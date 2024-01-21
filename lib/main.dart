import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stopwatch/provider/data_provider.dart';
import 'package:stopwatch/provider/theme_provider.dart';
import 'package:stopwatch/view/user_interface.dart';

void main() {
  runApp(const StopWatchApp());
}

class StopWatchApp extends StatelessWidget {
  const StopWatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: Builder(
        builder: (context) {

          final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
          final mediaQuery = MediaQuery.of(context);
          final isLargeScreen = (mediaQuery.orientation == Orientation.portrait && mediaQuery.size.width > 650) ||
              (mediaQuery.orientation == Orientation.landscape && mediaQuery.size.height > 650);
          themeProvider.setLargeScreen = isLargeScreen;

          return MaterialApp(
            theme: Provider.of<ThemeProvider>(context).getTheme(),
            home: const UserInterface(),
          );
        },
      ),
    );
  }
}
