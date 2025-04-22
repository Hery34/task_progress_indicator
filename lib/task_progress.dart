import 'package:task_progress_indicator/platform/method_channel_task_progress.dart';
import 'package:task_progress_indicator/task_progress_indicator_model.dart';
import 'package:task_progress_indicator/platform/task_progress_platform_interface.dart';

/// Manages task progress with platform-specific persistence.
class TaskProgress {
  final TaskProgressPlatformInterface _platform;
  TaskProgressIndicator? _currentProgress;

  /// Creates a new [TaskProgress] instance.
  ///
  /// [platform] is the platform-specific implementation to use.
  /// If not provided, a default implementation will be used.
  TaskProgress([TaskProgressPlatformInterface? platform])
      : _platform = platform ?? MethodChannelTaskProgress();

  /// Gets the current progress.
  ///
  /// If no progress is loaded, returns a new instance with 0/0.
  TaskProgressIndicator get currentProgress =>
      _currentProgress ?? TaskProgressIndicator(completed: 0, total: 0);

  /// Updates the progress and saves it to platform storage.
  ///
  /// [completed] is the number of completed tasks.
  /// [total] is the total number of tasks.
  Future<void> updateProgress({
    required int completed,
    required int total,
  }) async {
    _currentProgress = TaskProgressIndicator(
      completed: completed,
      total: total,
    );
    await _platform.saveProgress(
      completed: completed,
      total: total,
    );
  }

  /// Loads the progress from platform storage.
  ///
  /// Returns the loaded progress or null if no progress was saved.
  Future<TaskProgressIndicator?> loadProgress() async {
    final progress = await _platform.loadProgress();
    if (progress['completed'] == 0 && progress['total'] == 0) {
      return null;
    }
    _currentProgress = TaskProgressIndicator(
      completed: progress['completed']!,
      total: progress['total']!,
    );
    return _currentProgress;
  }

  /// Clears the progress from platform storage.
  Future<void> clearProgress() async {
    _currentProgress = null;
    await _platform.clearProgress();
  }
}
