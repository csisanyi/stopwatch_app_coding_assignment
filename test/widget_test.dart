import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/main.dart';

void main() {
  testWidgets(
      "Verify if start button increases and the digital clock is displaying the change",
      (WidgetTester tester) async {
    await tester.pumpWidget(const StopWatchApp());

    var start = find.text("Start");
    var cancel = find.text("Pause");
    var startTime = find.text("00:00:00.0");
    expect(start, findsOneWidget);
    expect(startTime, findsOneWidget);
    expect(cancel, findsOneWidget);

    await tester.tap(start);
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(cancel);

    expect(startTime, findsNothing);
  });

  testWidgets(
      "Verify if pause button works by checking if it stops the increase of time",
      (WidgetTester tester) async {
    await tester.pumpWidget(const StopWatchApp());

    var start = find.text("Start");
    var pause = find.text("Pause");
    var startTime = find.text("00:00:00.0");
    var increasedTime = find.text("00:00:01.0");
    var clear = find.text("Clear");

    expect(start, findsOneWidget);
    expect(pause, findsOneWidget);
    expect(startTime, findsOneWidget);
    expect(clear, findsOneWidget);
    expect(increasedTime, findsNothing);

    await tester.tap(start);
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(pause);
    await tester.pump(const Duration(seconds: 1));

    expect(increasedTime, findsAtLeastNWidgets(2));
    expect(startTime, findsNothing);
  });

  testWidgets(
      "Verify if reset button works by checking if it resets time to startvalue",
      (WidgetTester tester) async {
    await tester.pumpWidget(const StopWatchApp());

    var start = find.text("Start");
    var reset = find.text("Reset");
    var startTime = find.text("00:00:00.0");

    expect(start, findsOneWidget);
    expect(reset, findsOneWidget);
    expect(startTime, findsOneWidget);

    await tester.tap(start);
    await tester.pump(const Duration(seconds: 1));

    expect(startTime, findsNothing);

    await tester.tap(reset);
    await tester.pump(const Duration(seconds: 1));

    expect(startTime, findsOneWidget);
  });

  testWidgets("Verify tapping all buttons", (WidgetTester tester) async {
    await tester.pumpWidget(const StopWatchApp());

    var start = find.text("Start");
    var pause = find.text("Pause");
    var reset = find.text("Reset");
    var lap = find.text("Lap");
    var clear = find.text("Clear");
    var startTime = find.text("00:00:00.0");
    var increasedTime = find.text("00:00:01.0");
    var lap1 = find.text("Lap 1");
    var lap2 = find.text("Lap 2");

    expect(start, findsOneWidget);
    expect(reset, findsOneWidget);
    expect(pause, findsOneWidget);
    expect(lap, findsOneWidget);
    expect(clear, findsOneWidget);
    expect(startTime, findsOneWidget);
    expect(increasedTime, findsNothing);
    expect(lap1, findsNothing);
    expect(lap2, findsNothing);

    await tester.tap(start);
    await tester.pump(const Duration(seconds: 1));

    expect(startTime, findsNothing);
    expect(increasedTime, findsAtLeastNWidgets(2));
    expect(lap1, findsOneWidget);
    expect(lap2, findsNothing);

    await tester.tap(pause);
    await tester.pump(const Duration(seconds: 1));

    expect(startTime, findsNothing);
    expect(lap, findsOneWidget);
    expect(increasedTime, findsAtLeastNWidgets(2));
    expect(lap1, findsOneWidget);
    expect(lap2, findsNothing);

    await tester.tap(clear);
    await tester.pumpAndSettle();

    expect(startTime, findsNothing);
    expect(increasedTime, findsOneWidget);
    expect(lap1, findsNothing);
    expect(lap2, findsNothing);

    await tester.tap(reset);
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(startTime, findsOneWidget);
    expect(increasedTime, findsNothing);
    expect(lap1, findsNothing);
    expect(lap2, findsNothing);
  });

  testWidgets(
      "Verify if multiple pressing of startButton is not causing unexpected behaviour",
      (WidgetTester tester) async {
    await tester.pumpWidget(const StopWatchApp());

    var start = find.text("Start");
    var pause = find.text("Pause");
    var startTime = find.text("00:00:00.0");
    var increase1 = find.text("00:00:01.0");
    var increase2 = find.text("00:00:02.0");

    expect(start, findsOneWidget);
    expect(startTime, findsOneWidget);

    await tester.tap(start);
    await tester.tap(start);
    await tester.pump(const Duration(seconds: 1));

    expect(startTime, findsNothing);
    expect(increase1, findsAtLeastNWidgets(2));
    expect(increase2, findsNothing);

    await tester.tap(start);
    await tester.tap(start);
    await tester.pump(const Duration(seconds: 1));

    expect(startTime, findsNothing);
    expect(increase1, findsNothing);
    expect(increase2, findsAtLeastNWidgets(2));

    //required to avoid Error: A Timer is still pending even after the widget tree was disposed.
    await tester.tap(pause);
  });
}
