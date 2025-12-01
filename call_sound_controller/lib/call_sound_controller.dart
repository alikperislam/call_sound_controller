import 'package:flutter/services.dart';

class CallSoundController {
  static const MethodChannel _channel = MethodChannel('call_sound_controller');

  static Future<void> setVolume(int volume) async {
    await _channel.invokeMethod('setVolume', {'volume': volume});
  }

  static Future<int?> getVolume() async {
    final int? volume = await _channel.invokeMethod('getVolume');
    return volume;
  }

  static Future<int?> getMaxVolume() async {
    final int? maxVolume = await _channel.invokeMethod('getMaxVolume');
    return maxVolume;
  }
}
