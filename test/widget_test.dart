import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_master/app.dart';
import 'package:user_master/core/session/session_manager.dart';
import 'package:user_master/features/auth/domain/entities/user.dart';
import 'package:user_master/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:user_master/features/auth/presentation/pages/login_page.dart';
import 'package:user_master/features/auth/presentation/pages/register_page.dart';
import 'package:user_master/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:user_master/features/profile/presentation/pages/profile_page.dart';
import 'package:user_master/features/splash/presentation/pages/splash_page.dart';
import 'package:user_master/routes/app_routes.dart';
import 'package:user_master/theme/app_theme.dart';

Widget _buildTestApp({String initialRoute = AppRoutes.login}) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    initialRoute: initialRoute,
    onGenerateInitialRoutes: AppRoutes.initialRoutes,
    routes: AppRoutes.routes,
  );
}

Future<void> _enterText(WidgetTester tester, String key, String text) async {
  final finder = find.byKey(Key(key));
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.enterText(finder, text);
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
}

void main() {
  setUp(SessionManager.clear);

  testWidgets('el splash espera 3 segundos y navega al login', (tester) async {
    await tester.pumpWidget(const UserMasterApp());

    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.text('UserMaster'), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(LoginPage), findsNothing);

    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
  });

  testWidgets('el login valida los campos obligatorios', (tester) async {
    await tester.pumpWidget(_buildTestApp());

    await _tapVisible(tester, find.byKey(const Key('login_submit')));
    await tester.pump();

    expect(find.text('Ingresa tu correo electrónico'), findsOneWidget);
    expect(find.text('Ingresa tu contraseña'), findsOneWidget);
  });

  testWidgets('el login simula la carga de 2 segundos y abre el dashboard', (
    tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());

    await _enterText(tester, 'login_email', 'juan@example.com');
    await _enterText(tester, 'login_password', '123456');
    await _tapVisible(tester, find.byKey(const Key('login_submit')));

    await tester.pump();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 2));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(DashboardPage), findsOneWidget);
    expect(find.text('Hola, Usuario'), findsOneWidget);
  });

  testWidgets('el registro valida las contraseñas y vuelve al login', (
    tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());

    await _tapVisible(tester, find.text('Regístrate'));
    await tester.pumpAndSettle();
    expect(find.byType(RegisterPage), findsOneWidget);

    await _enterText(tester, 'register_name', 'Ana Torres');
    await _enterText(tester, 'register_email', 'ana@example.com');
    await _enterText(tester, 'register_password', '123456');
    await _enterText(tester, 'register_confirm_password', '654321');

    await _tapVisible(tester, find.byKey(const Key('register_submit')));
    await tester.pump();

    expect(find.text('Las contraseñas no coinciden'), findsOneWidget);

    await _enterText(tester, 'register_confirm_password', '123456');
    await _tapVisible(tester, find.byKey(const Key('register_submit')));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 1200));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.textContaining('Cuenta creada correctamente'), findsOneWidget);
  });

  testWidgets('recuperar contraseña muestra la confirmación con SnackBar', (
    tester,
  ) async {
    await tester.pumpWidget(_buildTestApp());

    await _tapVisible(tester, find.text('¿Olvidaste tu contraseña?'));
    await tester.pumpAndSettle();
    expect(find.byType(ForgotPasswordPage), findsOneWidget);

    await _enterText(tester, 'forgot_email', 'juan@example.com');
    await _tapVisible(tester, find.byKey(const Key('forgot_submit')));
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(milliseconds: 800));
    await tester.pump();
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Enviamos un enlace de recuperación'),
      findsOneWidget,
    );
  });

  testWidgets('el dashboard muestra 5 tarjetas y permite cerrar sesión', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    SessionManager.start(
      const User(
        fullName: 'Juan Esteban Betancourt García',
        email: 'jjbetancourt0315@gmail.com',
      ),
    );

    await tester.pumpWidget(_buildTestApp(initialRoute: AppRoutes.dashboard));

    expect(find.text('Hola, Usuario'), findsOneWidget);
    expect(find.byType(Card), findsNWidgets(5));
    expect(find.byType(BottomNavigationBar), findsOneWidget);

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();

    expect(find.byType(ProfilePage), findsOneWidget);
    expect(
      find.text('Juan Esteban Betancourt García'),
      findsAtLeastNWidgets(1),
    );
    expect(find.text('jjbetancourt0315@gmail.com'), findsAtLeastNWidgets(1));

    await _tapVisible(tester, find.byKey(const Key('profile_logout')));
    await tester.pumpAndSettle();

    expect(SessionManager.currentUser, isNull);
    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.byType(DashboardPage), findsNothing);
  });
}
