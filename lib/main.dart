// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notas/pages/home.dart';
import 'package:notas/pages/login.dart';
import 'package:notas/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Quitar imagen debugg del lado
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      title: 'Notas',
      initialRoute: '/login',
      routes: {
        // Cuando naveguemos hacia la ruta "/", crearemos el Widget FirstScreen
        '/login': (context) => LoginPage(),
        // Cuando naveguemos hacia la ruta "/second", crearemos el Widget SecondScreen
        '/register': (context) => RegisterPage(),
        '/homePage': (context) => HomePage(),
  
      },
    );
  }
}