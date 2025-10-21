import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/product.dart';
import '../../../models/order.dart';
import '../../../models/buyer.dart';

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
  return BuyerOrdersNotifier();
});

class BuyerOrdersNotifier extends StateNotifier<List<Order>> {
  BuyerOrdersNotifier() : super([]);

  void loadOrders(String buyerId) {
    // Simulation de données - à remplacer par l'API
    // Create simple orders mapping to central Order model shape (some fields may be missing)
    state = [
      Order(
        id: 1,
        buyerId: int.tryParse(buyerId) ?? 0,
        offerId: 1,
        quantity: 10.0,
        unitPrice: 750.0,
        totalPrice: 7500.0,
        status: 'ESCROWED',
      ),
      Order(
        id: 2,
        buyerId: int.tryParse(buyerId) ?? 0,
        offerId: 2,
        quantity: 5.0,
        unitPrice: 550.0,
        totalPrice: 2750.0,
        status: 'DELIVERED',
      ),
    ];
  }

  void createOrder(Order order) {
    state = [order, ...state];
  }

  void updateOrderStatus(int orderId, String newStatus) {
    state = state.map((order) {
      if (order.id == orderId) {
        return Order(
          id: order.id,
          buyerId: order.buyerId,
          offerId: order.offerId,
          quantity: order.quantity,
          unitPrice: order.unitPrice,
          totalPrice: order.totalPrice,
          status: newStatus,
          productName: order.productName,
          farmerName: order.farmerName,
          createdAt: order.createdAt,
          deliveryDate: order.deliveryDate,
          escrowDate: order.escrowDate,
          deliveryAddress: order.deliveryAddress,
        );
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
  return BuyerProfileNotifier();
});

class BuyerProfileNotifier extends StateNotifier<Buyer?> {
  BuyerProfileNotifier() : super(null);

  void loadProfile(String userId) {
    // Simulation de données - à remplacer par l'API
    state = Buyer(
      userId: int.tryParse(userId) ?? 0,
      companyName: 'Restaurant Le Bon Goût',
      businessType: 'Restaurant',
    );
  }

  void updateProfile(Buyer profile) {
    state = profile;
  }

    // Central Buyer model doesn't have Hedera fields. Keep no-op or extend model if needed.
  }

    // No-op: central Buyer model doesn't carry balance.
 
