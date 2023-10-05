import 'package:admin_for_chatroom/readData/get_name_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetUserData extends StatefulWidget {
  const GetUserData({super.key});

  @override
  State<GetUserData> createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
 List<String> docIDs = [

  ];

  Future getDocID() async {
    await FirebaseFirestore.instance.collection("User Email").get().then(
      (snapshot) => snapshot.docs.forEach((document) { 
        print(document.reference);

        docIDs.add(document.reference.id);
      })
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 75,
        title: const Text("Admin panel", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            
          },
          icon: const Icon(Icons.person),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getDocID(),
              builder: (context, snapshot) => ListView.builder(
              itemCount: docIDs.length,
              itemBuilder: (context, index) {
              return ListTile(
                title: GetUsersName(documentID: docIDs[index],),
              );
              },),
          )
          )
        ],
      ),
    );
  }
}