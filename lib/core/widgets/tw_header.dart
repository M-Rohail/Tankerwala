import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class WaveHeaderPainter extends CustomPainter {
  const WaveHeaderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = AppColors.primaryMid.withValues(alpha: 0.25)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = AppColors.accent.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;

    // Wave 1
    final path1 = Path();
    path1.moveTo(0, size.height * 0.7);
    path1.cubicTo(
      size.width * 0.25, size.height * 0.55,
      size.width * 0.5, size.height * 0.85,
      size.width, size.height * 0.65,
    );
    path1.lineTo(size.width, size.height);
    path1.lineTo(0, size.height);
    path1.close();
    canvas.drawPath(path1, paint1);

    // Wave 2
    final path2 = Path();
    path2.moveTo(0, size.height * 0.82);
    path2.cubicTo(
      size.width * 0.3, size.height * 0.65,
      size.width * 0.65, size.height * 0.95,
      size.width, size.height * 0.78,
    );
    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Reusable dark header with wave + poetry
class TwHeader extends StatelessWidget {
  const TwHeader({
    super.key,
    required this.title,
    required this.titleUrdu,
    required this.poetryLine,
    required this.poetryTranslation,
    this.height = 260,
    this.showBackButton = false,
  });

  final String title;
  final String titleUrdu;
  final String poetryLine;
  final String poetryTranslation;
  final double height;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          // Dark blue background
          Container(
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
          ),

          // Decorative circles
          Positioned(
            top: -30,
            right: -20,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryMid.withValues(alpha: 0.3),
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 60,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accent.withValues(alpha: 0.2),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: -15,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryMid.withValues(alpha: 0.2),
              ),
            ),
          ),

          // Wave at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 80),
              painter: const WaveHeaderPainter(),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (showBackButton)
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.white, size: 16),
                      ),
                    ),

                  const Spacer(),

                  // Water drop icon
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.water_drop_rounded,
                        color: AppColors.accentLight, size: 24),
                  ),

                  const SizedBox(height: 12),

                  Text(title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                        height: 1.1,
                      )),
                  Text(titleUrdu,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.6),
                        height: 1.5,
                      )),

                  const SizedBox(height: 16),

                  // Poetry divider
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                  const SizedBox(height: 12),

                  Text(poetryLine,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                      )),
                  Text(poetryTranslation,
                      style: TextStyle(
                        fontSize: 11,
                        color: AppColors.accentLight.withValues(alpha: 0.8),
                        height: 1.4,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}