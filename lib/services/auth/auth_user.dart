import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

@immutable
class AuthUser {
  final String id;
  final String? email;
  final bool isEmailVerified;
  final bool isAnonymous;

  const AuthUser({
    required this.id,
    required this.email,
    required this.isEmailVerified,
    required this.isAnonymous,
  });

  factory AuthUser.fromFirebase(User user) => AuthUser(
    id: user.uid,
    email: user.email,
    isEmailVerified: user.emailVerified,
    isAnonymous: user.isAnonymous,
  );
}
