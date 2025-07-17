import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';
import '/product/product_details/product_details_widget.dart';
import '/backend/supabase/database/tables/product.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  bool isFlashOn = false;
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _qrViewController;
  String? _lastScannedCode;
  bool isProcessingBarcode = false;
  bool _scannerStarted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startScanner();
  }

  void _startScanner() {
    if (!_scannerStarted) {
      setState(() {
        _scannerStarted = true;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        _qrViewController?.pauseCamera();
        break;
      case AppLifecycleState.resumed:
        _qrViewController?.resumeCamera();
        break;
      case AppLifecycleState.inactive:
        _qrViewController?.pauseCamera();
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _startScanner();
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
    WidgetsBinding.instance.removeObserver(this);
    _qrViewController?.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  void _toggleFlash() {
    if (_qrViewController != null) {
      isFlashOn = !isFlashOn;
      _qrViewController!.toggleFlash();
      setState(() {});
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    _qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      _onBarcodeDetected(scanData);
    });
  }

  void _onBarcodeDetected(Barcode scanData) async {
    print('Barcode detected: ${scanData.code}');
    final String? code = scanData.code;
    
    if (code != null && code != _lastScannedCode && !isProcessingBarcode) {
      setState(() {
        isProcessingBarcode = true;
        _lastScannedCode = code;
      });

      //  final result = await Supabase.instance.client
      //     .from('Products')
      //     .select()
      //     .eq('barcode', code)
      //     .maybeSingle();

      final products = await Supabase.instance.client
        .from('products')
        .select()
        .order('id', ascending: false)
        .limit(1);

      print('Products: $products');

      if (products.isNotEmpty) {
        print('Mounted: ${mounted}');
        if (mounted) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ProductDetailsWidget(
              product: ProductRow(products.first),
              fromScan: true,
            ),
          ));
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product not found')),
          );
          setState(() => isProcessingBarcode = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned.fill(
            child: _scannerStarted
                ? QRView(
                    key: qrKey,
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                      borderColor: isProcessingBarcode ? Colors.blue : Colors.white,
                      borderRadius: 24,
                      borderLength: 30,
                      borderWidth: 4,
                      cutOutSize: 300,
                    ),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          // Close button
          Positioned(
            top: 60,
            left: 24,
            child: IconButton(
              icon: const Icon(Icons.close, size: 36, color: Colors.teal),
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
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            if (onAction != null && enabled)
              IconButton(
                icon: const Icon(Icons.circle, color: Colors.white, size: 20),
                onPressed: onAction,
              ),
          ],
        ),
      ),
    );
  }
}
