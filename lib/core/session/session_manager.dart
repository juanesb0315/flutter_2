import '../../features/auth/domain/entities/user.dart';

/// Sesión global en memoria para compartir el usuario entre pantallas.
abstract final class SessionManager {
  static User? _currentUser;

  static User? get currentUser => _currentUser;

  static void start(User user) {
    _currentUser = user;
  }

  static void clear() {
    _currentUser = null;
  }
}
