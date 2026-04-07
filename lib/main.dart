import 'package:flutter/material.dart';

void main() {
  runApp(const DigitalHamApp());
}

class DigitalHamApp extends StatelessWidget {
  const DigitalHamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DigitalHam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _mode = 'FT8';
  bool _isTransmitting = false;
  bool _isReceiving = false;
  String _statusMessage = 'Ready';

  void _startTx() {
    setState(() {
      _isTransmitting = true;
      _isReceiving = false;
      _statusMessage = 'Transmitting...';
    });
  }

  void _startRx() {
    setState(() {
      _isTransmitting = false;
      _isReceiving = true;
      _statusMessage = 'Listening for signals...';
    });
  }

  void _stop() {
    setState(() {
      _isTransmitting = false;
      _isReceiving = false;
      _statusMessage = 'Ready';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DigitalHam'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          PopupMenuButton<String>(
            initialValue: _mode,
            onSelected: (mode) => setState(() => _mode = mode),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'FT8', child: Text('FT8')),
              const PopupMenuItem(value: 'FT4', child: Text('FT4')),
              const PopupMenuItem(value: 'FT2', child: Text('FT2')),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [Text(_mode), const Icon(Icons.arrow_drop_down)],
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildWaterfall(),
                    const SizedBox(height: 24),
                    Text(
                      _statusMessage,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [_buildTxButton(), _buildRxButton()],
            ),
            const SizedBox(height: 24),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildWaterfall() {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: _isReceiving ? Colors.green : Colors.grey,
          width: 2,
        ),
      ),
      child: CustomPaint(
        painter: _WaterfallPainter(
          isReceiving: _isReceiving,
          isTransmitting: _isTransmitting,
        ),
      ),
    );
  }

  Widget _buildTxButton() {
    return ElevatedButton.icon(
      onPressed: _isTransmitting ? _stop : _startTx,
      icon: Icon(_isTransmitting ? Icons.stop : Icons.mic),
      label: Text(_isTransmitting ? 'Stop TX' : 'TX'),
      style: ElevatedButton.styleFrom(
        backgroundColor: _isTransmitting ? Colors.red : Colors.orange,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }

  Widget _buildRxButton() {
    return ElevatedButton.icon(
      onPressed: _isReceiving ? _stop : _startRx,
      icon: Icon(_isReceiving ? Icons.stop : Icons.hearing),
      label: Text(_isReceiving ? 'Stop RX' : 'RX'),
      style: ElevatedButton.styleFrom(
        backgroundColor: _isReceiving ? Colors.red : Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }

  Widget _buildMessageInput() {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Enter your message (e.g., K1XYZ R3W4)',
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.send),
      ),
    );
  }
}

class _WaterfallPainter extends CustomPainter {
  final bool isReceiving;
  final bool isTransmitting;

  _WaterfallPainter({required this.isReceiving, required this.isTransmitting});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    final random = DateTime.now().millisecondsSinceEpoch;

    for (var y = 0.0; y < size.height; y += 4) {
      for (var x = 0.0; x < size.width; x += 4) {
        final noise = ((x * 7 + y * 13 + random) % 20) - 10;
        final intensity = isReceiving ? 0.3 + (noise / 40) : 0.1;

        final hue = 120 + (x / size.width * 60);
        paint.color = HSLColor.fromAHSL(1, hue, 0.8, intensity).toColor();
        canvas.drawRect(Rect.fromLTWH(x, y, 4, 4), paint);
      }
    }

    if (isTransmitting) {
      final bandPaint = Paint()
        ..color = Colors.orange.withAlpha(180)
        ..style = PaintingStyle.fill;

      final bandCenter = size.width / 2;
      final bandWidth = size.width * 0.3;

      final rect = Rect.fromCenter(
        center: Offset(bandCenter, size.height / 2),
        width: bandWidth,
        height: size.height,
      );

      canvas.drawRect(rect, bandPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _WaterfallPainter oldDelegate) {
    return oldDelegate.isReceiving != isReceiving ||
        oldDelegate.isTransmitting != isTransmitting;
  }
}
