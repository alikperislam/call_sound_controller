import 'package:flutter_test/flutter_test.dart';
import 'package:call_sound_controller/call_sound_controller.dart';
import 'package:flutter/services.dart';

void main() {
  const MethodChannel channel = MethodChannel('call_sound_controller');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      switch (methodCall.method) {
        case 'getVolume':
          return 5;
        case 'getMaxVolume':
          return 10;
        case 'setVolume':
          return null;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getVolume', () async {
    expect(await CallSoundController.getVolume(), 5);
  });

  test('getMaxVolume', () async {
    expect(await CallSoundController.getMaxVolume(), 10);
  });

  test('setVolume', () async {
    await CallSoundController.setVolume(7);
  });
}
