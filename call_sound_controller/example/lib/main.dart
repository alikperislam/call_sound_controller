import 'package:flutter/material.dart';
import 'package:call_sound_controller/call_sound_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Call Sound Controller Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _currentVolume;
  int? _maxVolume;

  @override
  void initState() {
    super.initState();
    _updateVolumeInfo();
  }

  Future<void> _updateVolumeInfo() async {
    try {
      final volume = await CallSoundController.getVolume();
      final maxVolume = await CallSoundController.getMaxVolume();
      setState(() {
        _currentVolume = volume;
        _maxVolume = maxVolume;
      });
    } catch (e) {
      debugPrint('Error getting volume info: $e');
    }
  }

  Future<void> _setVolume(int volume) async {
    try {
      await CallSoundController.setVolume(volume);
      await _updateVolumeInfo();
    } catch (e) {
      debugPrint('Error setting volume: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Call Sound Controller'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current Volume: ${_currentVolume ?? "Unknown"}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Max Volume: ${_maxVolume ?? "Unknown"}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            if (_maxVolume != null)
              Slider(
                value: (_currentVolume ?? 0).toDouble(),
                min: 0,
                max: _maxVolume!.toDouble(),
                divisions: _maxVolume!,
                label: _currentVolume?.toString(),
                onChanged: (double value) {
                  _setVolume(value.toInt());
                },
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (_currentVolume != null && _currentVolume! > 0) {
                      _setVolume(_currentVolume! - 1);
                    }
                  },
                  child: const Text('Decrease'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_currentVolume != null &&
                        _maxVolume != null &&
                        _currentVolume! < _maxVolume!) {
                      _setVolume(_currentVolume! + 1);
                    }
                  },
                  child: const Text('Increase'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
