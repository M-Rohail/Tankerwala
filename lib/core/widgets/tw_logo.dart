import 'package:flutter/material.dart';
import 'package:tankerwala/core/theme/app_colors.dart';

class TwLogo extends StatelessWidget {
  const TwLogo({super.key, this.size = 64, this.showText = true, this.light = false});

  final double size;
  final bool showText;
  final bool light;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: light
                ? Colors.white.withValues(alpha: 0.2)
                : AppColors.primary,
            borderRadius: BorderRadius.circular(size * 0.26),
            border: light
                ? Border.all(
                color: Colors.white.withValues(alpha: 0.3), width: 1.5)
                : null,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.water_drop_rounded,
                  color: light ? Colors.white : AppColors.accentLight,
                  size: size * 0.46),
              Positioned(
                bottom: size * 0.1,
                right: size * 0.1,
                child: Container(
                  width: size * 0.3,
                  height: size * 0.2,
                  decoration: BoxDecoration(
                    color: light
                        ? Colors.white.withValues(alpha: 0.3)
                        : AppColors.accent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(Icons.local_shipping_rounded,
                      color: Colors.white, size: size * 0.14),
                ),
              ),
            ],
          ),
        ),
        if (showText) ...[
          const SizedBox(height: 10),
          Text(
            'TankerWala',
            style: TextStyle(
              fontSize: size * 0.34,
              fontWeight: FontWeight.w800,
              color: light ? Colors.white : AppColors.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            'ٹینکر والا',
            style: TextStyle(
              fontSize: size * 0.20,
              color: light
                  ? Colors.white.withValues(alpha: 0.65)
                  : AppColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }
}