import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_progress_indicator/task_progress_indicator_model.dart';

void main() {
  group('TaskProgressIndicator Model Tests', () {
    test('should create valid progress indicator', () {
      final progress = TaskProgressIndicator(
        completed: 3,
        total: 5,
        color: Colors.blue,
        backgroundColor: Colors.grey[200]!,
      );

      expect(progress.completed, 3);
      expect(progress.total, 5);
      expect(progress.color, Colors.blue);
      expect(progress.backgroundColor, Colors.grey[200]);
      expect(progress.percentage, 0.6);
      expect(progress.text, '3/5');
    });

    test('should calculate correct percentage', () {
      expect(
        TaskProgressIndicator(completed: 0, total: 5).percentage,
        0.0,
      );
      expect(
        TaskProgressIndicator(completed: 5, total: 5).percentage,
        1.0,
      );
      expect(
        TaskProgressIndicator(completed: 2, total: 4).percentage,
        0.5,
      );
    });

    test('should format text correctly', () {
      expect(
        TaskProgressIndicator(completed: 0, total: 5).text,
        '0/5',
      );
      expect(
        TaskProgressIndicator(completed: 5, total: 5).text,
        '5/5',
      );
    });

    test('should throw error for negative total', () {
      expect(
        () => TaskProgressIndicator(completed: 0, total: -1),
        throwsArgumentError,
      );
    });

    test('should throw error for negative completed', () {
      expect(
        () => TaskProgressIndicator(completed: -1, total: 5),
        throwsArgumentError,
      );
    });

    test('should throw error when completed exceeds total', () {
      expect(
        () => TaskProgressIndicator(completed: 6, total: 5),
        throwsArgumentError,
      );
    });

    test('should use default colors when not specified', () {
      final progress = TaskProgressIndicator(
        completed: 3,
        total: 5,
      );

      expect(progress.color, Colors.blue);
      expect(progress.backgroundColor, const Color(0xFFE0E0E0));
    });
  });
}
