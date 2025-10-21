import 'dart:convert';



import 'package:agrilend/services/secure_storage_shim.dart';

import 'api_service.dart';
import '../models/user.dart'; // Corrected import path for User model

class AuthService {
  final ApiService api;
  final FlutterSecureStorage _secure;

  static const _accessKey = 'auth_access_token';
  static const _refreshKey = 'auth_refresh_token';
  static const _typeKey = 'auth_token_type';
  static const _userKey = 'auth_user_json';

  AuthService(this.api) : _secure = const FlutterSecureStorage();

  /// Calls backend login and stores tokens + user info securely
  Future<Map<String, dynamic>> login(String email, String password) async {
    final resp = await api.post('/api/auth/login', data: {
      'email': email,
      'password': password,
    });

    final body = resp.data;
    if (body is Map && body['success'] == true && body['data'] is Map) {
      final data = body['data'] as Map;
      final access =
          data['accessToken'] as String? ?? data['access_token'] as String?;
      final refresh =
          data['refreshToken'] as String? ?? data['refresh_token'] as String?;
      final type =
          data['tokenType'] as String? ?? data['token_type'] as String?;

      // store
      if (access != null) await _secure.write(key: _accessKey, value: access);
      if (refresh != null)
        await _secure.write(key: _refreshKey, value: refresh);
      if (type != null) await _secure.write(key: _typeKey, value: type);

      // user info: map relevant fields
      final userMap = {
        'userId': data['userId'] ?? data['id'],
        'email': data['email'],
        'firstName': data['firstName'],
        'lastName': data['lastName'],
        'role': data['role'] ?? data['userType'],
      }..removeWhere((k, v) => v == null);

      await _secure.write(key: _userKey, value: jsonEncode(userMap));

      // set token on ApiService
      if (access != null) api.setAuthToken(access);

      return {'success': true, 'data': userMap};
    }

    return {'success': false, 'message': body['message'] ?? 'Login failed'};
  }

  Future<Map<String, dynamic>?> loadUserData() async {
    final json = await _secure.read(key: _userKey);
    if (json == null) return null;
    return Map<String, dynamic>.from(jsonDecode(json));
  }

  Future<User?> getCurrentUser() async {
    final data = await loadUserData();
    if (data == null) return null;
    try {
      return User(
        id: data['userId'] is int
            ? data['userId']
            : int.tryParse('${data['userId']}'),
        email: data['email'] ?? '',
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        phone: data['phone'] ?? '',
        role: (data['role'] ?? data['userType'] ?? 'BUYER').toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    } catch (_) {
      return null;
    }
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> payload) async {
    final resp = await api.post('/api/auth/register', data: payload);
    final body = resp.data;

    if (body is Map && body['success'] == true && body['data'] is Map) {
      final data = body['data'] as Map;
      final access =
          data['accessToken'] as String? ?? data['access_token'] as String?;
      final refresh =
          data['refreshToken'] as String? ?? data['refresh_token'] as String?;
      final type =
          data['tokenType'] as String? ?? data['token_type'] as String?;

      if (access != null) await _secure.write(key: _accessKey, value: access);
      if (refresh != null)
        await _secure.write(key: _refreshKey, value: refresh);
      if (type != null) await _secure.write(key: _typeKey, value: type);

      final userMap = {
        'userId': data['userId'] ?? data['id'],
        'email': data['email'],
        'firstName': data['firstName'],
        'lastName': data['lastName'],
        'role': data['role'] ?? data['userType'],
      }..removeWhere((k, v) => v == null);

      await _secure.write(key: _userKey, value: jsonEncode(userMap));
      if (access != null) api.setAuthToken(access);

      return {'success': true, 'data': userMap};
    }

    return {'success': false, 'message': body['message'] ?? 'Register failed'};
  }

  Future<void> logout() async {
    await _secure.delete(key: _accessKey);
    await _secure.delete(key: _refreshKey);
    await _secure.delete(key: _typeKey);
    await _secure.delete(key: _userKey);
    api.setAuthToken(null);
  }
}
