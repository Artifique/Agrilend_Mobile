import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product_model.dart';
import '../models/order_model.dart';
import '../models/buyer_profile_model.dart';

// Provider pour les produits disponibles
final productsProvider = StateNotifierProvider<ProductsNotifier, List<ProductModel>>((ref) {
  return ProductsNotifier();
});

class ProductsNotifier extends StateNotifier<List<ProductModel>> {
  ProductsNotifier() : super([]) {
    // Charger automatiquement les produits au démarrage
    loadProducts();
  }

  void loadProducts() {
    // Simulation de données - à remplacer par l'API
    state = [
      ProductModel(
        id: '1',
        farmerId: 'farmer1',
        farmerName: 'Jean Kouassi',
        name: 'Tomates fraîches',
        description: 'Tomates biologiques cultivées sans pesticides',
        category: 'Légumes',
        quantity: 50.0,
        unit: 'kg',
        suggestedPrice: 800.0,
        finalPrice: 750.0,
        harvestDate: DateTime.now().add(const Duration(days: 3)),
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now(),
        images: ['assets/images/tomatoes.jpg'],
        isAvailable: true,
        isVerified: true,
      ),
      ProductModel(
        id: '2',
        farmerId: 'farmer2',
        farmerName: 'Marie Traoré',
        name: 'Bananes plantain',
        description: 'Bananes plantain mûres, idéales pour la cuisine',
        category: 'Fruits',
        quantity: 30.0,
        unit: 'kg',
        suggestedPrice: 600.0,
        finalPrice: 550.0,
        harvestDate: DateTime.now().add(const Duration(days: 1)),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
        images: ['assets/images/bananas.jpg'],
        isAvailable: true,
        isVerified: true,
      ),
      ProductModel(
        id: '3',
        farmerId: 'farmer3',
        farmerName: 'Pierre N\'Guessan',
        name: 'Riz parfumé',
        description: 'Riz de qualité supérieure, cultivé localement',
        category: 'Céréales',
        quantity: 100.0,
        unit: 'kg',
        suggestedPrice: 1200.0,
        finalPrice: 1100.0,
        harvestDate: DateTime.now().add(const Duration(days: 5)),
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        updatedAt: DateTime.now(),
        images: ['assets/images/rice.jpg'],
        isAvailable: true,
        isVerified: true,
      ),
    ];
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      loadProducts();
      return;
    }
    
    state = state.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase()) ||
             product.description.toLowerCase().contains(query.toLowerCase()) ||
             product.category.toLowerCase().contains(query.toLowerCase()) ||
             product.farmerName.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void filterByCategory(String category) {
    if (category == 'Tous') {
      loadProducts();
      return;
    }
    
    state = state.where((product) => product.category == category).toList();
  }

  void addProduct(ProductModel product) {
    state = [...state, product];
  }

  void updateProduct(ProductModel product) {
    state = state.map((p) => p.id == product.id ? product : p).toList();
  }

  void removeProduct(String productId) {
    state = state.where((p) => p.id != productId).toList();
  }
}

// Provider pour les commandes de l'acheteur
final buyerOrdersProvider = StateNotifierProvider<BuyerOrdersNotifier, List<OrderModel>>((ref) {
  return BuyerOrdersNotifier();
});

class BuyerOrdersNotifier extends StateNotifier<List<OrderModel>> {
  BuyerOrdersNotifier() : super([]);

