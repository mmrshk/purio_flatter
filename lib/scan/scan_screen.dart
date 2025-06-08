import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
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
  final MobileScannerController _barcodeController = MobileScannerController(
    formats: [BarcodeFormat.ean13, BarcodeFormat.ean8, BarcodeFormat.code128, BarcodeFormat.code39, BarcodeFormat.upcA, BarcodeFormat.upcE],
    autoStart: true,
  );
  String? _lastScannedCode;
  bool isProcessingBarcode = false;
  StreamSubscription<Object?>? _barcodeSubscription;
  bool _scannerStarted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startScanner();
  }

  void _startScanner() {
    if (!_scannerStarted) {
      _barcodeSubscription = _barcodeController.barcodes.listen(_onBarcodeDetected);
      _barcodeController.start();
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
        _barcodeSubscription?.cancel();
        _barcodeSubscription = null;
        _barcodeController.stop();
        break;
      case AppLifecycleState.resumed:
        _startScanner();
        break;
      case AppLifecycleState.inactive:
        _barcodeSubscription?.cancel();
        _barcodeSubscription = null;
        _barcodeController.stop();
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
    _barcodeSubscription?.cancel();
    _barcodeSubscription = null;
    _barcodeController.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  void _toggleFlash() {
    if (_cameraController != null) {
      isFlashOn = !isFlashOn;
      _cameraController!.setFlashMode(
        isFlashOn ? FlashMode.torch : FlashMode.off,
      );
      setState(() {});
    }
  }

  void _onBarcodeDetected(BarcodeCapture capture) async {
    print('Barcode detected: ${capture.barcodes.map((b) => b.rawValue).toList()}');
    final String? code = capture.barcodes.first.rawValue;
    
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
        .from('Products')
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
                ? MobileScanner(
                    controller: _barcodeController,
                    onDetect: (_) {},
                    errorBuilder: (context, error, child) {
                      return Center(
                        child: Text(
                          'Camera error: $error',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                      );
                    },
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          // Overlay frame
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(color: isProcessingBarcode ? Colors.blue : Colors.white, width: 4),
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
