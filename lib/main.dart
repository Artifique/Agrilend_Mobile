import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'services/product_service.dart';
import 'services/offer_service.dart';
import 'services/user_service.dart';
import 'services/farmer_service.dart';
import 'services/buyer_service.dart';
import 'services/order_service.dart';
import 'services/transaction_service.dart';
import 'services/notification_service.dart';
import 'services/delivery_service.dart';
import 'services/auth_providers.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

final productServiceProvider = Provider<ProductService>(
    (ref) => ProductService(ref.read(apiServiceProvider)));
final offerServiceProvider =
    Provider<OfferService>((ref) => OfferService(ref.read(apiServiceProvider)));
final userServiceProvider =
    Provider<UserService>((ref) => UserService(ref.read(apiServiceProvider)));
final farmerServiceProvider = Provider<FarmerService>(
    (ref) => FarmerService(ref.read(apiServiceProvider)));
final buyerServiceProvider =
    Provider<BuyerService>((ref) => BuyerService(ref.read(apiServiceProvider)));
final orderServiceProvider =
    Provider<OrderService>((ref) => OrderService(ref.read(apiServiceProvider)));
final transactionServiceProvider = Provider<TransactionService>(
    (ref) => TransactionService(ref.read(apiServiceProvider)));
final notificationServiceProvider = Provider<NotificationService>(
    (ref) => NotificationService(ref.read(apiServiceProvider)));
final deliveryServiceProvider = Provider<DeliveryService>(
    (ref) => DeliveryService(ref.read(apiServiceProvider)));
// auth providers are defined in services/auth_providers.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for local storage
  await Hive.initFlutter();

  // Configure system UI
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  Animate.restartOnHotReload = true;

  // Initialize auth state by loading token from storage
  final container = ProviderContainer();
  final authNotifier = container.read(authNotifierProvider.notifier);
  await authNotifier.init();

  runApp(UncontrolledProviderScope(
      container: container, child: const AgriLendApp()));
}

class AgriLendApp extends ConsumerWidget {
  const AgriLendApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'AgriLend',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: 1.0,
          ),
          child: child!,
        );
      },
    );
  }
}
