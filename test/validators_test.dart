import 'package:flutter_test/flutter_test.dart';
import 'package:user_master/core/validators/app_validators.dart';

void main() {
  group('AppValidators', () {
    test('valida correos electrónicos', () {
      expect(AppValidators.email('juan@example.com'), isNull);
      expect(AppValidators.email(''), isNotNull);
      expect(AppValidators.email('correo-invalido'), isNotNull);
      expect(AppValidators.email('juan@'), isNotNull);
    });

    test('valida el nombre completo', () {
      expect(AppValidators.fullName('Juan Esteban'), isNull);
      expect(AppValidators.fullName(''), isNotNull);
      expect(AppValidators.fullName('J'), isNotNull);
    });

    test('valida la contraseña', () {
      expect(AppValidators.password('123456'), isNull);
      expect(AppValidators.password('123'), isNotNull);
      expect(AppValidators.password(''), isNotNull);
    });

    test('valida la confirmación de la contraseña', () {
      expect(AppValidators.confirmPassword('123456', '123456'), isNull);
      expect(
        AppValidators.confirmPassword('654321', '123456'),
        'Las contraseñas no coinciden',
      );
    });
  });
}
