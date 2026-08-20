import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ExpenseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Add expense
  Future<void> addExpense({
    required String title,
    required double amount,
    required String category,
  }) async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        throw Exception('User is not logged in');
      }

      await _firestore.collection('expenses').add({
        'userId': currentUser.uid,
        'title': title,
        'amount': amount,
        'category': category,
        'date': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add expense: $e');
    }
  }

  // Get stream of expenses for current user, ordered by date descending
  Stream<QuerySnapshot> getUserExpensesStream() {
    final User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection('expenses')
        .where('userId', isEqualTo: currentUser.uid)
        .orderBy('date', descending: true)
        .snapshots();
  }
}
