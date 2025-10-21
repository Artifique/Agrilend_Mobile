import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_service.dart';
import '../models/user.dart';

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  AuthState({this.user, this.isLoading = false, this.error});

  /// Backwards-compatible getter used by feature code
  bool get isAuthenticated => user != null;

  AuthState copyWith({User? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthService authService;

  AuthNotifier(this.authService) : super(AuthState()) {
    init();
  }

  Future<void> init() async {
    state = state.copyWith(isLoading: true);
    final user = await authService.getCurrentUser();
    state = state.copyWith(user: user, isLoading: false);
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final res = await authService.login(email, password);
      if (res['success'] == true) {
        final user = await authService.getCurrentUser();
        state = state.copyWith(user: user, isLoading: false);
        return true;
      }
      state =
          state.copyWith(isLoading: false, error: res['message']?.toString());
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Accepts either a raw payload map or named parameters (backwards compatible)
  Future<bool> register([Map<String, dynamic>? payload]) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final res = await authService.register(payload ?? {});
      if (res['success'] == true) {
        final user = await authService.getCurrentUser();
        state = state.copyWith(user: user, isLoading: false);
        return true;
      }
      state =
          state.copyWith(isLoading: false, error: res['message']?.toString());
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    await authService.logout();
    state = AuthState();
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}
