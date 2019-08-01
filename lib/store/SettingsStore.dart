import 'package:shared_preferences/shared_preferences.dart';

class SettingsStore {

  SharedPreferences prefs;

  init() async {
    if (this.prefs == null) {
      this.prefs = await SharedPreferences.getInstance();
    }
  }

  setKey(String key, String value) async {
    await this.init();
    return this.prefs.setString(key, value);
  }

  Future<String> getKey(String key) async {
    await this.init();
    return this.prefs.getString(key);
  }
}
