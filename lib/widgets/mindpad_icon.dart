import 'package:flutter/material.dart';
import 'package:mynotes/theme/app_theme.dart';

class MindPadIcon extends StatelessWidget {
  final double size;
  final bool showGlow;

  const MindPadIcon({super.key, this.size = 56, this.showGlow = true});

  @override
  Widget build(BuildContext context) {
    final icon = ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'assets/icon/icon.png',
        height: size,
        width: size,
        fit: BoxFit.cover,
      ),
    );

    if (!showGlow) {
      return icon;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withAlpha(55),
            blurRadius: size * 0.35,
            offset: Offset(0, size * 0.12),
          ),
          BoxShadow(
            color: AppTheme.secondary.withAlpha(34),
            blurRadius: size * 0.45,
            offset: Offset(size * 0.08, size * 0.08),
          ),
        ],
      ),
      child: icon,
    );
  }
}
