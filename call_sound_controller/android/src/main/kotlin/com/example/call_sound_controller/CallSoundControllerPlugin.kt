package com.example.call_sound_controller

import android.content.Context
import android.media.AudioManager
import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** CallSoundControllerPlugin */
class CallSoundControllerPlugin: FlutterPlugin, MethodCallHandler {
  private lateinit var channel : MethodChannel
  private lateinit var context: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "call_sound_controller")
    channel.setMethodCallHandler(this)
    context = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
      "setVolume" -> {
        val volume = call.argument<Int>("volume")
        if (volume != null) {
          val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
          audioManager.setStreamVolume(AudioManager.STREAM_VOICE_CALL, volume, 0)
          result.success(null)
        } else {
          result.error("INVALID_ARGUMENT", "Volume is null", null)
        }
      }
      "getVolume" -> {
        val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        val currentVolume = audioManager.getStreamVolume(AudioManager.STREAM_VOICE_CALL)
        result.success(currentVolume)
      }
      "getMaxVolume" -> {
        val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
        val maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_VOICE_CALL)
        result.success(maxVolume)
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
