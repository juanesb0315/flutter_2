import '../../features/auth/data/repositories/mock_auth_repository.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';

/// Contenedor sencillo de dependencias de la aplicación.
abstract final class AppDependencies {
  static final AuthRepository authRepository = MockAuthRepository();
}
