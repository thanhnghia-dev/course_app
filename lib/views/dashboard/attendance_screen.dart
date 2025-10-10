import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:course_app/core/utils/util.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Set<String> scannedQRCodes = {};
  final MobileScannerController cameraController = MobileScannerController();
  final AudioPlayer _player = AudioPlayer();
  bool _isTorchOn = false;

  // ✅ Khóa quét để tránh spam callback
  bool _isScanning = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    cameraController.dispose();
    _player.dispose();
    super.dispose();
  }

  // Play Beep sound
  Future<void> _playBeep() async {
    await _player.play(AssetSource('sounds/beep.mp3'));
  }

  // Show Barcode dialog
  Future<void> _showBarcodeDialog(String code) async {
    if (!mounted) return;
    if (scannedQRCodes.contains(code)) {
      showOverlayToast(context, '$code đã được quét rồi!');
    } else {
      scannedQRCodes.add(code);
      await _playBeep();
      showOverlayToast(context, code);
    }
  }

  @override
  Widget build(BuildContext context) {
    const double scanBoxSize = 250;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Điểm danh',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isTorchOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.white,
            ),
            onPressed: () async {
              await cameraController.toggleTorch();
              setState(() => _isTorchOn = !_isTorchOn);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera
          MobileScanner(
            controller: cameraController,
            onDetect: (capture) async {
              if (!_isScanning) return; // ✅ khóa tạm để tránh spam

              final List<Barcode> barcodes = capture.barcodes;
              if (barcodes.isEmpty) return;

              final String code = barcodes.first.rawValue ?? "Không đọc được";

              // ✅ bỏ qua mã rỗng hoặc không đọc được
              if (code.trim().isEmpty || code == "Không đọc được") return;

              _isScanning = false; // khóa quét
              await _showBarcodeDialog(code);

              // mở lại quét sau 2 giây
              Future.delayed(const Duration(seconds: 2), () {
                if (mounted) _isScanning = true;
              });
            },
          ),

          // Overlay + góc khung
          ScanOverlay(scanBoxSize: scanBoxSize),

          // Text hướng dẫn
          const Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Đưa mã vào trong khung để quét",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScanOverlay extends StatelessWidget {
  final double scanBoxSize;
  const ScanOverlay({super.key, required this.scanBoxSize});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double screenWidth = constraints.maxWidth;
      final double screenHeight = constraints.maxHeight;
      final double left = (screenWidth - scanBoxSize) / 2;
      final double top = (screenHeight - scanBoxSize) / 2;

      return Stack(
        children: [
          // Nền tối, chừa khung trong suốt
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.srcOut,
            ),
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut,
                  ),
                ),
                Positioned(
                  left: left,
                  top: top,
                  child: Container(
                    width: scanBoxSize,
                    height: scanBoxSize,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // 4 góc sáng
          Positioned(
            left: left,
            top: top,
            child: CustomPaint(
              size: Size(scanBoxSize, scanBoxSize),
              painter: CornerPainter(),
            ),
          ),
        ],
      );
    });
  }
}

class CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;

    const double cornerLength = 30;

    // Góc trái trên
    canvas.drawLine(Offset(0, 0), Offset(cornerLength, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, cornerLength), paint);

    // Góc phải trên
    canvas.drawLine(Offset(size.width, 0),
        Offset(size.width - cornerLength, 0), paint);
    canvas.drawLine(Offset(size.width, 0),
        Offset(size.width, cornerLength), paint);

    // Góc trái dưới
    canvas.drawLine(Offset(0, size.height),
        Offset(cornerLength, size.height), paint);
    canvas.drawLine(Offset(0, size.height),
        Offset(0, size.height - cornerLength), paint);

    // Góc phải dưới
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - cornerLength, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width, size.height - cornerLength), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
