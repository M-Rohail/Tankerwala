import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tankerwala/core/theme/app_colors.dart';
import 'package:tankerwala/core/theme/app_text_styles.dart';

class TwTextField extends StatefulWidget {
  const TwTextField({
    super.key,
    required this.label,
    this.hint,
    this.urduLabel,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final String label;
  final String? hint;
  final String? urduLabel;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool enabled;
  final int maxLines;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  @override
  State<TwTextField> createState() => _TwTextFieldState();
}

class _TwTextFieldState extends State<TwTextField> {
  bool _obscure = true;
  final _focusNode = FocusNode();
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
    _focusNode.addListener(() {
      setState(() => _focused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(widget.label, style: AppTextStyles.labelMedium),
            if (widget.urduLabel != null) ...[
              const Spacer(),
              Text(widget.urduLabel!,
                  style: AppTextStyles.urduSubtle),
            ],
          ],
        ),
        const SizedBox(height: 7),
        AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: _focused
                ? [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.10),
                blurRadius: 10,
                offset: const Offset(0, 3),
              )
            ]
                : [],
          ),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            keyboardType: widget.keyboardType,
            obscureText: widget.obscureText ? _obscure : false,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters,
            onChanged: widget.onChanged,
            enabled: widget.enabled,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            textInputAction: widget.textInputAction,
            onFieldSubmitted: widget.onFieldSubmitted,
            style: const TextStyle(
              fontSize: 15,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: widget.hint,
              prefixIcon: widget.prefixIcon != null
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: widget.prefixIcon,
              )
                  : null,
              prefixIconConstraints: const BoxConstraints(minWidth: 48),
              suffixIcon: widget.obscureText
                  ? GestureDetector(
                onTap: () => setState(() => _obscure = !_obscure),
                child: Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: Icon(
                    _obscure
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                ),
              )
                  : widget.suffixIcon,
              suffixIconConstraints:
              const BoxConstraints(minWidth: 48),
            ),
          ),
        ),
      ],
    );
  }
}