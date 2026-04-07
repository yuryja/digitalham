import 'dart:async';
import 'dart:typed_data';

import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioAgent {
  final StreamController<Uint8List> _audioStreamController =
      StreamController<Uint8List>.broadcast();

  final bool _isRecording = false;
  final bool _isPlaying = false;

  Stream<Uint8List> get audioStream => _audioStreamController.stream;
  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;

  Future<bool> requestPermissions() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<void> init() async {
    final hasPermission = await requestPermissions();
    if (!hasPermission) {
      throw Exception('Microphone permission not granted');
    }
  }

  Future<void> dispose() async {
    await _audioStreamController.close();
  }

  Future<void> startRecording({String? filePath}) async {
    throw UnimplementedError('Recording not supported on web');
  }

  Future<String?> stopRecording() async {
    throw UnimplementedError('Recording not supported on web');
  }

  Future<void> playAudio(Uint8List audioData) async {
    throw UnimplementedError('Playback not supported on web');
  }

  Future<void> playFile(String filePath) async {
    throw UnimplementedError('Playback not supported on web');
  }

  Future<void> stopPlayback() async {
    throw UnimplementedError('Playback not supported on web');
  }

  Future<void> playTones(List<int> tones, {int sampleRate = 12000}) async {
    throw UnimplementedError('Playback not supported on web');
  }

  @visibleForTesting
  List<int> tonesToSamples(List<int> tones, int sampleRate) {
    final List<int> samples = [];
    const symbolsPerSecond = 2.4576;
    const symbolDuration = 1 / symbolsPerSecond;
    final samplesPerSymbol = (sampleRate * symbolDuration).round();
    const frequency = 1500;
    const amplitude = 32767;

    for (final tone in tones) {
      final freq = frequency + (tone * 2.4576);
      for (var i = 0; i < samplesPerSymbol; i++) {
        final t = i / sampleRate;
        final sample = (amplitude * _sin(2 * 3.14159 * freq * t)).round();
        samples.add(sample & 0xFF);
        samples.add((sample >> 8) & 0xFF);
      }
    }
    return samples;
  }

  double _sin(double x) {
    return x - (x * x * x) / 6 + (x * x * x * x * x) / 120;
  }
}
