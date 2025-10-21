import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_service.dart';
import 'auth_notifier.dart';
import 'api_service.dart';

// Export notifier so feature code can reference AuthState/AuthNotifier types
export 'auth_notifier.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService.create());
final authServiceProvider =
    Provider<AuthService>((ref) => AuthService(ref.read(apiServiceProvider)));
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final service = ref.read(authServiceProvider);
  return AuthNotifier(service);
});

// Backwards-compatible alias
final authProvider = authNotifierProvider;
