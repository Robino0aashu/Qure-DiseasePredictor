import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryItem extends StatelessWidget {
  const HistoryItem(
      {super.key, required this.name, required this.dateRecorded});
  final String name;
  final DateTime dateRecorded;
  @override
  Widget build(BuildContext context) {
    return Container(
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
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 22,
                    ),
                textAlign: TextAlign.left,
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
        ],
      ),
    );
  }
}
