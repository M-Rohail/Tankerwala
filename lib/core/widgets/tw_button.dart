import 'package:flutter/material.dart';
import 'package:tankerwala/core/theme/app_colors.dart';

class TwButton extends StatefulWidget {
  const TwButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.color,
    this.textColor,
    this.outlined = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  final bool outlined;
  final IconData? icon;

  @override
  State<TwButton> createState() => _TwButtonState();
}

class _TwButtonState extends State<TwButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    _scale = Tween<double>(begin: 1.0, end: 0.97).animate(
        CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = widget.color ?? AppColors.primary;

    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: widget.outlined ? _buildOutlined(bg) : _buildFilled(bg),
      ),
    );
  }

  Widget _buildFilled(Color bg) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
        ),
        child: widget.isLoading
            ? const SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
                color: Colors.white, strokeWidth: 2.5))
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, size: 20,
                  color: widget.textColor ?? Colors.white),
              const SizedBox(width: 8),
            ],
            Text(
              widget.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: widget.textColor ?? Colors.white,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutlined(Color bg) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: OutlinedButton(
        onPressed: widget.isLoading ? null : widget.onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: bg.withValues(alpha: 0.4), width: 1.5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16)),
          backgroundColor: bg.withValues(alpha: 0.04),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.icon != null) ...[
              Icon(widget.icon, size: 20, color: bg),
              const SizedBox(width: 8),
            ],
            Text(widget.label,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: bg)),
          ],
        ),
      ),
    );
  }
}