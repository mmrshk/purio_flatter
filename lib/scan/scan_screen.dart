import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:async';
import '/product/product_details/product_details_widget.dart';
import '/backend/supabase/database/tables/product.dart';
import '/flutter_flow/internationalization.dart';
import '/components/add_product_dialog.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> with WidgetsBindingObserver {
  bool isFlashOn = false;
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
        // Reset processing state when app is resumed
        if (isProcessingBarcode) {
          setState(() {
            isProcessingBarcode = false;
          });
        }
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
    // Reset processing state when returning to scan screen
    if (isProcessingBarcode) {
      setState(() {
        isProcessingBarcode = false;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _qrViewController?.pauseCamera();
    _qrViewController?.dispose();
    super.dispose();
  }

  Future<void> _handleClose() async {
    try {
      await _qrViewController?.pauseCamera();
      await Future.delayed(const Duration(milliseconds: 150));
    } catch (e) {
      // ignore pause errors
    }
    if (mounted) {
      Navigator.pop(context);
    }
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
    if (code != null) {
      _processBarcode(code);
    }
  }
    
  void _processBarcode(String code) async {
    if (code != _lastScannedCode && !isProcessingBarcode) {
      setState(() {
        isProcessingBarcode = true;
        _lastScannedCode = code;
      });

      final result = await Supabase.instance.client
          .from('products')
          .select()
          .eq('barcode', code)
          .eq('visible', true)
          .maybeSingle();

      print('Product result: $result');

      if (result != null) {
        print('Mounted: ${mounted}');
        if (mounted) {
          // Turn off flashlight if it's on
          if (isFlashOn && _qrViewController != null) {
            _qrViewController!.toggleFlash();
            isFlashOn = false;
          }
          
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ProductDetailsWidget(
              product: ProductRow(result),
              fromScan: true,
            ),
          )).then((_) {
            // Reset processing state when returning from product details
            if (mounted) {
              setState(() {
                isProcessingBarcode = false;
                _lastScannedCode = null; // Reset to allow re-scanning
              });
            }
          });
        }
      } else {
        if (mounted) {
          setState(() => isProcessingBarcode = false);
          
          // Show dialog to add product
          await AddProductDialog.show(context, code);
          
          // Reset last scanned code after dialog closes to allow re-scanning
          if (mounted) {
            setState(() {
              _lastScannedCode = null;
            });
          }
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
              onPressed: _handleClose,
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
          // Scan instruction text
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  FFLocalizations.of(context).getText('scan_barcode_text'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
