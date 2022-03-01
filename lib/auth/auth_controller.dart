// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notas/pages/home.dart';
import 'package:notas/pages/login.dart';


GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth auth = FirebaseAuth.instance;
CollectionReference users = FirebaseFirestore.instance.collection('users');

void signInWithGoogle(BuildContext context) async{
  try{
    
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null){
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(accessToken: googleSignInAuthentication.accessToken, idToken: googleSignInAuthentication.idToken);

      final UserCredential authResult = await auth.signInWithCredential(credential);

      final User? user = authResult.user;
      
      var userData = {
        'name' : googleSignInAccount.displayName,
        'provider' : 'google',
        'email': googleSignInAccount.email
      };

      users.doc(user?.uid).get().then((doc){
        if(doc.exists){
          doc.reference.update(userData);
          
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }else{
          users.doc(user?.uid).set(userData);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
        }
      });
    }
  }catch(exception){
    const snackBar = SnackBar(
            content: Text("Error al iniciar"),
        );
  }
}
  // Registrar usuario con email y password
  Future<void> signUp(BuildContext context, String email,String password) async {
    var userData;
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
        userData = {
          'name' : 'name',
          'provider' : 'email',
          'email': email
        },

        users.doc(value.user?.uid).get().then((doc){
          if(doc.exists){
            doc.reference.update(userData);
          
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }else{
            users.doc(value.user?.uid).set(userData);

            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }
        })
      });
    } catch(exception){
        const snackBar = SnackBar(
            content: Text("Error al crear el usuario"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> logInWithEmailAndPassword(BuildContext context, String email,String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value) => {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          )
      });
    } catch(exception){
        const snackBar = SnackBar(
            content: Text("Error al iniciar sesión"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  
  // cerrar sesion
  Future<void> logOut(BuildContext context) async {
    try {
      await Future.wait([
        auth.signOut(),
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          )
      ]);
    } catch(exception) {
        const snackBar = SnackBar(
            content: Text("Error al cerrar"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
