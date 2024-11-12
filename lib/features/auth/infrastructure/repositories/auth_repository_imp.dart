import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/datasources/auth_datasource_imp.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthDataSource datasource;

  AuthRepositoryImp({AuthDataSource? datasource})
      : datasource = datasource ?? AuthDataSourceImp();

  @override
  Future<User> checkAuthStatus(String token) {
    return datasource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return datasource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String name) {
    return datasource.register(email, password, name);
  }
}
