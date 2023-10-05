import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart ';

class GetUsersName extends StatelessWidget {

  final String documentID;

  GetUsersName({required this.documentID});

  @override
  Widget build(BuildContext context) {
    //get the collection
    CollectionReference users = FirebaseFirestore.instance.collection("User Email"); 

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(documentID).get(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              padding: const EdgeInsets.all(25.0),
              color: Colors.grey.shade200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      const Text("All Users:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
                      Text("User: ${data["Name"]}", style: const TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5),
                      Text("Email: ${data["UserEmail"]}", ),
                    ],
                  ),
                ],
              )
            ),
          );
        }
        return Text("loading...");
      },
    );
  }
}