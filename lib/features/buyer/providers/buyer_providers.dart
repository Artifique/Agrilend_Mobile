import 'package:agrilend/services/auth_providers.dart';
import 'package:agrilend/services/buyer_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/product.dart';
import '../../../models/order.dart';
import '../../../models/buyer.dart';
import 'package:agrilend/services/order_service.dart';

// Provider pour les produits disponibles
final productsProvider = StateNotifierProvider<ProductsNotifier, List<Product>>((ref) {
  return ProductsNotifier();
});

class ProductsNotifier extends StateNotifier<List<Product>> {
  ProductsNotifier() : super([]) {
    // Charger automatiquement les produits au démarrage
    loadProducts();
  }

  void loadProducts() {
    // Simulation de données - à remplacer par l'API
    state = [
        Product(
          id: 1,
          name: 'Tomates fraîches',
          description: 'Tomates biologiques cultivées sans pesticides',
          category: 'Légumes',
          unit: 'kg',
          imageUrl: 'assets/images/tomatoes.jpg',
        ),
        Product(
          id: 2,
          name: 'Bananes plantain',
          description: 'Bananes plantain mûres, idéales pour la cuisine',
          category: 'Fruits',
          unit: 'kg',
          imageUrl: 'assets/images/bananas.jpg',
        ),
        Product(
          id: 3,
          name: 'Riz parfumé',
          description: 'Riz de qualité supérieure, cultivé localement',
          category: 'Céréales',
          unit: 'kg',
          imageUrl: 'assets/images/rice.jpg',
        ),
    ];
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      loadProducts();
      return;
    }
    
    state = state.where((product) {
      final name = product.name.toLowerCase();
      final desc = (product.description ?? '').toLowerCase();
      final cat = product.category.toLowerCase();
      return name.contains(query.toLowerCase()) ||
             desc.contains(query.toLowerCase()) ||
             cat.contains(query.toLowerCase());
    }).toList();
  }

  void filterByCategory(String category) {
    if (category == 'Tous') {
      loadProducts();
      return;
    }
    
    state = state.where((product) => product.category == category).toList();
  }

  void addProduct(Product product) {
    state = [...state, product];
  }

  void updateProduct(Product product) {
    state = state.map((p) => p.id == product.id ? product : p).toList();
  }

  void removeProduct(String productId) {
    state = state.where((p) => p.id.toString() != productId).toList();
  }
}

// Provider pour les commandes de l'acheteur
final buyerOrdersProvider = StateNotifierProvider<BuyerOrdersNotifier, List<Order>>((ref) {
  final orderService = ref.watch(orderServiceProvider);
  return BuyerOrdersNotifier(orderService);
});

class BuyerOrdersNotifier extends StateNotifier<List<Order>> {
  final OrderService _orderService;

  BuyerOrdersNotifier(this._orderService) : super([]);

  Future<void> loadOrders() async {
    state = await _orderService.getOrders();
  }

  void createOrder(Order order) {
    state = [order, ...state];
  }

  void updateOrderStatus(int orderId, String newStatus) {
    state = state.map((order) {
      if (order.id == orderId) {
        return order.copyWith(status: newStatus);
      }
      return order;
    }).toList();
  }

  List<Order> getOrdersByStatus(String status) {
    return state.where((order) => order.status == status).toList();
  }
}

// Provider pour le profil de l'acheteur
final buyerProfileProvider = StateNotifierProvider<BuyerProfileNotifier, Buyer?>((ref) {
  final buyerService = ref.watch(buyerServiceProvider);
  return BuyerProfileNotifier(buyerService);
});

class BuyerProfileNotifier extends StateNotifier<Buyer?> {
  final BuyerService _buyerService;
  BuyerProfileNotifier(this._buyerService) : super(null);

  Future<void> loadProfile() async {
    final profile = await _buyerService.getBuyerProfile();
    state = profile;
  }
}
