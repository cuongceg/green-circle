import 'package:cloud_firestore/cloud_firestore.dart';

class Database{
  String? uid;
  Database({this.uid});
  final CollectionReference userCollection=FirebaseFirestore.instance.collection('user');
  Future updateData(String? fullName,String? assets) async{
    return await userCollection.doc(uid).set({
      "name":fullName,
      "assets":assets,
      "uid":uid
    });
  }
}