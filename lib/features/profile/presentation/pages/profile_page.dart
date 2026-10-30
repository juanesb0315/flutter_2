import 'package:flutter/material.dart';

import '../../../../core/session/session_manager.dart';
import '../../../../routes/app_routes.dart';
import '../../../../theme/app_colors.dart';
import '../../../../widgets/app_button.dart';
import '../../../auth/domain/entities/user.dart';

/// Pestaña de perfil del usuario autenticado.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user =
        SessionManager.currentUser ??
        const User(fullName: 'Usuario', email: 'usuario@usermaster.com');
    final theme = Theme.of(context);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          children: <Widget>[
            const Center(
              child: CircleAvatar(
                radius: 52,
                backgroundColor: AppColors.primaryLight,
                child: Icon(
                  Icons.person_rounded,
                  color: AppColors.primary,
                  size: 60,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              user.fullName,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 6),
            Text(
              user.email,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: <Widget>[
                  _ProfileInfoRow(
                    icon: Icons.badge_outlined,
                    label: 'Nombre completo',
                    value: user.fullName,
                  ),
                  const Divider(height: 28),
                  _ProfileInfoRow(
                    icon: Icons.mail_outline_rounded,
                    label: 'Correo electrónico',
                    value: user.email,
                  ),
                  const Divider(height: 28),
                  const _ProfileInfoRow(
                    icon: Icons.verified_user_outlined,
                    label: 'Estado de la cuenta',
                    value: 'Activa',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              key: const Key('profile_logout'),
              label: 'Cerrar sesión',
              icon: Icons.logout_rounded,
              variant: AppButtonVariant.danger,
              onPressed: () {
                SessionManager.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(AppRoutes.login, (route) => false);
              },
            ),
            const SizedBox(height: 16),
            Text(
              'UserMaster · Versión 1.0.0',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  const _ProfileInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: <Widget>[
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: theme.textTheme.bodySmall),
              const SizedBox(height: 2),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
