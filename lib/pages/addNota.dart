// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddNota extends StatefulWidget {
  
  const AddNota({ Key? key }) : super(key: key);
  

  @override
  State<AddNota> createState() => _AddNotaState();
}

class _AddNotaState extends State<AddNota> {
  TextEditingController title = TextEditingController();
  TextEditingController descripcion = TextEditingController();
  FocusNode descrpcionNode = FocusNode();
  String? email = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Añadir nota"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: "Introduce título"),
              textInputAction: TextInputAction.next,
              onEditingComplete: (){
                FocusScope.of(context).requestFocus(descrpcionNode);
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: descripcion,
              focusNode: descrpcionNode,
              maxLines: 4,
              decoration: const InputDecoration(labelText: "Introduce descripción"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen,
                onPrimary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0)
              ),
              onPressed: (){
                setState((){
                  if(title.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Introduzca título")));
                  }else if(descripcion.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Introduzca descripción")));
                  }else{
                    CollectionReference cref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('notas');
                      var data = {
                        'titulo' : title.text,
                        'descripcion' : descripcion.text,
                        'created_at' : DateTime.now(),
                        'user' : email
                      };
                      cref.add(data);
                    Navigator.pop(context);
                  }
                });
              },
              child: 
                const Text("Guardar")),
          ],
        ),
      ),
    );
  }
}