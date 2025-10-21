import '../models/offer.dart';
import 'api_service.dart';

class OfferService {
  final ApiService api;

  OfferService(this.api);

  Future<List<Offer>> fetchActive() async {
    final resp =
        await api.get('/offers', queryParameters: {'status': 'ACTIVE'});
    final data = resp.data as List<dynamic>;
    return data
        .map((e) => Offer.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<Offer> create(Offer offer) async {
    final resp = await api.post('/offers', data: offer.toJson());
    return Offer.fromJson(Map<String, dynamic>.from(resp.data));
  }
}
