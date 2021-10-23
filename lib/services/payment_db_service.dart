import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PaymentDbService {

  Future addPaymentToDb(int amt) async{

    CollectionReference payments = FirebaseFirestore.instance.collection('payments');
    String uuid = FirebaseAuth.instance.currentUser!.uid;

    try {
      payments.add({
        "amount": amt,
        "uuid": uuid,
      }).then((value) => print("ADDED PAYMENT TO DB")).catchError((e) => print(e));
    }
    catch(e){
      print(e);
    }

  }

}