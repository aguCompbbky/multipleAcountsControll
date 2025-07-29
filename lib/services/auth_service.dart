import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final List<String> subAcountsUids = [];
class AuthService {

  


  final db = FirebaseFirestore.instance.collection("Users");

  final auth = FirebaseAuth.instance;

  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> registerWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = userCredential.user;

      if (user == null) throw Exception("Kullanıcı oluşturulamadı");

      db.doc(user.uid).set({
        "name": name,
        "email": email,
        "createdAt": DateTime.now(),
        "subAccounts": subAcountsUids,
      });
      subAcountsUids.add(user.uid);
      print(subAcountsUids);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user == null) {
        throw Exception("Kullanıcı bulunamadı.");
      }

      return true;
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
  }
Future<void> logOut() async {
  try {
  await auth.signOut();
} on Exception catch (e) {
  print(e.toString());
}
  
}


Future<String?> getEmail() async {
  final userInfo = await db.doc(currentUser!.uid).get();
  if (userInfo.exists) {
    return userInfo.data()?['email'] as String?;
  }
  return null;
}

Future<List<String>> getSubUserList() async {
  final userInfo = await db.doc(currentUser!.uid).get();
  if (userInfo.exists) {
    final data = userInfo.data();
    final dynamicList = data?['subAccounts'];
    
    if (dynamicList is List) {
      return List<String>.from(dynamicList);
    }
  }
  return [];
}
}
