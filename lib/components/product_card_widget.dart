import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/supabase/supabase.dart';
import '/services/scoring_service.dart';
import '/services/favorites_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'product_card_model.dart';
export 'product_card_model.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({
    super.key,
    required this.product,
  });

  final ProductRow product;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> with RouteAware {
  late ProductCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductCardModel());
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    try {
      _model.isLoadingFavorite = true;
      if (mounted) setState(() {});
      
      final isFavorite = await FavoritesService.isFavorite(widget.product.id);
      
      if (mounted) {
        setState(() {
          _model.isFavorite = isFavorite;
          _model.isLoadingFavorite = false;
        });
      }
    } catch (e) {
      print('Error checking favorite status: $e');
      if (mounted) {
        setState(() {
          _model.isLoadingFavorite = false;
        });
      }
    }
  }

  Future<void> _toggleFavorite() async {
    try {
      _model.isLoadingFavorite = true;
      if (mounted) setState(() {});
      
      if (_model.isFavorite) {
        await FavoritesService.removeFromFavorites(widget.product.id);
        if (mounted) {
          setState(() {
            _model.isFavorite = false;
            _model.isLoadingFavorite = false;
          });
        }
      } else {
        await FavoritesService.addToFavorites(widget.product.id);
        if (mounted) {
          setState(() {
            _model.isFavorite = true;
            _model.isLoadingFavorite = false;
          });
        }
      }
    } catch (e) {
      print('Error toggling favorite: $e');
      if (mounted) {
        setState(() {
          _model.isLoadingFavorite = false;
        });
      }
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);

    _model.maybeDispose();

    super.dispose();
  }

  @override
  void didUpdateWidget(ProductCardWidget oldWidget) {
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

  @override
  Widget build(BuildContext context) {
    DebugFlutterFlowModelContext.maybeOf(context)
        ?.parentModelCallback
        ?.call(_model);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFFE0F7FA), Color(0xFFE8F5E9)], // Light blue to light green
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.product.imageFrontUrl ?? 'https://picsum.photos/seed/895/600',
                width: 80.0,
                height: 80.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.product.category ?? 'Lorem',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                          color: const Color(0xFF6A7F98),
                          fontSize: 14.0,
                        ),
                  ),
                  Text(
                    widget.product.name ?? 'Orange Juice 1L',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  if (widget.product.healthScore != null)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (widget.product.healthScore ?? 0) > 70
                            ? const Color(0xFF2ECC71)
                            : const Color(0xFFE74C3C),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        'Safety: ${widget.product.healthScore}/100',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                              color: Colors.white,
                              fontSize: 12.0,
                            ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: GestureDetector(
                onTap: _model.isLoadingFavorite ? null : _toggleFavorite,
                child: _model.isLoadingFavorite
                    ? SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: FlutterFlowTheme.of(context).primaryColor,
                        ),
                      )
                    : Icon(
                        _model.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _model.isFavorite
                            ? Colors.red
                            : FlutterFlowTheme.of(context).primaryColor,
                        size: 24.0,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
