import 'package:admin_for_chatroom/pages/get_name_page.dart';
import 'package:admin_for_chatroom/readData/get_user_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class GetUserName extends StatefulWidget {
  
  @override
  State<GetUserName> createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  List<String> docIDs = [

  ];
  //get to the page
  void _openMyPage() {
  Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => const GetUserData(),
    ),
  );
}
  Future getDocID() async {
    await FirebaseFirestore.instance.collection("User Posts").get().then(
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
          onPressed: _openMyPage,
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