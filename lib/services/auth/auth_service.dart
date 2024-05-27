import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // login
  Future<UserCredential> signInWithEmailAndPassword(
      String email, password) async {
    //loggin in
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // saving data
      _firestore.collection('Users').doc(userCredential.user!.uid).set(
        {'uid': userCredential.user!.uid, 'email': email},
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // signup
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, password) async {
    // create user
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // save user details
      _firestore.collection('Users').doc(userCredential.user!.uid).set(
        {'uid': userCredential.user!.uid, 'email': email},
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // log out
  Future<void> logout() async {
    return await _auth.signOut();
  }
}
