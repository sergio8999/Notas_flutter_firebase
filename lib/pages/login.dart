
import 'package:flutter/material.dart';
import 'package:notas/auth/auth_controller.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        setState(() {
         
        });
        return false;
      },
      child: Scaffold(
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
                  LoginForm(),
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
                      Navigator.pushNamed(context, "/register");
                    },
                    child: 
                        const Text("Registrarse",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold
                        ),))
                 ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FocusNode passwordField = FocusNode();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

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
          Text("Login",
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
                if(checkTextfield()) {
                  logInWithEmailAndPassword(context, email.text, password.text);
                }
              },
              child: 
                const Text("Login")),
          )
        ],
      ),
    );
  }
  bool checkTextfield(){
    if(email.text.isEmpty){
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Introduzca email")));
       return false;
    }else if(password.text.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Introduzca password")));
      return false;
    }
    return true;
  }
}