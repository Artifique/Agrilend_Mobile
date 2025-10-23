import 'package:agrilend/models/offer.dart';
import 'package:agrilend/services/api_service.dart';

class OfferService {
  final ApiService _apiService;

  OfferService(this._apiService);

  Future<List<Offer>> getOffers() async {
    try {
      final response = await _apiService.get('/api/buyer/offers');
      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> offersData = response.data['data']['content'];
        return offersData.map((json) => Offer.fromJson(json)).toList();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching offers: $e');
    }
    return [];
  }
}