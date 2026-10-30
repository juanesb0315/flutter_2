import 'package:flutter/material.dart';

import '../../../../core/di/app_dependencies.dart';
import '../../../../core/validators/app_validators.dart';
import '../../../../routes/app_routes.dart';
import '../../../../widgets/app_button.dart';
import '../../../../widgets/app_text_field.dart';
import '../../../../widgets/auth_scaffold.dart';

/// Pantalla de registro de nuevos usuarios.
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await AppDependencies.authRepository.signUp(
        fullName: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;
      final navigator = Navigator.of(context);
      final messenger = ScaffoldMessenger.of(context);

      if (navigator.canPop()) {
        navigator.pop();
      } else {
        navigator.pushReplacementNamed(AppRoutes.login);
      }

      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Cuenta creada correctamente. Ahora puedes iniciar sesión.',
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No pudimos crear la cuenta. Inténtalo de nuevo.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      showBackButton: true,
      title: 'Crea tu cuenta',
      subtitle: 'Completa tus datos para empezar a usar UserMaster.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppTextField(
              key: const Key('register_name'),
              controller: _nameController,
              label: 'Nombre completo',
              hint: 'Juan Esteban Betancourt',
              prefixIcon: Icons.person_outline_rounded,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              autofillHints: const <String>[AutofillHints.name],
              validator: AppValidators.fullName,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            AppTextField(
              key: const Key('register_email'),
              controller: _emailController,
              label: 'Correo electrónico',
              hint: 'tu@correo.com',
              prefixIcon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const <String>[AutofillHints.email],
              validator: AppValidators.email,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            AppTextField(
              key: const Key('register_password'),
              controller: _passwordController,
              label: 'Contraseña',
              hint: 'Mínimo 6 caracteres',
              prefixIcon: Icons.lock_outline_rounded,
              obscureText: true,
              textInputAction: TextInputAction.next,
              autofillHints: const <String>[AutofillHints.newPassword],
              validator: AppValidators.password,
              enabled: !_isLoading,
            ),
            const SizedBox(height: 16),
            AppTextField(
              key: const Key('register_confirm_password'),
              controller: _confirmPasswordController,
              label: 'Confirmar contraseña',
              hint: 'Repite tu contraseña',
              prefixIcon: Icons.lock_reset_rounded,
              obscureText: true,
              textInputAction: TextInputAction.done,
              validator: (value) => AppValidators.confirmPassword(
                value,
                _passwordController.text,
              ),
              enabled: !_isLoading,
              onFieldSubmitted: (_) {
                if (!_isLoading) _submit();
              },
            ),
            const SizedBox(height: 24),
            AppButton(
              key: const Key('register_submit'),
              label: 'Crear cuenta',
              icon: Icons.person_add_alt_1_rounded,
              isLoading: _isLoading,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
