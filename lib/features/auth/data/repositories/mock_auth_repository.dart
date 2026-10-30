import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Implementación simulada de autenticación.
///
/// Mantiene el usuario registrado en memoria y simula los tiempos de red
/// solicitados por el taller (2 segundos al iniciar sesión).
class MockAuthRepository implements AuthRepository {
  User? _registeredUser;

  @override
  Future<User> signIn({required String email, required String password}) async {
    await Future<void>.delayed(const Duration(seconds: 2));

    final registeredUser = _registeredUser;
    if (registeredUser != null &&
        registeredUser.email.toLowerCase() == email.trim().toLowerCase()) {
      return registeredUser;
    }

    return User(fullName: 'Usuario', email: email.trim());
  }

  @override
  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 1200));
    _registeredUser = User(fullName: fullName.trim(), email: email.trim());
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
  }

  /// Limpia el usuario simulado (útil para pruebas).
  void reset() {
    _registeredUser = null;
  }
}
