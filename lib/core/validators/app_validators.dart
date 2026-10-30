/// Validaciones reutilizables para los formularios de la aplicación.
abstract final class AppValidators {
  static final RegExp _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static String? required(
    String? value, {
    String message = 'Este campo es obligatorio',
  }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }
    return null;
  }

  static String? fullName(String? value) {
    final requiredError = required(
      value,
      message: 'Ingresa tu nombre completo',
    );
    if (requiredError != null) return requiredError;
    if (value!.trim().length < 3) {
      return 'El nombre debe tener al menos 3 caracteres';
    }
    return null;
  }

  static String? email(String? value) {
    final requiredError = required(
      value,
      message: 'Ingresa tu correo electrónico',
    );
    if (requiredError != null) return requiredError;
    if (!_emailPattern.hasMatch(value!.trim())) {
      return 'Ingresa un correo electrónico válido';
    }
    return null;
  }

  static String? password(String? value) {
    final requiredError = required(value, message: 'Ingresa tu contraseña');
    if (requiredError != null) return requiredError;
    if (value!.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres';
    }
    return null;
  }

  static String? confirmPassword(String? value, String password) {
    final requiredError = required(value, message: 'Confirma tu contraseña');
    if (requiredError != null) return requiredError;
    if (value != password) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }
}
