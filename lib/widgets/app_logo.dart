import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Logo reutilizable de UserMaster.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 80,
    this.backgroundColor = AppColors.surface,
    this.iconColor = AppColors.primary,
    this.showShadow = true,
  });

  final double size;
  final Color backgroundColor;
  final Color iconColor;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(size * 0.28),
        boxShadow: showShadow
            ? <BoxShadow>[
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.22),
                  blurRadius: size * 0.4,
                  offset: Offset(0, size * 0.12),
                ),
              ]
            : null,
      ),
      child: Icon(Icons.school_rounded, size: size * 0.52, color: iconColor),
    );
  }
}
