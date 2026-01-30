import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A reusable input field component with consistent styling.
///
/// Features:
/// - Label support
/// - Helper text
/// - Validation error display
/// - Prefix/suffix support
/// - Theme-aware styling
class AppInputField extends StatelessWidget {
  final String? label;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool enabled;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffix;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final Color? fillColor;

  AppInputField({
    super.key,
    this.label,
    this.helperText,
    this.errorText,
    this.controller,
    this.initialValue,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffix,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.contentPadding,
    this.border,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          enabled: enabled,
          maxLines: maxLines,
          onChanged: onChanged,
          onSaved: onSaved,
          validator: validator,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffix: suffix,
            hintText: hintText,
            hintStyle: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
            contentPadding: contentPadding ?? 
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            filled: true,
            fillColor: fillColor ?? 
                (theme.brightness == Brightness.dark 
                    ? Colors.white.withOpacity(0.05)
                    : Colors.grey.withOpacity(0.05)),
            border: border ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline,
                    width: 1,
                  ),
                ),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.outline,
                    width: 1,
                  ),
                ),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                ),
            errorBorder: errorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: Colors.red,
                    width: 1,
                  ),
                ),
            errorText: errorText,
            helperText: helperText,
          ),
        ),
      ],
    );
  }
}