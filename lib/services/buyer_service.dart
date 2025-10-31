import 'package:agrilend/models/buyer.dart'; // Import Buyer model
import 'package:agrilend/services/api_service.dart';

class BuyerService {
  final ApiService _apiService;

  BuyerService(this._apiService);

  Future<Buyer?> getBuyerProfile() async {
    try {
      final response = await _apiService.get('/api/buyer/profile');
      if (response.statusCode == 200 && response.data['success'] == true) {
        final userData = response.data['data'] as Map<String, dynamic>;
        return Buyer.fromJson(userData); // Return Buyer object
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching buyer profile: $e');
    }
    return null;
  }
}