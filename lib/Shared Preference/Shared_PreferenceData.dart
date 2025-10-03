/*
import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static const String _userLoginKey = 'is_user_login';
  static const String _adminLoginKey = 'is_admin_login';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';

  // ---------------------- USER ----------------------

  /// Save User Login State
  static Future<void> setUserLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_userLoginKey, value);
  }

  /// Check if User is Logged In
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_userLoginKey) ?? false;
  }

  /// Save Logged-in User ID
  static Future<void> setUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIdKey, userId);
  }

  /// Get Logged-in User ID
  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  /// Save Logged-in User Email (optional)
  static Future<void> setUserEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userEmailKey, email);
  }

  /// Get User Email
  static Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userEmailKey);
  }

  // ---------------------- ADMIN ----------------------

  /// Save Admin Login State
  static Future<void> setAdminLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_adminLoginKey, value);
  }

  /// Check if Admin is Logged In
  static Future<bool> isAdminLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_adminLoginKey) ?? false;
  }

  // ---------------------- COMMON ----------------------

  /// Clear all stored preferences (useful for logout)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
*/
