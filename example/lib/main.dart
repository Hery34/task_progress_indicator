import 'package:flutter/material.dart';
import 'package:task_progress_indicator/task_progress_indicator.dart';
import 'package:task_progress_indicator/task_progress_indicator_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Progress Indicator Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Task Progress Indicator Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TaskProgressIndicator _progress =
      TaskProgressIndicator(completed: 0, total: 5);
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    setState(() => _isLoading = true);
    // Simuler un délai de chargement
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _progress = TaskProgressIndicator(completed: 0, total: 5);
      _isLoading = false;
    });
  }

  Future<void> _updateProgress(int completed) async {
    setState(() => _isLoading = true);
    // Simuler un délai de sauvegarde
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      _progress = TaskProgressIndicator(
        completed: completed,
        total: 5,
      );
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: _isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Task Progress:',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  TaskProgressBar(
                    progress: _progress,
                    height: 20,
                    showText: true,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      for (int i = 0; i <= 5; i++)
                        ElevatedButton(
                          onPressed: () => _updateProgress(i),
                          child: Text('$i/5'),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: () {
                        _updateProgress(0);
                      },
                      child: const Text('Reset Progress'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
