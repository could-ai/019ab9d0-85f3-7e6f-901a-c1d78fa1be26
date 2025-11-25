import 'package:flutter/material.dart';
import 'dart:async';

class PomodoroScreen extends StatefulWidget {
  const PomodoroScreen({super.key});

  @override
  State<PomodoroScreen> createState() => _PomodoroScreenState();
}

class _PomodoroScreenState extends State<PomodoroScreen> {
  static const int _defaultTime = 25 * 60; // 25 minutes
  int _remainingTime = _defaultTime;
  bool _isRunning = false;
  Timer? _timer;

  void _startTimer() {
    if (_timer != null) return;
    setState(() {
      _isRunning = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _stopTimer();
          // Play sound or notify
        }
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _isRunning = false;
    });
  }

  void _resetTimer() {
    _stopTimer();
    setState(() {
      _remainingTime = _defaultTime;
    });
  }

  String _formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double progress = 1 - (_remainingTime / _defaultTime);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Focus Timer',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 250,
                height: 250,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                ),
              ),
              Text(
                _formatTime(_remainingTime),
                style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton.large(
                onPressed: _isRunning ? _stopTimer : _startTimer,
                backgroundColor: _isRunning ? Colors.orange : Theme.of(context).colorScheme.primary,
                child: Icon(_isRunning ? Icons.pause : Icons.play_arrow),
              ),
              const SizedBox(width: 20),
              FloatingActionButton(
                onPressed: _resetTimer,
                backgroundColor: Colors.grey,
                child: const Icon(Icons.refresh),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: [
              ActionChip(label: const Text('25 min'), onPressed: () => setState(() => _remainingTime = 25 * 60)),
              ActionChip(label: const Text('50 min'), onPressed: () => setState(() => _remainingTime = 50 * 60)),
              ActionChip(label: const Text('15 min'), onPressed: () => setState(() => _remainingTime = 15 * 60)),
            ],
          )
        ],
      ),
    );
  }
}
