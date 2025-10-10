import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/scan/mock_scanner.dart';
import '/scan/scan_screen.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'navbar_model.dart';
import 'dart:io' show Platform, Process;
import 'dart:async';
import 'dart:ui';

export 'navbar_model.dart';

class NavbarWidget extends StatefulWidget {
  final Color backgroundColor;
  final ScrollController? scrollController;
  
  const NavbarWidget({
    super.key,
    this.backgroundColor = Colors.white,
    this.scrollController,
  });

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> with RouteAware {
  late NavbarModel _model;
  int _selectedIndex = 0; // 0 = Top, 1 = Scan, 2 = History

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NavbarModel());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    _model.maybeDispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(NavbarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _model.widget = widget;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = DebugModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route);
    }
    debugLogGlobalProperty(context);
  }

  @override
  void didPopNext() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPush() {
    if (mounted && DebugFlutterFlowModelContext.maybeOf(context) == null) {
      setState(() => _model.isRouteVisible = true);
      debugLogWidgetClass(_model);
    }
  }

  @override
  void didPop() {
    _model.isRouteVisible = false;
  }

  @override
  void didPushNext() {
    _model.isRouteVisible = false;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // Scroll to top
        _scrollToTop();
        break;
      case 1: // Scan
        _handleScanTap();
        break;
      case 2: // History
        context.pushNamed(HistoryWidget.routeName);
        break;
    }
  }

  void _scrollToTop() {
    if (widget.scrollController != null && widget.scrollController!.hasClients) {
      widget.scrollController!.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _handleScanTap() async {
    if (Platform.isIOS && !Platform.environment.containsKey('FLUTTER_TEST')) {
      // Check if we're running in a simulator
      final isSimulator = await _isSimulator();
      if (isSimulator) {
        // Show mock scanner in simulator
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MockScanner(
              onScan: (String barcode) {
                Navigator.pop(context, barcode);
              },
            ),
          ),
        );
        
        if (result != null) {
          _model.barcodeValue = result;
          _model.apiResultOpenFoods = await OpenFoodFactsAPICall.call(
            barCodeValue: _model.barcodeValue,
          );

          if ((_model.apiResultOpenFoods?.succeeded ?? true)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Found',
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                duration: const Duration(milliseconds: 4000),
                backgroundColor: FlutterFlowTheme.of(context).secondary,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Not found',
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                duration: const Duration(milliseconds: 4000),
                backgroundColor: FlutterFlowTheme.of(context).error,
              ),
            );
          }
        }
      } else {
        // Use ScanScreen on physical devices
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ScanScreen(),
          ),
        );
        
        if (result != null) {
          _model.barcodeValue = result;
          _model.apiResultOpenFoods = await OpenFoodFactsAPICall.call(
            barCodeValue: _model.barcodeValue,
          );

          if ((_model.apiResultOpenFoods?.succeeded ?? true)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Found',
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                duration: const Duration(milliseconds: 4000),
                backgroundColor: FlutterFlowTheme.of(context).secondary,
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Not found',
                  style: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
                duration: const Duration(milliseconds: 4000),
                backgroundColor: FlutterFlowTheme.of(context).error,
              ),
            );
          }
        }
      }
    } else {
      // Use ScanScreen on Android and web
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ScanScreen(),
        ),
      );
      
      if (result != null) {
        _model.barcodeValue = result;
        _model.apiResultOpenFoods = await OpenFoodFactsAPICall.call(
          barCodeValue: _model.barcodeValue,
        );

        if ((_model.apiResultOpenFoods?.succeeded ?? true)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Found',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              duration: const Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).secondary,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Not found',
                style: TextStyle(
                  color: FlutterFlowTheme.of(context).primaryText,
                ),
              ),
              duration: const Duration(milliseconds: 4000),
              backgroundColor: FlutterFlowTheme.of(context).error,
            ),
          );
        }
      }
    }

    safeSetState(() {});
  }

  @override
  Widget build(BuildContext context) {
    DebugFlutterFlowModelContext.maybeOf(context)
        ?.parentModelCallback
        ?.call(_model);

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Modern floating navbar
          Container(
            margin: const EdgeInsets.fromLTRB(48, 8, 48, 24),
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 40,
                  spreadRadius: 0,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
                      _buildNavItem(1, Icons.qr_code_scanner_rounded, Icons.qr_code_scanner_rounded, 'Scan'),
                      _buildNavItem(2, Icons.history_outlined, Icons.history, 'History'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom padding for safe area
          Container(
            height: MediaQuery.of(context).padding.bottom,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }

  Future<bool> _isSimulator() async {
    if (Platform.isIOS) {
      try {
        final result = await Process.run('xcrun', ['simctl', 'list', 'devices']);
        return result.stdout.toString().contains('Booted');
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF50B2B2).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: Icon(
                isSelected ? activeIcon : icon,
                size: isSelected ? 26 : 24,
                color: isSelected ? const Color(0xFF50B2B2) : Colors.grey[500],
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: isSelected ? 11 : 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? const Color(0xFF50B2B2) : Colors.grey[500],
                letterSpacing: 0.2,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
