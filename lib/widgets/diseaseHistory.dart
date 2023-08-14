// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:disease_pred/widgets/historyItem.dart';

class DiseaseHistory extends StatelessWidget {
  DiseaseHistory({super.key, });
  final List<Disease> disList=[];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: disList.isNotEmpty? ListView.builder(
          itemBuilder: (ctx, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: HistoryItem(name: disList[index].name, dateRecorded: disList[index].dateRecorded!),
          ),
          itemCount: disList.length
          
        ): const Center(
          child: Text('No History to display!')
        )
        ,
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
