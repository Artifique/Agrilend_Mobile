import '../models/transaction.dart';
import 'api_service.dart';

class TransactionService {
  final ApiService api;

  TransactionService(this.api);

  Future<List<Transaction>> fetchAll() async {
    final resp = await api.get('/transactions');
    final data = resp.data as List<dynamic>;
    return data
        .map((e) => Transaction.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<Transaction> getById(int id) async {
    final resp = await api.get('/transactions/$id');
    return Transaction.fromJson(Map<String, dynamic>.from(resp.data));
  }

  Future<Transaction> create(Transaction t) async {
    final resp = await api.post('/transactions', data: t.toJson());
    return Transaction.fromJson(Map<String, dynamic>.from(resp.data));
  }
}
