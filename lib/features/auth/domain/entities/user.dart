import 'package:flutter/foundation.dart';

/// Entidad de dominio que representa al usuario autenticado.
@immutable
class User {
  const User({required this.fullName, required this.email});

  final String fullName;
  final String email;

  String get firstName {
    final trimmed = fullName.trim();
    if (trimmed.isEmpty) return 'Usuario';
    return trimmed.split(RegExp(r'\s+')).first;
  }
}
