import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('users');

  // Add a product to user's history or create user document if it doesn't exist
  Future<void> addProductToHistory(
      String userId, String username, String product) async {
    try {
      await usersCollection.doc(userId).set({
        'username': username,
        'history': FieldValue.arrayUnion([product]),
      }, SetOptions(merge: true));
    } catch (e) {
      print("Error adding product to history: $e");
    }
  }
}
