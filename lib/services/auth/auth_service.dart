import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';

class AuthService implements AuthProvider {
  final AuthProvider _provider;

  const AuthService(this._provider);

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) =>
      _provider.createUser(
        email: email,
        password: password,
      );

  @override
  AuthUser? get currentUser => _provider.currentUser;

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) =>
      _provider.logIn(
        email: email,
        password: password,
      );

  @override
  Future<void> logOut() => _provider.logOut();

  @override
  Future<void> sendEmailVerification() => _provider.sendEmailVerification();
}
