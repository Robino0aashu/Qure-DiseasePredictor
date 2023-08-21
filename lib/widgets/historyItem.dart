import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryItem extends StatelessWidget {
  HistoryItem({super.key, required this.name, required this.dateRecorded});
  final String name;
  final DateTime dateRecorded;

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Remove From History"),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            var querySnapshot =
                                await _firestore.collection('History').get();
                            var arr1, arr2;
                            for (var i in querySnapshot.docs) {
                              if (i.id == _auth.currentUser?.uid) {
                                arr1 = i.data()['Diagnosis'];
                                arr2 = i.data()['Dates'];

                                arr2.removeAt(arr1.indexOf(this.name));
                                arr1.remove(this.name);
                              }
                            }
                            _firestore
                                .collection('History')
                                .doc(_auth.currentUser?.uid)
                                .update({'Diagnosis': arr1, 'Dates': arr2});

                            Navigator.of(context).pop();
                          },
                          child: const Text("Yes"),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"))
                      ],
                    ),
                  ],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                ));
      },
      child: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 10,
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromRGBO(235, 235, 235, 1),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              child: Icon(Icons.local_hospital_outlined),
            ),
            // const SizedBox(
            //   width: 20,
            // ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.66,
                    child: Text(
                      name,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 22,
                          ),
                      textAlign: TextAlign.left,
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(dateRecorded),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
