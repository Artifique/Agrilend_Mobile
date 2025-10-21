import '../models/order.dart';
import 'api_service.dart';

class OrderService {
  final ApiService api;

  OrderService(this.api);

  Future<List<Order>> fetchAll({Map<String, dynamic>? query}) async {
    final resp = await api.get('/orders', queryParameters: query);
    final data = resp.data as List<dynamic>;
    return data
        .map((e) => Order.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<Order> getById(int id) async {
    final resp = await api.get('/orders/$id');
    return Order.fromJson(Map<String, dynamic>.from(resp.data));
  }

  Future<Order> create(Order order) async {
    final resp = await api.post('/orders', data: order.toJson());
    return Order.fromJson(Map<String, dynamic>.from(resp.data));
  }

  Future<Order> update(int id, Map<String, dynamic> changes) async {
    final resp = await api.put('/orders/$id', data: changes);
    return Order.fromJson(Map<String, dynamic>.from(resp.data));
  }

  Future<void> delete(int id) async {
    await api.delete('/orders/$id');
  }
}
