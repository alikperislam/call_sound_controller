# Call Sound Controller

A Flutter plugin to control the call volume on Android devices. This plugin allows you to get the current call volume, get the maximum possible call volume, and set the call volume to a specific level.

## Features

- **Get Current Call Volume:** Retrieve the current volume level of the voice call stream.
- **Get Max Call Volume:** Retrieve the maximum volume level allowed for the voice call stream.
- **Set Call Volume:** Set the volume of the voice call stream to a specific integer value.

## Platform Support

| Platform | Support |
| :--- | :---: |
| Android | ✅ |
| iOS | ❌ |
| Web | ❌ |
| Windows | ❌ |
| MacOS | ❌ |
| Linux | ❌ |

## Installation

Add `call_sound_controller` as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  call_sound_controller: ^0.0.1
```

## Usage

Import the package in your Dart code:

```dart
import 'package:call_sound_controller/call_sound_controller.dart';
```

### Get Max Volume

Before setting the volume, it's good practice to know the maximum volume level supported by the device.

```dart
int? maxVolume = await CallSoundController.getMaxVolume();
print('Max Volume: $maxVolume');
```

### Get Current Volume

You can get the current volume level.

```dart
int? currentVolume = await CallSoundController.getVolume();
print('Current Volume: $currentVolume');
```

### Set Volume

Set the volume to a value between 0 and the maximum volume.

```dart
// Set volume to 5
await CallSoundController.setVolume(5);
```

## Example

Here is a simple example of how to use the plugin in a Flutter app:

```dart
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
      home: Scaffold(
        appBar: AppBar(title: const Text('Call Sound Controller')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              // Get max volume
              final max = await CallSoundController.getMaxVolume();
              // Set volume to half of max
              if (max != null) {
                await CallSoundController.setVolume(max ~/ 2);
              }
            },
            child: const Text('Set Volume to 50%'),
          ),
        ),
      ),
    );
  }
}
```

## Permissions

This plugin uses the `Context.AUDIO_SERVICE` to control the volume. On most Android devices, no special permissions are required to modify the `STREAM_VOICE_CALL` volume if your app has audio focus or is in a call, but generally, `MODIFY_AUDIO_SETTINGS` permission might be beneficial in some contexts. However, for basic usage as tested, it works without explicit manifest permissions for volume control.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
