import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _isLargeScreen = false;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  set setLargeScreen(bool value) {
    _isLargeScreen = value;
    //notifyListeners();
  }

  ThemeData getTheme() {
    return _isDarkMode
        ? (_isLargeScreen ? _darkBigScreenTheme : _darkTheme)
        : (_isLargeScreen ? _lightBigScreenTheme : _lightTheme);
  }

  Icon getThemeIcon() {
    return _isDarkMode ? const Icon(Icons.sunny) : const Icon(Icons.dark_mode);
  }

  Color? get strokeColor => getTheme().textTheme.bodyMedium!.color;
  Color? get dividerColor => getTheme().textTheme.bodyMedium!.color;
  bool? get isLargeScreen => _isLargeScreen;

  static final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        fontFamily: 'CourierPrime', // Example font family
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        elevation: const MaterialStatePropertyAll<double>(0),
        fixedSize: MaterialStateProperty.all(const Size(120, 70)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15.0),
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
              fontSize: 25, // Adjust font size
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'Montserrat'),
        ),
        iconSize: const MaterialStatePropertyAll<double>(30),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontFamily: 'Montserrat'),
      elevation: 0,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      leadingAndTrailingTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontFamily: 'CourierPrime'),
    ),
  );

  static final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontFamily: 'CourierPrime'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        elevation: const MaterialStatePropertyAll<double>(0),
        fixedSize: MaterialStateProperty.all(const Size(120, 70)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(15.0), // Adjust the border radius
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'Montserrat'),
        ),
        iconSize: const MaterialStatePropertyAll<double>(30),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontFamily: 'Montserrat'),
      elevation: 0,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      leadingAndTrailingTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontFamily: 'CourierPrime'),
    ),
  );

  static final ThemeData _darkBigScreenTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          color: Colors.white,
          fontSize: 65,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontFamily: 'CourierPrime'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        elevation: const MaterialStatePropertyAll<double>(0),
        fixedSize: MaterialStateProperty.all(const Size(175, 122.5)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(15.0), // Adjust the border radius
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'Montserrat'),
        ),
        iconSize: const MaterialStatePropertyAll<double>(52.5),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontFamily: 'Montserrat'),
      elevation: 0,
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 0),
      leadingAndTrailingTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
          fontStyle: FontStyle.italic,
          fontFamily: 'CourierPrime'),
    ),
  );

  static final ThemeData _lightBigScreenTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
          color: Colors.black,
          fontSize: 65,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontFamily: 'CourierPrime'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        elevation: const MaterialStatePropertyAll<double>(0),
        fixedSize: MaterialStateProperty.all(const Size(175, 122.5)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(15.0), // Adjust the border radius
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
              fontSize: 35, // 1.75 times bigger
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontFamily: 'Montserrat'),
        ),
        iconSize: const MaterialStatePropertyAll<double>(52.5),
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontFamily: 'Montserrat'),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.black, // Set the default color for the icon
      ),
      actionsIconTheme: IconThemeData(
        color: Colors.black, // Set the default color for the action icons
      ),
    ),
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(vertical: 25, horizontal: 0),
      leadingAndTrailingTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 30,
          fontStyle: FontStyle.italic,
          fontFamily: 'CourierPrime'),
    ),
  );
}
