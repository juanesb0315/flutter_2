import 'package:flutter/material.dart';

import '../../../../../core/session/session_manager.dart';
import '../../../../../theme/app_colors.dart';
import 'recent_item_card.dart';

/// Pestaña de inicio del dashboard.
class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  static const List<_RecentActivity> _activities = <_RecentActivity>[
    _RecentActivity(
      title: 'Nueva notificación',
      subtitle: 'Tienes una actualización pendiente por revisar.',
      time: 'Hace 5 min',
      icon: Icons.notifications_rounded,
      color: AppColors.primary,
    ),
    _RecentActivity(
      title: 'Tarea pendiente',
      subtitle: 'Completa el taller de Flutter antes del viernes.',
      time: 'Hace 25 min',
      icon: Icons.task_alt_rounded,
      color: AppColors.secondary,
    ),
    _RecentActivity(
      title: 'Mensaje nuevo',
      subtitle: 'Juan te envió un mensaje sobre el proyecto.',
      time: 'Hace 1 h',
      icon: Icons.chat_bubble_rounded,
      color: AppColors.info,
    ),
    _RecentActivity(
      title: 'Recordatorio',
      subtitle: 'Reunión de equipo hoy a las 4:00 p. m.',
      time: 'Hace 2 h',
      icon: Icons.event_rounded,
      color: AppColors.warning,
    ),
    _RecentActivity(
      title: 'Actualización completada',
      subtitle: 'La aplicación se actualizó correctamente.',
      time: 'Ayer',
      icon: Icons.system_update_rounded,
      color: AppColors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = SessionManager.currentUser;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 760),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Hola, Usuario',
                        style: theme.textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user == null
                            ? 'Bienvenido de nuevo a UserMaster.'
                            : 'Bienvenido de nuevo, ${user.firstName}.',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                const CircleAvatar(
                  radius: 24,
                  backgroundColor: AppColors.primaryLight,
                  child: Icon(
                    Icons.person_rounded,
                    color: AppColors.primary,
                    size: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[AppColors.primary, AppColors.primaryDark],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Resumen de hoy',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.75),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '5 novedades te esperan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Mantente al día con tu actividad reciente.',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.insights_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Row(
              children: <Widget>[
                Text('Actividad reciente', style: theme.textTheme.titleLarge),
                const Spacer(),
                Text('5 elementos', style: theme.textTheme.bodySmall),
              ],
            ),
            const SizedBox(height: 12),
            for (final activity in _activities)
              RecentItemCard(
                title: activity.title,
                subtitle: activity.subtitle,
                time: activity.time,
                icon: activity.icon,
                color: activity.color,
              ),
          ],
        ),
      ),
    );
  }
}

class _RecentActivity {
  const _RecentActivity({
    required this.title,
    required this.subtitle,
    required this.time,
    required this.icon,
    required this.color,
  });

  final String title;
  final String subtitle;
  final String time;
  final IconData icon;
  final Color color;
}
