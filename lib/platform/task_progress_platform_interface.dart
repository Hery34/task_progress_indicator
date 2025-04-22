/// Interface for platform-specific task progress functionality.
///
/// This interface defines methods that can be implemented differently
/// on each platform to provide native functionality.
abstract class TaskProgressPlatformInterface {
  /// Saves the progress to native storage.
  ///
  /// [completed] is the number of completed tasks.
  /// [total] is the total number of tasks.
  Future<void> saveProgress({
    required int completed,
    required int total,
  });

  /// Loads the progress from native storage.
  ///
  /// Returns a map with 'completed' and 'total' keys.
  Future<Map<String, int>> loadProgress();

  /// Clears the progress from native storage.
  Future<void> clearProgress();
}
