import 'package:firebase_auth/firebase_auth.dart';
import 'package:green_circle/models/user.dart';
// sign in methods code
class AuthService{
  final FirebaseAuth auth = FirebaseAuth.instance;
  MyUser? userFromFirebase(User? user){
    return user!=null? MyUser(uid:user.uid):null;
  }
  Stream<MyUser?> get user{
    return auth.authStateChanges().map(userFromFirebase);
  }
  Future signUpEmail(String email,String password)async{
    try{
      UserCredential result= await auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=result.user;
      return userFromFirebase(user);
    }
    catch(e){
      print(e);
    }
  }
  Future signOut() async{
    try{
      return auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  Future signInemailandpassword(String email,String password) async{
    try{
      UserCredential result= await auth.signInWithEmailAndPassword(email: email, password: password);
      User? user= result.user;
      return userFromFirebase(user);
    }catch(e){
      return null;
    }
  }
}
