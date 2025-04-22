import 'package:flutter/material.dart';

/// A model class representing a task progress indicator.
///
/// This class provides a way to track progress of tasks with customizable
/// appearance and validation.
class TaskProgressIndicator {
  /// The total number of tasks
  final int total;

  /// The number of completed tasks
  final int completed;

  /// The color of the progress indicator
  final Color color;

  /// The background color of the progress indicator
  final Color backgroundColor;

  /// Creates a new [TaskProgressIndicator] instance.
  ///
  /// [completed] must be less than or equal to [total].
  /// [color] defaults to Colors.blue.
  /// [backgroundColor] defaults to Colors.grey[200].
  TaskProgressIndicator({
    required this.completed,
    required this.total,
    this.color = Colors.blue,
    this.backgroundColor = const Color(0xFFE0E0E0),
  }) {
    if (total < 0) {
      throw ArgumentError('Total cannot be negative');
    }
    if (completed < 0) {
      throw ArgumentError('Completed cannot be negative');
    }
    if (completed > total) {
      throw ArgumentError('Completed cannot be greater than total');
    }
  }

  /// Returns the progress percentage as a double between 0 and 1
  double get percentage => total == 0 ? 0 : completed / total;

  /// Returns the progress as a text string in the format "completed/total"
  String get text => '$completed/$total';
}
