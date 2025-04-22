import 'package:flutter/material.dart';
import 'package:task_progress_indicator/task_progress_indicator_model.dart';

/// A customizable progress bar widget that displays task progress.
///
/// This widget can be used to show progress of tasks with customizable
/// appearance and optional text display.
class TaskProgressBar extends StatelessWidget {
  /// The progress data to display
  final TaskProgressIndicator progress;

  /// The height of the progress bar
  final double height;

  /// Whether to show the progress text
  final bool showText;

  /// The style of the progress text
  final TextStyle? textStyle;

  /// The border radius of the progress bar
  final double? borderRadius;

  /// Creates a new [TaskProgressBar] instance.
  ///
  /// [progress] is required and contains the progress data to display.
  /// [height] defaults to 4.0.
  /// [showText] defaults to true.
  /// [textStyle] defaults to a standard style.
  /// [borderRadius] defaults to the height of the progress bar.
  const TaskProgressBar({
    super.key,
    required this.progress,
    this.height = 4.0,
    this.showText = true,
    this.textStyle,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showText)
          Text(
            progress.text,
            style: textStyle ??
                const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
          ),
        if (showText) const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius ?? height),
          child: LinearProgressIndicator(
            value: progress.percentage,
            backgroundColor: progress.backgroundColor,
            valueColor: AlwaysStoppedAnimation<Color>(progress.color),
            minHeight: height,
          ),
        ),
      ],
    );
  }
}
