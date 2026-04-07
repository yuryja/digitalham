import 'dart:async';
import 'package:dio/dio.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class QrzResult {
  final String? callsign;
  final String? name;
  final String? qth;
  final String? grid;
  final String? country;
  final String? lat;
  final String? lon;
  final String? license;
  final String? error;

  QrzResult({
    this.callsign,
    this.name,
    this.qth,
    this.grid,
    this.country,
    this.lat,
    this.lon,
    this.license,
    this.error,
  });

  factory QrzResult.fromJson(Map<String, dynamic> json) {
    final call = json['Callsign'] as Map<String, dynamic>?;
    if (call == null) {
      return QrzResult(error: '_callsign not found');
    }
    return QrzResult(
      callsign: call['call'] as String?,
      name: call['name'] as String?,
      qth: call['addr'] as String?,
      grid: call['grid'] as String?,
      country: call['country'] as String?,
      lat: call['lat'] as String?,
      lon: call['lon'] as String?,
      license: call['license'] as String?,
    );
  }
}

class HamQthResult {
  final String? callsign;
  final String? name;
  final String? qth;
  final String? grid;
  final String? country;
  final double? lat;
  final double? lon;
  final String? error;

  HamQthResult({
    this.callsign,
    this.name,
    this.qth,
    this.grid,
    this.country,
    this.lat,
    this.lon,
    this.error,
  });

  factory HamQthResult.fromJson(Map<String, dynamic> json) {
    final search = json['search'] as Map<String, dynamic>?;
    if (search == null) {
      return HamQthResult(error: 'Search data not found');
    }
    return HamQthResult(
      callsign: search['callsign'] as String?,
      name: search['name'] as String?,
      qth: search['qth'] as String?,
      grid: search['grid'] as String?,
      country: search['country'] as String?,
      lat: double.tryParse(search['lat']?.toString() ?? ''),
      lon: double.tryParse(search['lon']?.toString() ?? ''),
    );
  }
}

class DxClusterSpot {
  final String callsign;
  final String frequency;
  final String mode;
  final String snr;
  final String time;
  final String dxCallsign;
  final String? comment;

  DxClusterSpot({
    required this.callsign,
    required this.frequency,
    required this.mode,
    required this.snr,
    required this.time,
    required this.dxCallsign,
    this.comment,
  });

  factory DxClusterSpot.fromMessage(String message) {
    final parts = message.split(' ');
    return DxClusterSpot(
      callsign: parts.isNotEmpty ? parts[0] : '',
      frequency: parts.length > 1 ? parts[1] : '',
      mode: parts.length > 2 ? parts[2] : '',
      snr: parts.length > 3 ? parts[3] : '',
      time: parts.length > 4 ? parts[4] : '',
      dxCallsign: parts.length > 5 ? parts[5] : '',
      comment: parts.length > 6 ? parts.sublist(6).join(' ') : null,
    );
  }
}

class IntegrationAgent {
  final Dio _dio = Dio();

  String? _qrzApiKey;
  String? _hamQthUsername;
  String? _hamQthPassword;
  WebSocketChannel? _dxClusterWs;
  final _dxClusterController = StreamController<DxClusterSpot>.broadcast();

  Stream<DxClusterSpot> get dxClusterStream => _dxClusterController.stream;

  void setQrzApiKey(String apiKey) {
    _qrzApiKey = apiKey;
  }

  void setHamQthCredentials(String username, String password) {
    _hamQthUsername = username;
    _hamQthPassword = password;
  }

  Future<QrzResult> lookupQrz(String callsign) async {
    if (_qrzApiKey == null || _qrzApiKey!.isEmpty) {
      return QrzResult(error: 'API key not configured');
    }

    try {
      final response = await _dio.get(
        'https://api.qrz.com/api/v1/json',
        queryParameters: {
          'key': _qrzApiKey,
          'callsign': callsign.toUpperCase(),
        },
      );

      if (response.statusCode == 200) {
        return QrzResult.fromJson(response.data as Map<String, dynamic>);
      }
      return QrzResult(error: 'API error: ${response.statusCode}');
    } catch (e) {
      return QrzResult(error: 'Network error: $e');
    }
  }

  Future<HamQthResult> lookupHamQth(String callsign) async {
    if (_hamQthUsername == null || _hamQthPassword == null) {
      return HamQthResult(error: 'Credentials not configured');
    }

    try {
      final loginResponse = await _dio.get(
        'https://www.hamqth.com/api.php',
        queryParameters: {'u': _hamQthUsername, 'p': _hamQthPassword},
      );

      if (loginResponse.statusCode != 200) {
        return HamQthResult(error: 'Login failed');
      }

      final loginData = loginResponse.data as Map<String, dynamic>;
      final sessionId = loginData['session_id'] as String?;

      if (sessionId == null) {
        return HamQthResult(error: 'Invalid credentials');
      }

      final searchResponse = await _dio.get(
        'https://www.hamqth.com/api.php',
        queryParameters: {
          'u': _hamQthUsername,
          'p': _hamQthPassword,
          'callsign': callsign.toUpperCase(),
          's': sessionId,
        },
      );

      return HamQthResult.fromJson(searchResponse.data as Map<String, dynamic>);
    } catch (e) {
      return HamQthResult(error: 'Network error: $e');
    }
  }

  Future<bool> connectToDxCluster(
    String host,
    int port,
    String callsign,
  ) async {
    try {
      final wsUrl = 'ws://$host:$port';
      _dxClusterWs = WebSocketChannel.connect(Uri.parse(wsUrl));

      await _dxClusterWs!.ready;

      _dxClusterWs!.stream.listen(
        (message) {
          if (message.toString().startsWith('DX ')) {
            final spot = DxClusterSpot.fromMessage(message.toString());
            _dxClusterController.add(spot);
          }
        },
        onError: (error) {
          _dxClusterController.addError(error);
        },
        onDone: () {
          _dxClusterController.addError('Connection closed');
        },
      );

      _dxClusterWs!.sink.add('set/dx $callsign\r\n');

      return true;
    } catch (e) {
      return false;
    }
  }

  void disconnectDxCluster() {
    _dxClusterWs?.sink.close();
    _dxClusterWs = null;
  }

  void dispose() {
    disconnectDxCluster();
    _dxClusterController.close();
  }
}