  void loadOrders(String buyerId) {
    // Simulation de données - à remplacer par l'API
    state = [
      OrderModel(
        id: 'order1',
        buyerId: buyerId,
        farmerId: 'farmer1',
        productId: '1',
        productName: 'Tomates fraîches',
        farmerName: 'Jean Kouassi',
        quantity: 10.0,
        unit: 'kg',
        unitPrice: 750.0,
        totalPrice: 7500.0,
        status: OrderStatus.escrowed,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        escrowDate: DateTime.now().subtract(const Duration(days: 1)),
        deliveryAddress: 'Abidjan, Cocody',
        notes: 'Livraison prévue le matin',
      ),
      OrderModel(
        id: 'order2',
        buyerId: buyerId,
        farmerId: 'farmer2',
        productId: '2',
        productName: 'Bananes plantain',
        farmerName: 'Marie Traoré',
        quantity: 5.0,
        unit: 'kg',
        unitPrice: 550.0,
        totalPrice: 2750.0,
        status: OrderStatus.delivered,
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1)),
        escrowDate: DateTime.now().subtract(const Duration(days: 4)),
        releaseDate: DateTime.now().subtract(const Duration(days: 2)),
        deliveryDate: DateTime.now().subtract(const Duration(days: 1)),
        deliveryAddress: 'Abidjan, Cocody',
      ),
    ];
  }

  void createOrder(OrderModel order) {
    state = [order, ...state];
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    state = state.map((order) {
      if (order.id == orderId) {
        return OrderModel(
          id: order.id,
          buyerId: order.buyerId,
          farmerId: order.farmerId,
          productId: order.productId,
          productName: order.productName,
          farmerName: order.farmerName,
          quantity: order.quantity,
          unit: order.unit,
          unitPrice: order.unitPrice,
          totalPrice: order.totalPrice,
          status: newStatus,
          createdAt: order.createdAt,
          updatedAt: DateTime.now(),
          escrowDate: order.escrowDate,
          releaseDate: order.releaseDate,
          deliveryDate: order.deliveryDate,
          hederaTransactionId: order.hederaTransactionId,
          deliveryAddress: order.deliveryAddress,
          notes: order.notes,
          metadata: order.metadata,
        );
      }
      return order;
    }).toList();
  }

  List<OrderModel> getOrdersByStatus(OrderStatus status) {
    return state.where((order) => order.status == status).toList();
  }
}

// Provider pour le profil de l'acheteur
final buyerProfileProvider = StateNotifierProvider<BuyerProfileNotifier, BuyerProfileModel?>((ref) {
  return BuyerProfileNotifier();
});

class BuyerProfileNotifier extends StateNotifier<BuyerProfileModel?> {
  BuyerProfileNotifier() : super(null);

  void loadProfile(String userId) {
    // Simulation de données - à remplacer par l'API
    state = BuyerProfileModel(
      id: 'buyer_profile_1',
      userId: userId,
      businessName: 'Restaurant Le Bon Goût',
      businessType: 'Restaurant',
      businessAddress: 'Abidjan, Cocody, Rue des Jardins',
      businessPhone: '+225 07 12 34 56 78',
      businessEmail: 'contact@bon-gout.ci',
      hederaAccountId: '0.0.123456',
      hbarBalance: 150.0,
      preferredCategories: ['Légumes', 'Fruits'],
      deliveryAddress: 'Abidjan, Cocody',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }

  void updateProfile(BuyerProfileModel profile) {
    state = profile;
  }

  void updateHederaAccount(String accountId, String privateKey) {
    if (state != null) {
      state = BuyerProfileModel(
        id: state!.id,
        userId: state!.userId,
        businessName: state!.businessName,
        businessType: state!.businessType,
        businessAddress: state!.businessAddress,
        businessPhone: state!.businessPhone,
        businessEmail: state!.businessEmail,
        hederaAccountId: accountId,
        hederaPrivateKey: privateKey,
        hbarBalance: state!.hbarBalance,
        preferredCategories: state!.preferredCategories,
        deliveryAddress: state!.deliveryAddress,
        notes: state!.notes,
        createdAt: state!.createdAt,
        updatedAt: DateTime.now(),
        metadata: state!.metadata,
      );
    }
  }

  void updateHbarBalance(double newBalance) {
    if (state != null) {
      state = BuyerProfileModel(
        id: state!.id,
        userId: state!.userId,
        businessName: state!.businessName,
        businessType: state!.businessType,
        businessAddress: state!.businessAddress,
        businessPhone: state!.businessPhone,
        businessEmail: state!.businessEmail,
        hederaAccountId: state!.hederaAccountId,
        hederaPrivateKey: state!.hederaPrivateKey,
        hbarBalance: newBalance,
        preferredCategories: state!.preferredCategories,
        deliveryAddress: state!.deliveryAddress,
        notes: state!.notes,
        createdAt: state!.createdAt,
        updatedAt: DateTime.now(),
        metadata: state!.metadata,
      );
    }
  }
}
