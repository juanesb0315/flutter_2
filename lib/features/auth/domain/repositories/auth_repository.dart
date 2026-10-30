import '../entities/user.dart';

/// Contrato de autenticación de la capa de dominio.
abstract interface class AuthRepository {
  Future<User> signIn({required String email, required String password});

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> sendPasswordResetEmail({required String email});
}
