import 'package:firebase_auth/firebase_auth.dart';
import 'package:multiple_accounts/services/auth_service.dart';

class AccountServices {
  final AuthService authService = AuthService();

  List<String>? subAccountsList;

  AccountServices();

  Future<void> init() async {
    print("inite girdi");

    final user = authService.currentUser;
    
    if (user == null) {
      
      print("Giriş yapan kullanıcı yok. subAccountsList yüklenemedi.");
      subAccountsList = [];
      return;
    }
    print(user.email);
    subAccountsList = await authService.getSubUserList();

    if (subAccountsList!=null) {
      for (var i = 0; i < subAccountsList!.length ; i++) {
      print(subAccountsList![i]);
    }
    }

    

    //main hesap uidsi ekleme
    if (!subAccountsList!.contains(user.uid)) {
      subAccountsList!.add(user.uid);
    }
  }

  Future<List<String>> updateList()async{
    List<String> userList =  await authService.getSubUserList();
    return userList;
  }

 
  Future<void> addNewAccount(String email, String password) async {
    try {
      final subUid = await tempAccount(email, password);//uidyi çek çekiyor şu anda bunda sıkıntı yok
      if (subUid != null) {
        subAccountsList!.add(subUid);
        
        //bu null geliyor

        User? user = FirebaseAuth.instance.currentUser;//bu null geldi
        if (user == null) {
          print("HATA: Giriş yapan kullanıcı yok!");
          return;
        }

        await authService.db.doc(user.uid).update({
          'subAccounts': subAccountsList,
        });

        subAccountsList = await updateList();
      } else {
        throw Exception("subUid boş geldi");
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<String?> tempAccount(String email, String password) async {
    try {
      FirebaseAuth tempAuth = FirebaseAuth
          .instance; //farklı bir instance kullandığımızdan mevcut oturumu patlatmayacak
      final tempSingIn = await tempAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = tempSingIn.user?.uid;
      await tempAuth.signOut();
      return uid;
    } on Exception catch (e) {
      print(e.toString());
      return null;
    }
  }
}
