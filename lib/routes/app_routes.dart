import 'package:flutter/material.dart';

import '../features/auth/presentation/pages/forgot_password_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/dashboard/presentation/pages/dashboard_page.dart';
import '../features/splash/presentation/pages/splash_page.dart';

/// Nombres y configuración centralizada de las rutas de navegación.
abstract final class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String dashboard = '/dashboard';

  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    splash: (_) => const SplashPage(),
    login: (_) => const LoginPage(),
    register: (_) => const RegisterPage(),
    forgotPassword: (_) => const ForgotPasswordPage(),
    dashboard: (_) => const DashboardPage(),
  };

  /// Construye únicamente la ruta solicitada, sin apilar rutas intermedias.
  ///
  /// En web permite abrir directamente `/#/login`, `/#/register`, etc., y
  /// recargar la página sin perder la pantalla actual.
  static List<Route<dynamic>> initialRoutes(String routeName) {
    final resolvedName = routes.containsKey(routeName) ? routeName : splash;

    return <Route<dynamic>>[
      MaterialPageRoute<void>(
        settings: RouteSettings(name: resolvedName),
        builder: routes[resolvedName]!,
      ),
    ];
  }
}
