import 'package:flutter/services.dart';
import 'package:task_progress_indicator/platform/task_progress_platform_interface.dart';

const MethodChannel _channel = MethodChannel('task_progress_indicator');

/// Default implementation of [TaskProgressPlatformInterface] using method channels.
class MethodChannelTaskProgress implements TaskProgressPlatformInterface {
  @override
  Future<void> saveProgress({
    required int completed,
    required int total,
  }) async {
    await _channel.invokeMethod<void>(
      'saveProgress',
      <String, dynamic>{
        'completed': completed,
        'total': total,
      },
    );
  }

  @override
  Future<Map<String, int>> loadProgress() async {
    final Map<dynamic, dynamic>? result =
        await _channel.invokeMethod<Map<dynamic, dynamic>>(
      'loadProgress',
    );

    return {
      'completed': result?['completed'] as int? ?? 0,
      'total': result?['total'] as int? ?? 0,
    };
  }

  @override
  Future<void> clearProgress() async {
    await _channel.invokeMethod<void>('clearProgress');
  }
}
