import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:disease_pred/widgets/historyItem.dart';

class DiseaseHistory extends StatefulWidget {


  const DiseaseHistory({super.key, });

  @override
  State<DiseaseHistory> createState() => _DiseaseHistoryState();
}

class _DiseaseHistoryState extends State<DiseaseHistory> {
  final List<Disease> disList=[];
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("History").snapshots(),
        builder: (context, snapshot){
          List <Widget> dis = [];
          bool flag = false;

          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong!",style: TextStyle(fontSize: 25,color: Colors.grey),),);
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading...",style: TextStyle(fontSize: 25,color: Colors.grey),),);
          }

          if (!snapshot.hasData){
            const CircularProgressIndicator();
          }
          else{
            final data = snapshot.data?.docs;
            var rec;
            for (var i in data!){
              if (i.id==_auth.currentUser?.uid){
                flag=true;
                rec = i.data() as Map;
                break;
              }
            }
            if(flag){
              for(var j=0;j<rec['Diagnosis'].length;j++){
                dis.add(Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HistoryItem(name: rec['Diagnosis'][j], dateRecorded: rec['Dates'][j].toDate()),
                ));
              }
            }
            else{
              return const Center(child: Text("No History",style: TextStyle(fontSize: 25,color: Colors.grey),),);
            }
          }

          return ListView(children: dis,);
        }
      ),
    );
  }
}

class Disease {
  
  String name;
  DateTime? dateRecorded;
  
  Disease({
    required this.name,
    this.dateRecorded,
  });
}