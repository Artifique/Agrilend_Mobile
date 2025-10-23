import 'package:agrilend/models/order.dart';
import 'package:agrilend/services/api_service.dart';

class OrderService {
  final ApiService _apiService;

  OrderService(this._apiService);

  Future<List<Order>> getOrders() async {
    try {
      final response = await _apiService.get('/api/buyer/orders');
      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> ordersData = response.data['data'];
        return ordersData.map((json) => Order.fromJson(json)).toList();
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching orders: $e');
    }
    return [];
  }
}