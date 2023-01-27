import 'package:ok_task/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  late SharedPreferences sharedPreferences;

  PrefsManager() {
    sharedPreferences = locator<SharedPreferences>();
  }

  getAccessToken() async {
    final String? accessToken = sharedPreferences.getString('access_token');

    return accessToken;
  }

  setAccessToken(String token) async {
    sharedPreferences.setString('access_token', token);
  }

  Future<bool> isLoggedIn() async {
    return sharedPreferences.getBool('loggedIn') ?? false;
  }

  setLoggedIn() async {
    sharedPreferences.setBool('loggedIn', true);
  }
}
