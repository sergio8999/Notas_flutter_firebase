// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  final String title;
  final String descpption;
  final Timestamp time;
  const NoteDetail({ Key? key, required this.title, required this.descpption, required this.time }) : super(key: key);

  @override
  _NoteDetailState createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text("Detalle nota"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(widget.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0
                ),
                ),
              ),
              const SizedBox(height: 10.0),
              Text(widget.descpption,
              style: const TextStyle(
                fontSize: 22.0
              ),
              ),
              const SizedBox(height: 10.0),
              Text(changeDateToText(widget.time))
            ],
          ),
        ),
      ),
    );
  }

  String changeDateToText(Timestamp data){
    DateTime mydataTime = data.toDate();
    String time = DateFormat.yMMMd().add_Hm().format(mydataTime);
    return time;
  }
}