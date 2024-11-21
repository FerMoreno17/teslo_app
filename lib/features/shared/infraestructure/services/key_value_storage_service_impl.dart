import 'key_value_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPref() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final pref = await getSharedPref();
    switch (T) {
      case int:
        return pref.getInt(key) as T?;
      case String:
        return pref.getString(key) as T?;
      default:
        throw UnimplementedError(
            'Set not implemented for type ${T.runtimeType}');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final pref = await getSharedPref();
    return pref.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final pref = await getSharedPref();
    switch (T) {
      case int:
        pref.setInt(key, value as int);
        break;
      case String:
        pref.setString(key, value as String);
        break;
      default:
        throw UnimplementedError(
            'Set not implemented for type ${T.runtimeType}');
    }
  }
}
