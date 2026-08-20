import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../data/models/expense_model.dart';

class HomeController extends GetxController {
  final currentIndex = 0.obs;

  final expenses = <Expense>[].obs;
  final userName = 'User'.obs;
  final userEmail = ''.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  StreamSubscription<User?>? _authSubscription;
  StreamSubscription<QuerySnapshot>? _expensesSubscription;
  StreamSubscription<DocumentSnapshot>? _userDocSubscription;

  @override
  void onInit() {
    super.onInit();
    // Listen to real-time auth state changes and bind Firestore streams automatically
    _authSubscription = _auth.authStateChanges().listen((user) {
      _userDocSubscription?.cancel();
      _expensesSubscription?.cancel();

      if (user != null) {
        userEmail.value = user.email ?? '';

        // Listen to user profile document
        _userDocSubscription = _firestore
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .listen((doc) {
          if (doc.exists && doc.data() != null) {
            final data = doc.data() as Map<String, dynamic>;
            userName.value = data['name'] ?? 'User';
          }
        });

        // Listen to user's real-time expenses stream
        _expensesSubscription = _firestore
            .collection('expenses')
            .where('userId', isEqualTo: user.uid)
            .orderBy('date', descending: true)
            .snapshots()
            .listen((snapshot) {
          expenses.value = snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            final timestamp = data['date'] as Timestamp?;
            return Expense(
              id: doc.id,
              amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
              category: data['category'] ?? 'Others',
              date: timestamp?.toDate() ?? DateTime.now(),
              note: data['title'] ?? '',
            );
          }).toList();
        });
      } else {
        expenses.clear();
        userName.value = 'User';
        userEmail.value = '';
      }
    });
  }

  @override
  void onClose() {
    _authSubscription?.cancel();
    _expensesSubscription?.cancel();
    _userDocSubscription?.cancel();
    super.onClose();
  }

  Future<void> refreshData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data() as Map<String, dynamic>;
        userName.value = data['name'] ?? 'User';
      }

      final snapshot = await _firestore
          .collection('expenses')
          .where('userId', isEqualTo: user.uid)
          .orderBy('date', descending: true)
          .get();

      expenses.value = snapshot.docs.map((doc) {
        final data = doc.data();
        final timestamp = data['date'] as Timestamp?;
        return Expense(
          id: doc.id,
          amount: (data['amount'] as num?)?.toDouble() ?? 0.0,
          category: data['category'] ?? 'Others',
          date: timestamp?.toDate() ?? DateTime.now(),
          note: data['title'] ?? '',
        );
      }).toList();
    }
  }

  double get totalSpent => expenses.fold(0.0, (sum, item) => sum + item.amount);

  double get spentThisMonth => totalSpent;

  int get transactionsCount => expenses.length;

  double get averageSpentPerDay {
    if (expenses.isEmpty) return 0.0;
    return totalSpent / 30.0;
  }

  Map<String, double> get categoryTotals {
    final totals = {
      'Shopping': 0.0,
      'Bills': 0.0,
      'Food': 0.0,
      'Transport': 0.0,
      'Others': 0.0,
    };
    for (var exp in expenses) {
      if (totals.containsKey(exp.category)) {
        totals[exp.category] = totals[exp.category]! + exp.amount;
      } else {
        totals['Others'] = totals['Others']! + exp.amount;
      }
    }
    return totals;
  }

  void addExpense(double amount, String category, DateTime date, String note) {
    final user = _auth.currentUser;
    if (user != null) {
      _firestore.collection('expenses').add({
        'userId': user.uid,
        'amount': amount,
        'category': category,
        'date': Timestamp.fromDate(date),
        'title': note.isEmpty ? '$category expense' : note,
      });
    }
  }
}
