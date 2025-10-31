import '../models/product.dart';
import 'api_service.dart';

class ProductService {
  final ApiService api;

  ProductService(this.api);

  Future<List<Product>> fetchAll() async {
    final resp = await api.get('/api/products');
    final data = resp.data as List<dynamic>;
    return data
        .map((e) => Product.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<Product> getById(int id) async {
    final resp = await api.get('/api/products/$id');
    return Product.fromJson(Map<String, dynamic>.from(resp.data));
  }

  Future<Product> create(Product product) async {
    final resp = await api.post('/api/products', data: product.toJson());
    return Product.fromJson(Map<String, dynamic>.from(resp.data));
  }
}
