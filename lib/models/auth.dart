import 'package:bus_ticket_booking_app/pages/homepage.dart';
import 'package:bus_ticket_booking_app/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';




// creating firebase instance
/*
final FirebaseAuth auth = FirebaseAuth.instance;

Future<void> signup(BuildContext context) async {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
  if (googleSignInAccount != null) {
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    // Getting users credential
    UserCredential result = await auth.signInWithCredential(authCredential);
    User? user  = result.user;

    if( result != null){
      Navigator.push(context,MaterialPageRoute(builder: (context)=> HomePage()),);
    }
    // if (result != null) {
    // Navigator.push(
    //    context, MaterialPageRoute(builder: (context) => HomePage()));
  }  // if result not null we simply call the MaterialpageRoute,
  // for go to the HomePage screen
}
//}
*/

class AuthController extends GetxController {
  signUp(String name, String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection('user')
            .add({"name": name, "email": email, "password": password});
        // print("Done");
        Get.snackbar("Sign Up", "Sign Up successfully",
            snackPosition: SnackPosition.BOTTOM);
        Get.offAll(LoginPage());
      });
      update();
    } catch (e) {
      print(e);
      Get.snackbar("Something went wrong", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }