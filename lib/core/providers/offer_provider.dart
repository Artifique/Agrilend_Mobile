import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:agrilend/services/offer_service.dart';
import 'package:agrilend/services/auth_providers.dart';

final offerServiceProvider = Provider<OfferService>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return OfferService(apiService);
});