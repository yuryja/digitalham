import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'agents/audio_agent/audio_agent.dart';
import 'agents/security_agent/security_agent.dart';

void main() {
  runApp(const DigitalHamApp());
}

class DigitalHamApp extends StatelessWidget {
  const DigitalHamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DigitalHam Valkyrie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF020202),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00FFD1),
          brightness: Brightness.dark,
          primary: const Color(0xFF00FFD1),
        ),
      ),
      home: const ValkyrieTerminal(),
    );
  }
}

class ValkyrieTerminal extends StatefulWidget {
  const ValkyrieTerminal({super.key});

  @override
  State<ValkyrieTerminal> createState() => _ValkyrieTerminalState();
}

class _ValkyrieTerminalState extends State<ValkyrieTerminal> {
  final AudioAgent _audioAgent = AudioAgent();
  final SecurityAgent _securityAgent = SecurityAgent();
  
  String _mode = 'FT8';
  bool _isActive = false;
  double _signalLevel = 0.0;
  String _callsign = 'NOT SET';
  
  final List<String> _logEntries = [
    "[INIT] Valkyrie Protocol Online",
    "[DRIVE] Kernel 2.2 Ready",
    "[SYS] Waiting for signal..."
  ];

  @override
  void initState() {
    super.initState();
    _initSystem();
  }

  Future<void> _initSystem() async {
    final creds = await _securityAgent.getCredentials();
    setState(() {
      _callsign = creds.callsign.isEmpty ? 'K1XYZ' : creds.callsign;
    });

    final ok = await _audioAgent.initialize();
    if (ok) {
      _audioAgent.amplitudeStream.listen((amp) {
        if (_isActive) setState(() => _signalLevel = amp);
      });
    }
  }

  void _showSettings() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Settings',
      pageBuilder: (context, _, __) => _SettingsPanel(
        securityAgent: _securityAgent,
        onSave: (newCall) => setState(() => _callsign = newCall),
      ),
    );
  }

  void _toggleRx() async {
    if (_isActive) {
      await _audioAgent.stop();
      setState(() {
        _isActive = false;
        _signalLevel = 0.0;
        _logEntries.insert(0, "[SYS] Reception Stopped");
      });
    } else {
      await _audioAgent.startMonitoring();
      setState(() {
        _isActive = true;
        _logEntries.insert(0, "[RX] Monitoring Active @ 14.074");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _TacticalGrid(),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > constraints.maxHeight) {
                  return _buildLandscape(context);
                } else {
                  return _buildPortrait(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPortrait(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          Expanded(child: _buildMainView(isLandscape: false)),
          const SizedBox(height: 12),
          _buildControlBar(isLandscape: false),
        ],
      ),
    );
  }

  Widget _buildLandscape(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Sidebar
          SizedBox(
            width: 180,
            child: Column(
              children: [
                _buildHeader(compact: true),
                const SizedBox(height: 8),
                Expanded(child: _buildSideMeters()),
                const SizedBox(height: 8),
                _buildControlBar(isLandscape: true),
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Main Work Area
          Expanded(
            child: _buildMainView(isLandscape: true),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader({bool compact = false}) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "DIGITALHAM",
              style: GoogleFonts.orbitron(
                fontSize: compact ? 16 : 22,
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.primary,
                letterSpacing: 2,
              ),
            ).animate().shimmer(),
            Text(
              compact ? "MY ID: $_callsign" : "VALKYRIE // CALLSIGN: $_callsign",
              style: GoogleFonts.robotoMono(
                fontSize: 8, 
                color: _callsign == 'NOT SET' ? Colors.redAccent : Colors.white38
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.settings, size: 20, color: Colors.white24),
          onPressed: _showSettings,
        ),
        if (!compact) ...[
          const SizedBox(width: 8),
          _buildModeSelector(),
        ]
      ],
    );
  }

  Widget _buildSideMeters() {
    return _TacticalContainer(
      title: "TELEMETRY",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildSmallMeter("SIGNAL", _signalLevel),
          _buildSmallMeter("SNR", _isActive ? 0.7 : 0.0),
          _buildSmallMeter("ALC", 0.1),
        ],
      ),
    );
  }

  Widget _buildSmallMeter(String label, double val) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: GoogleFonts.orbitron(fontSize: 7, color: Colors.white24)),
          const SizedBox(height: 2),
          LinearProgressIndicator(
            value: val,
            backgroundColor: Colors.white10,
            color: val > 0.8 ? Colors.redAccent : Colors.cyanAccent,
            minHeight: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildMainView({required bool isLandscape}) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: _TacticalContainer(
            title: "SPECTRUM WATERFALL",
            isGlow: _isActive,
            child: _Waterfall(isActive: _isActive, amplitude: _signalLevel),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          flex: 1,
          child: _TacticalContainer(
            title: "DECODED BROADCAST",
            child: _buildLog(),
          ),
        ),
      ],
    );
  }

  Widget _buildLog() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _logEntries.length,
      itemBuilder: (context, i) => Text(
        _logEntries[i],
        style: GoogleFonts.robotoMono(fontSize: 10, color: Colors.greenAccent.withOpacity(0.7)),
      ),
    );
  }

  Widget _buildControlBar({required bool isLandscape}) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white12),
      ),
      child: isLandscape 
        ? Column(children: _controlButtons())
        : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: _controlButtons()),
    );
  }

  List<Widget> _controlButtons() {
    return [
      _actionBtn(Icons.hearing, "RX", Colors.cyanAccent, _isActive, _toggleRx),
      _actionBtn(Icons.sensors, "TX", Colors.orangeAccent, false, () {}),
      _actionBtn(Icons.stop, "CLR", Colors.redAccent, false, _isActive ? _toggleRx : () {}),
    ];
  }

  Widget _actionBtn(IconData icon, String label, Color color, bool active, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: active ? color : Colors.white24, size: 20),
            Text(label, style: GoogleFonts.orbitron(fontSize: 8, color: active ? color : Colors.white24)),
          ],
        ),
      ),
    );
  }

  Widget _buildModeSelector() {
    return DropdownButton<String>(
      value: _mode,
      underline: Container(),
      items: ['FT8', 'FT4'].map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 12)))).toList(),
      onChanged: (v) => setState(() => _mode = v!),
    );
  }
}

