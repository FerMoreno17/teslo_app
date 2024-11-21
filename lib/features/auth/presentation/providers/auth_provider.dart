import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

import '../../../shared/infraestructure/services/key_value_storage_service_impl.dart';
import '../../domain/domain.dart';

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageServiceImpl keyValueService;

  AuthNotifier({required this.authRepository, required this.keyValueService})
      : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado $e');
    }
  }

  void registerUser(
      String name, String email, String password, String passwordClone) async {}

  void checkAuthStatus() async {
    final token = await keyValueService.getValue<String>('token');
    if (token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueService.removeKey('token');

    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
  }

  void _setLoggedUser(User user) async {
    await keyValueService.setKeyValue('token', user.token);
    state = state.copyWith(
        user: user, authStatus: AuthStatus.authenticated, errorMessage: '');
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImp();
  final keyValueService = KeyValueStorageServiceImpl();
  return AuthNotifier(
      authRepository: authRepository, keyValueService: keyValueService);
});
