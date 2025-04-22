import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_progress_indicator/task_progress_indicator.dart';
import 'package:task_progress_indicator/task_progress_indicator_model.dart';

void main() {
  group('TaskProgressBar Widget Tests', () {
    testWidgets('should render progress bar with default values',
        (WidgetTester tester) async {
      final progress = TaskProgressIndicator(
        completed: 3,
        total: 5,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskProgressBar(progress: progress),
          ),
        ),
      );

      expect(find.text('3/5'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('should hide text when showText is false',
        (WidgetTester tester) async {
      final progress = TaskProgressIndicator(
        completed: 3,
        total: 5,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskProgressBar(
              progress: progress,
              showText: false,
            ),
          ),
        ),
      );

      expect(find.text('3/5'), findsNothing);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('should apply custom text style', (WidgetTester tester) async {
      final progress = TaskProgressIndicator(
        completed: 3,
        total: 5,
      );
      final customStyle = const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskProgressBar(
              progress: progress,
              textStyle: customStyle,
            ),
          ),
        ),
      );

      final textWidget = tester.widget<Text>(find.text('3/5'));
      expect(textWidget.style?.fontSize, 16);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('should apply custom height', (WidgetTester tester) async {
      final progress = TaskProgressIndicator(
        completed: 3,
        total: 5,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskProgressBar(
              progress: progress,
              height: 8.0,
            ),
          ),
        ),
      );

      final progressIndicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(progressIndicator.minHeight, 8.0);
    });

    testWidgets('should apply custom border radius', (WidgetTester tester) async {
      final progress = TaskProgressIndicator(
        completed: 3,
        total: 5,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskProgressBar(
              progress: progress,
              borderRadius: 10.0,
            ),
          ),
        ),
      );

      final clipRRect = tester.widget<ClipRRect>(find.byType(ClipRRect));
      expect(
        (clipRRect.borderRadius as BorderRadius).topLeft.x,
        10.0,
      );
    });

    testWidgets('should use progress colors', (WidgetTester tester) async {
      final progress = TaskProgressIndicator(
        completed: 3,
        total: 5,
        color: Colors.red,
        backgroundColor: Colors.yellow,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskProgressBar(progress: progress),
          ),
        ),
      );

      final progressIndicator = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator),
      );
      expect(
        (progressIndicator.valueColor as AlwaysStoppedAnimation<Color>).value,
        Colors.red,
      );
      expect(progressIndicator.backgroundColor, Colors.yellow);
    });
  });
} 