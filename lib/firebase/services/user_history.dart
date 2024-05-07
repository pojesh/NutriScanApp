import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/firebase/services/login_controller.dart';

class UserHistory extends GetxController {
  final controller = Get.put(LoginController());
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxList<String> userHistory = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserHistory(); // Fetch user history when the controller initializes
  }

  Future<List<String>> fetchUserHistory() async {
    try {
      // Get the current signed-in user
      final GoogleSignInAccount? account = controller.googleAccount.value;

      if (account != null) {
        // Fetch the user's history from Firestore
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(account.email).get();

        if (userDoc.exists) {
          // Get the history_arrayofelements from the document
          List<dynamic> history = userDoc.get('history');

          // Update the userHistory list with the fetched history
          userHistory.assignAll(history.cast<String>());

          // Return the user history list
          return userHistory;
        }
      }

      // Return an empty list if user history is not found
      return [];
    } catch (e) {
      print("Error fetching user history: $e");
      // Return an empty list in case of error
      return [];
    }
  }
}
