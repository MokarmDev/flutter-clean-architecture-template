import 'package:flutter/material.dart';

class AppDesignColors {
  const AppDesignColors({
    required this.brand,
    required this.brandAccent,
    required this.success,
    required this.warning,
    required this.error,
    required this.info,
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.surfaceStrong,
    required this.border,
    required this.text,
    required this.textMuted,
    required this.textSubtle,
    required this.inverseText,
    required this.disabled,
    required this.shadow,
    required this.shimmerBase,
    required this.shimmerHighlight,
  });

  final Color brand;
  final Color brandAccent;
  final Color success;
  final Color warning;
  final Color error;
  final Color info;
  final Color background;
  final Color surface;
  final Color surfaceMuted;
  final Color surfaceStrong;
  final Color border;
  final Color text;
  final Color textMuted;
  final Color textSubtle;
  final Color inverseText;
  final Color disabled;
  final Color shadow;
  final Color shimmerBase;
  final Color shimmerHighlight;

  static const light = AppDesignColors(
    brand: Color(0xFF4F46E5),
    brandAccent: Color(0xFF06B6D4),
    success: Color(0xFF16A34A),
    warning: Color(0xFFF59E0B),
    error: Color(0xFFEF4444),
    info: Color(0xFF2563EB),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF1F5F9),
    surfaceStrong: Color(0xFFE2E8F0),
    border: Color(0xFFE2E8F0),
    text: Color(0xFF0F172A),
    textMuted: Color(0xFF475569),
    textSubtle: Color(0xFF94A3B8),
    inverseText: Color(0xFFFFFFFF),
    disabled: Color(0xFFCBD5E1),
    shadow: Color(0x1A0F172A),
    shimmerBase: Color(0xFFE2E8F0),
    shimmerHighlight: Color(0xFFF8FAFC),
  );

  static const dark = AppDesignColors(
    brand: Color(0xFF818CF8),
    brandAccent: Color(0xFF22D3EE),
    success: Color(0xFF22C55E),
    warning: Color(0xFFFBBF24),
    error: Color(0xFFF87171),
    info: Color(0xFF60A5FA),
    background: Color(0xFF0F172A),
    surface: Color(0xFF1E293B),
    surfaceMuted: Color(0xFF334155),
    surfaceStrong: Color(0xFF475569),
    border: Color(0xFF475569),
    text: Color(0xFFF8FAFC),
    textMuted: Color(0xFFCBD5E1),
    textSubtle: Color(0xFF94A3B8),
    inverseText: Color(0xFF0F172A),
    disabled: Color(0xFF64748B),
    shadow: Color(0x66000000),
    shimmerBase: Color(0xFF334155),
    shimmerHighlight: Color(0xFF475569),
  );
}
