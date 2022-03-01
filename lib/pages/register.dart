// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:notas/auth/auth_controller.dart';

// ignore: use_key_in_widget_constructors
class RegisterPage extends StatefulWidget {

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: kToolbarHeight),
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/google.png"),
                      fit: BoxFit.fitHeight),
                  shape: BoxShape.circle
                ),
                width: 80.0,
                height: 80.0,
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0)
              ),
              onPressed: (){
                signInWithGoogle(context);
              },
              child: 
                const Text("Continuar con Google")),
                const SizedBox(height: 30.0),
                SignUpForm(),
                const SizedBox(height: 20.0),
                OutlinedButton( 
                  style: ElevatedButton.styleFrom(
                    primary: Colors.lightGreen,
                    onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),    
                    ),
                  side: const BorderSide( width: 1.0, color: Colors.white),
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0)),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: 
                     const Icon(Icons.arrow_back)
                      )
               ],
          ),
        ),
      ),
    );
  }
}


class SignUpForm extends StatelessWidget {
  final FocusNode passwordField = FocusNode();
  final FocusNode confirmPasswordField = FocusNode();
  
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Column(
        children: [
          Text("Registrarse",
            style: TextStyle(
              fontSize: 33.0,
              color: Colors.grey.shade500
            )),
            const SizedBox(height: 20.0),
          TextFormField(
            controller: email,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: "Escriba dirección email",
              contentPadding: const EdgeInsets.all(16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0)
              ),
              labelStyle: const TextStyle(
                fontSize: 18.0,
                color: Colors.grey
              )
            ),
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordField);
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: password,
            textInputAction: TextInputAction.next,
            focusNode: passwordField,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Escriba contraseña",
              contentPadding: const EdgeInsets.all(16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0)
              ),
              labelStyle: const TextStyle(
                fontSize: 18.0,
                color: Colors.grey
              )
            ),
             onEditingComplete: () {
              FocusScope.of(context).requestFocus(confirmPasswordField);
            },
          ),
          const SizedBox(height: 16.0),
          TextFormField(
            controller: confirmPassword,
            focusNode: confirmPasswordField,
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Confirme contraseña",
              contentPadding: const EdgeInsets.all(16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4.0)
              ),
              labelStyle: const TextStyle(
                fontSize: 18.0,
                color: Colors.grey
              )
            ),
          ),
          const SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0)
              ),
              onPressed: (){
                if(checkTextfield(context)){
                  signUp(context, email.text, password.text);
                }
              },
              child: 
                const Text("Registrar")),
          )
        ],
      ),
    );
  }
  bool checkTextfield(BuildContext context){
    if(email.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Introduzca email")));
      return false;
    }else if(password.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Introduzca password")));
      return false;
    }else if(confirmPassword.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Introduzca confirmación password")));
      return false;
    }else if(password.text != confirmPassword.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Las contraseñas deben coincidir")));
       return false;
    }
    return true;
  }
}