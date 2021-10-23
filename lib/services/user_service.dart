import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecoclub/models/user_model.dart';

class UserService {

  Future<bool> checkIfUserExists(String uuid) async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var doc = await users.doc(uuid).get();
    return doc.exists;
  }

  Future addUser(User user) async{
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
        users.doc(user.uuid).set(user.toJson()).whenComplete(() {
          print("USER SUCCESSFULLY ADDED TO FIRESTORE");
        }).catchError((e){
          print(e);
        });
    }
    catch(e){
      print(e);
    }
  }

}