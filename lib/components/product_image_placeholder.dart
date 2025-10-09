import 'package:flutter/material.dart';

class ProductImagePlaceholder extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? iconColor;
  final double iconSize;

  const ProductImagePlaceholder({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
    this.backgroundColor,
    this.iconColor,
    this.iconSize = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFF5F5F5), // Light gray background
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Icon(
          Icons.landscape, // Mountain/landscape icon
          size: iconSize,
          color: iconColor ?? const Color(0xFF9E9E9E), // Darker gray icon
        ),
      ),
    );
  }
}
