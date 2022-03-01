// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:notas/auth/auth_controller.dart';
import 'package:notas/pages/addNota.dart';
import 'package:notas/pages/editNota.dart';
import 'package:notas/pages/noteDetail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Query ref = FirebaseFirestore.instance.collection('notas').where("user", isEqualTo: FirebaseAuth.instance.currentUser?.email);
  CollectionReference ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).collection('notas');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Notas"),
        actions: [
            IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Atrás',
            onPressed: () {
              logOut(context);
            }),
        ],
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  Map data = snapshot.data!.docs[index].data();
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    decoration: const BoxDecoration(
                      color: Colors.white
                    ),
                    child: Slidable(
                      key: const ValueKey(0),
                      endActionPane:  ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (datas) {
                                  Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => EditNota(titulo:data['titulo'],descripcion:data['descripcion'], time: data['created_at'], ref:snapshot.data!.docs[index].reference))
                                  ).then((value) {
                                    setState(() {
                                      
                                    });
                                  });
                                ref.doc(data['id']).delete();
                              },
                              backgroundColor: const Color(0xFF21B7CA),
                              foregroundColor: Colors.white,
                              icon: Icons.edit,
                              label: 'Editar',
                            ),
                            SlidableAction(
                              onPressed: (datas) async{
                                if(await confirmDelete(context)){
                                  snapshot.data!.docs[index].reference.delete();
                                  setState(() {
                                    
                                  });
                                }
                              },
                              backgroundColor: const Color(0xFFFE4A49),
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Borrar',
                            ),
                          ],
                        ),
                      child: ListTile(
                        title: Text("${data['titulo']}"),
                        onTap: (){
                           Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => NoteDetail(title: data['titulo'], descpption:data['descripcion'], time: data['created_at'])
                                  ));
                        }
                      ),
                    ),
                  );
                },
              );
            }else{
              return const Center(child: CircularProgressIndicator());
            }
          }),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightGreen,
            child: const Icon(Icons.add,color: Colors.black),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddNota())).then((value){
                setState(() {
                  
                });
              });
            })
    );
  }
  void doNothing(BuildContext context) {}

  Future<bool> confirmDelete(BuildContext context) async{
    return showDialog(
      context: context, 
      builder: (context)=>AlertDialog(
        title: const Text("Confirmar borrado"),
        content: const Text("¿Esta seguro que desea borrar?"),
        actions: [
          FlatButton(
            onPressed: ()=> Navigator.pop(context,false), 
            child: const Text("No")),
            FlatButton(
            onPressed: ()=> Navigator.pop(context,true), 
            child: const Text("Si"))
        ],
      )).then((value) => value ?? false);
  }
  
}