import 'package:ecoclub/services/user_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecoclub/models/user_model.dart' as userModel;

class GoogleAuth {
  Future googleSignIn() async{
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    print("REACHED HERE");

    var currentUser = FirebaseAuth.instance.currentUser;

    userModel.User newUser = new userModel.User(
      name: currentUser!.displayName!,
      profilePicUrl: currentUser.photoURL!,
      uuid: currentUser.uid,
    );

    UserService().addUser(newUser);

  }
}