import '../models/buyer.dart';
import 'api_service.dart';

class BuyerService {
  final ApiService api;

  BuyerService(this.api);

  Future<List<Buyer>> fetchAll() async {
    final resp = await api.get('/buyers');
    final data = resp.data as List<dynamic>;
    return data
        .map((e) => Buyer.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<Buyer> getById(int userId) async {
    final resp = await api.get('/buyers/$userId');
    return Buyer.fromJson(Map<String, dynamic>.from(resp.data));
  }

  Future<Buyer> create(Buyer b) async {
    final resp = await api.post('/buyers', data: b.toJson());
    return Buyer.fromJson(Map<String, dynamic>.from(resp.data));
  }

  Future<Buyer> update(int userId, Map<String, dynamic> changes) async {
    final resp = await api.put('/buyers/$userId', data: changes);
    return Buyer.fromJson(Map<String, dynamic>.from(resp.data));
  }

  Future<void> delete(int userId) async {
    await api.delete('/buyers/$userId');
  }
}
