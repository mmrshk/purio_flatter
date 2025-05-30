import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';

class ScanScreen extends StatefulWidget {
  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool isBarcodeMode = true;
  bool isFlashOn = false;
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  MobileScannerController _barcodeController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _cameraController = CameraController(
        _cameras!.first,
        ResolutionPreset.medium,
        enableAudio: false,
      );
      await _cameraController!.initialize();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  void _toggleFlash() {
    if (isBarcodeMode) {
      _barcodeController.toggleTorch();
    } else {
      if (_cameraController != null) {
        isFlashOn = !isFlashOn;
        _cameraController!.setFlashMode(
          isFlashOn ? FlashMode.torch : FlashMode.off,
        );
        setState(() {});
      }
    }
  }

  Future<void> _takePhoto() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;
    final XFile file = await _cameraController!.takePicture();
    // Optionally, save to gallery or temp directory
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    await file.saveTo(tempPath);

    // TODO: Call your Supabase API with the photo file
    // final result = await yourSupabaseApiCall(File(tempPath));
    // if (result != null) {
    //   Navigator.pushNamed(context, '/productDetails', arguments: result);
    // }
  }

  void _onBarcodeDetected(BarcodeCapture capture) async {
    final String? code = capture.barcodes.first.rawValue;
    if (code != null) {
      // TODO: Call your Supabase API with the barcode
      // final result = await yourSupabaseApiCall(code);
      // if (result != null) {
      //   Navigator.pushNamed(context, '/productDetails', arguments: result);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: isBarcodeMode
                ? MobileScanner(
                    controller: _barcodeController,
                    allowDuplicates: false,
                    onDetect: _onBarcodeDetected,
                  )
                : (_cameraController != null && _cameraController!.value.isInitialized)
                    ? CameraPreview(_cameraController!)
                    : Center(child: CircularProgressIndicator()),
          ),
          // Overlay frame
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 4),
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
          ),
          // Close button
          Positioned(
            top: 60,
            left: 24,
            child: IconButton(
              icon: Icon(Icons.close, size: 36, color: Colors.teal),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Flash button
          Positioned(
            top: 60,
            right: 24,
            child: IconButton(
              icon: Icon(
                isFlashOn ? Icons.flash_on : Icons.flash_off,
                size: 36,
                color: Colors.teal,
              ),
              onPressed: _toggleFlash,
            ),
          ),
          // Bottom buttons
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ScanButton(
                  icon: Icons.camera_alt,
                  label: 'Photo',
                  selected: !isBarcodeMode,
                  onTap: () => setState(() => isBarcodeMode = false),
                  onAction: _takePhoto,
                  enabled: !isBarcodeMode,
                ),
                _ScanButton(
                  icon: Icons.qr_code_scanner,
                  label: 'Barcode',
                  selected: isBarcodeMode,
                  onTap: () => setState(() => isBarcodeMode = true),
                  enabled: isBarcodeMode,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback? onAction;
  final bool enabled;

  const _ScanButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.onAction,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 56,
        decoration: BoxDecoration(
          color: selected ? Colors.teal : Colors.black,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (onAction != null && enabled)
              IconButton(
                icon: Icon(Icons.circle, color: Colors.white, size: 20),
                onPressed: onAction,
              ),
          ],
        ),
      ),
    );
  }
}