class _TacticalContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final bool isGlow;
  const _TacticalContainer({required this.title, required this.child, this.isGlow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: isGlow ? Colors.cyanAccent.withOpacity(0.3) : Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            color: Colors.black,
            child: Text(title, style: GoogleFonts.orbitron(fontSize: 7, color: Colors.white38)),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _TacticalGrid extends StatelessWidget {
  const _TacticalGrid();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GridPainter(),
      size: Size.infinite,
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.02)..strokeWidth = 0.5;
    for (double i = 0; i < size.width; i += 30) canvas.drawLine(Offset(i, 0), Offset(i, size.height), paint);
    for (double i = 0; i < size.height; i += 30) canvas.drawLine(Offset(0, i), Offset(size.width, i), paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Waterfall extends StatefulWidget {
  final bool isActive;
  final double amplitude;
  const _Waterfall({required this.isActive, required this.amplitude});
  @override
  State<_Waterfall> createState() => _WaterfallState();
}

class _WaterfallState extends State<_Waterfall> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500))..repeat();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => CustomPaint(
        painter: _WPainter(isActive: widget.isActive, offset: _controller.value, amp: widget.amplitude),
        size: Size.infinite,
      ),
    );
  }
}

class _WPainter extends CustomPainter {
  final bool isActive;
  final double offset;
  final double amp;
  _WPainter({required this.isActive, required this.offset, required this.amp});

  @override
  void paint(Canvas canvas, Size size) {
    if (!isActive) return;
    final paint = Paint();
    const double step = 5;
    for (double y = 0; y < size.height; y += step) {
      for (double x = 0; x < size.width; x += step) {
        final rand = math.Random((x + y + (offset * 100)).toInt()).nextDouble();
        final intensity = (math.sin(x/50 + offset*5).abs() * 0.4) + (amp * 0.5) + (rand * 0.1);
        if (intensity > 0.4) {
          paint.color = Color.lerp(Colors.blue.withOpacity(0.2), Colors.cyanAccent, (intensity-0.4)*2)!.withOpacity(intensity.clamp(0.1, 0.7));
          canvas.drawRect(Rect.fromLTWH(x, y, step - 1, step - 1), paint);
        }
      }
    }
  }
  @override
  bool shouldRepaint(covariant _WPainter oldDelegate) => true;
}

class _SettingsPanel extends StatefulWidget {
  final SecurityAgent securityAgent;
  final Function(String) onSave;

  const _SettingsPanel({required this.securityAgent, required this.onSave});

  @override
  State<_SettingsPanel> createState() => _SettingsPanelState();
}

class _SettingsPanelState extends State<_SettingsPanel> {
  final _callsignCtrl = TextEditingController();
  final _qthCtrl = TextEditingController();
  final _qrzPassCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    final creds = await widget.securityAgent.getCredentials();
    setState(() {
      _callsignCtrl.text = creds.callsign;
      _qthCtrl.text = creds.qthLocator;
      _qrzPassCtrl.text = creds.qrzPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF0F0F0F).withOpacity(0.9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white10),
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("TACTICAL CONFIGURATION", style: GoogleFonts.orbitron(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.cyanAccent)),
                const SizedBox(height: 24),
                _field("INDICATIVO (CALLSIGN)", _callsignCtrl, false),
                const SizedBox(height: 12),
                _field("QTH LOCATOR (GRID)", _qthCtrl, false),
                const SizedBox(height: 12),
                _field("QRZ PASSWORD", _qrzPassCtrl, true),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text("ABORT", style: TextStyle(color: Colors.white38))),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.cyanAccent, foregroundColor: Colors.black),
                      onPressed: () async {
                        await widget.securityAgent.saveCredentials(UserCredentials(
                          callsign: _callsignCtrl.text,
                          qthLocator: _qthCtrl.text,
                          qrzPassword: _qrzPassCtrl.text,
                        ));
                        widget.onSave(_callsignCtrl.text);
                        Navigator.pop(context);
                      }, 
                      child: const Text("SYNC & SAVE")
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.9, 0.9));
  }

  Widget _field(String label, TextEditingController ctrl, bool secret) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.orbitron(fontSize: 8, color: Colors.white38)),
        TextField(
          controller: ctrl,
          obscureText: secret,
          style: GoogleFonts.robotoMono(fontSize: 14, color: Colors.white),
          decoration: const InputDecoration(
            isDense: true,
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white10)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyanAccent)),
          ),
        ),
      ],
    );
  }
}
