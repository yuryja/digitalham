import 'dart:async';
import 'package:record/record.dart';
import 'package:audio_session/audio_session.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioAgent {
  final AudioRecorder _recorder = AudioRecorder();
  StreamSubscription<Amplitude>? _amplitudeSub;
  
  final _amplitudeController = StreamController<double>.broadcast();
  Stream<double> get amplitudeStream => _amplitudeController.stream;

  Future<bool> initialize() async {
    print("[AudioAgent] Requesting microphone permission...");
    final status = await Permission.microphone.request();
    print("[AudioAgent] Permission status: $status");
    if (status != PermissionStatus.granted) return false;

    print("[AudioAgent] Configuring audio session...");
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.allowBluetooth,
      avAudioSessionMode: AVAudioSessionMode.measurement,
      androidAudioAttributes: AndroidAudioAttributes(
        contentType: AndroidAudioContentType.music,
        usage: AndroidAudioUsage.media,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
    ));
    print("[AudioAgent] Audio session configured.");
    
    return true;
  }

  Future<void> startMonitoring() async {
    try {
      print("[AudioAgent] Starting monitoring...");
      if (await _recorder.isRecording()) {
        print("[AudioAgent] Already recording/monitoring.");
        return;
      }

      const config = RecordConfig(encoder: AudioEncoder.pcm16bits);
      await _recorder.start(config, path: ''); 
      print("[AudioAgent] Recorder started.");
      
      _amplitudeSub = _recorder.onAmplitudeChanged(const Duration(milliseconds: 50)).listen((amp) {
        // Log every 2 seconds to avoid flooding but see activity
        if (DateTime.now().second % 2 == 0) {
          // print("[AudioAgent] Current amp: ${amp.current}");
        }
        
        double normal = (amp.current + 100) / 100;
        if (normal < 0) normal = 0;
        if (normal > 1) normal = 1;
        _amplitudeController.add(normal);
      });
    } catch (e) {
      print("[AudioAgent] Error starting monitoring: $e");
    }
  }

  Future<void> stop() async {
    await _amplitudeSub?.cancel();
    await _recorder.stop();
  }

  void dispose() {
    _amplitudeController.close();
    _recorder.dispose();
  }
}
