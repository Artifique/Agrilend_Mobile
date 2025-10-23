// ...existing code...
import 'package:agrilend/models/user.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/providers/auth_provider.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/auth/screens/user_type_selection_screen.dart';
import '../../features/auth/screens/basic_info_screen.dart';
import '../../features/auth/screens/personal_info_screen.dart';
import '../../features/auth/screens/kyc_verification_screen.dart';
import '../../features/auth/screens/registration_complete_screen.dart';
import '../../features/farmer/screens/farmer_main_screen.dart';
import '../../features/farmer/screens/create_offer_screen.dart';
import '../../features/farmer/screens/stock_management_screen.dart';

import '../../features/agent/screens/agent_main_screen.dart';
import '../../features/buyer/screens/buyer_main_screen.dart';
import '../../features/buyer/screens/product_detail_screen.dart';
import '../../features/buyer/screens/order_confirmation_screen.dart';
import '../../features/buyer/screens/order_list_screen.dart'; // New import
import '../../features/transactions/screens/payment_request_screen.dart';
import '../../features/transactions/screens/transaction_history_screen.dart';
import '../../features/wallet/screens/wallet_screen.dart';
import '../../features/wallet/screens/scanner_qr_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/notification/screens/notification_screen.dart';

import 'dart:async'; // Import for StreamSubscription
import 'package:flutter/foundation.dart'; // Import for ChangeNotifier

final appRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);
  final goRouterRefreshStream = ref.watch(goRouterNotifier.stream);

  return GoRouter(
    initialLocation: '/onboarding',
    refreshListenable: GoRouterRefreshStream(goRouterRefreshStream),
    redirect: (context, state) {
      final isAuthenticated = authState.isAuthenticated;
      final userType = authState.user?.userType;

      // ignore: avoid_print
      print('Router Redirect: isAuthenticated=$isAuthenticated, userType=$userType, currentUri=${state.uri}, isLoading=${authState.isLoading}');

      // If auth state is still loading, don't redirect yet.
      if (authState.isLoading) {
        return null; // Or redirect to a loading screen if you have one
      }

      // Si non authentifié et pas sur les pages publiques
      if (!isAuthenticated) {
        final publicRoutes = [
          '/onboarding',
          '/login',
          '/register',
          '/user-type',
          '/basic-info',
          '/personal-info',
          '/kyc-verification',
          '/registration-complete'
        ];
        if (!publicRoutes
            .any((route) => state.uri.toString().startsWith(route))) {
          return '/login';
        }
        return null;
      }

      // Si authentifié mais sur les pages publiques
      if (isAuthenticated) {
        final publicRoutes = [
          '/onboarding',
          '/login',
          '/register',
          '/user-type',
          '/basic-info',
          '/personal-info',
          '/kyc-verification',
          '/registration-complete'
        ];
        if (publicRoutes
            .any((route) => state.uri.toString().startsWith(route))) {
          return _getHomeRoute(userType);
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        redirect: (_, __) => '/onboarding',
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationScreen(),
      ),
      // Onboarding & Auth
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/user-type',
        builder: (context, state) => const UserTypeSelectionScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/basic-info',
        builder: (context, state) {
          final userType = state.uri.queryParameters['userType'] ?? 'farmer';
          return BasicInfoScreen(userType: userType);
        },
      ),
      GoRoute(
        path: '/personal-info',
        builder: (context, state) {
          final userType = state.uri.queryParameters['userType'] ?? 'farmer';
          return PersonalInfoScreen(userType: userType);
        },
      ),
      GoRoute(
        path: '/kyc-verification',
        builder: (context, state) {
          final userType = state.uri.queryParameters['userType'] ?? 'farmer';
          return KycVerificationScreen(userType: userType);
        },
      ),
      GoRoute(
        path: '/registration-complete',
        builder: (context, state) {
          final userType = state.uri.queryParameters['userType'] ?? 'farmer';
          return RegistrationCompleteScreen(userType: userType);
        },
      ),

      // Farmer Routes
      GoRoute(
        path: '/farmer',
        builder: (context, state) => const FarmerMainScreen(),
        routes: [
          GoRoute(
            path: 'payment-request',
            builder: (context, state) => const PaymentRequestScreen(),
          ),
          GoRoute(
            path: 'wallet',
            builder: (context, state) => const WalletScreen(),
            routes: [
              GoRoute(
                path: 'scanner-qr',
                builder: (context, state) => const ScannerQrScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: 'notifications',
            builder: (context, state) => const NotificationScreen(),
          ),
          GoRoute(
            path: 'create-offer',
            builder: (context, state) => const CreateOfferScreen(),
          ),
          GoRoute(
            path: 'stock-management',
            builder: (context, state) => const StockManagementScreen(),
          ),
          GoRoute(
            path: 'transaction-history',
            builder: (context, state) => const TransactionHistoryScreen(),
          ),
        ], // <-- ferme le tableau des routes imbriquées
      ), // <-- ferme le GoRoute /farmer

      // Agent Routes
      GoRoute(
        path: '/agent',
        builder: (context, state) => const AgentMainScreen(),
        routes: [
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          // GoRoute(
          //   path: 'support',
          //   builder: (context, state) => const SupportScreen(),
          // ),
          GoRoute(
            path: 'notifications',
            builder: (context, state) => const NotificationScreen(),
          ),
        ],
      ),

      // Buyer Routes
      GoRoute(
        path: '/buyer',
        builder: (context, state) => const BuyerMainScreen(),
        routes: [
          GoRoute(
            path: 'product/:productId',
            builder: (context, state) {
              final productId = state.pathParameters['productId']!;
              return ProductDetailScreen(productId: productId);
            },
          ),
          GoRoute(
            path: 'order-confirmation',
            builder: (context, state) => const OrderConfirmationScreen(),
          ),
          GoRoute(
            path: 'orders',
            builder: (context, state) => const OrderListScreen(),
          ),
          GoRoute(
            path: 'profile',
            builder: (context, state) => const ProfileScreen(),
          ),
          GoRoute(
            path: 'notifications',
            builder: (context, state) => const NotificationScreen(),
          ),
        ],
      ),
    ],
  );
});

String _getHomeRoute(String? userType) {
  switch (userType) {
    case 'farmer':
      return '/farmer';
    case 'agent':
      return '/agent';
    case 'buyer':
      return '/buyer';
    default:
      return '/login';
  }
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
        );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
