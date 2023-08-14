import 'package:flutter/material.dart';

class PredictedDisease extends StatefulWidget {
  final Map diagnosis;

  PredictedDisease({required this.diagnosis});

  @override
  State<PredictedDisease> createState() => _PredictedDiseaseState();
}

class _PredictedDiseaseState extends State<PredictedDisease>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  // void initState() {
  //   HISTORY.insert(
  //       0,
  //       Disease(
  //           name: widget.diagnosis["Prediction"],
  //           defination: DISEASE_LIST
  //               .firstWhere((dis) => dis.name == widget.diagnosis['Prediction'])
  //               .defination,
  //           dateRecorded: DateTime.now()));
  //   print(HISTORY);
  //   super.initState();
  //   controller = AnimationController(
  //       vsync: this, duration: Duration(milliseconds: 800), lowerBound: 0.45);
  //   animation =
  //       CurvedAnimation(parent: controller, curve: Curves.easeInOutBack);

  //   controller.reverse(from: 0.45);
  //   controller.addListener(() {
  //     setState(() {});
  //     print(animation.value);
  //   });
  // }

  String precaution(Map x) {
    String res = "";
    for (int i = 0; i < 3; i++) {
      if (x["Precaution"][i] != "Nan") {
        res += "- " + x["Precaution"][i] + "\n";
      }
    }

    return res;
  }

  late String prec = precaution(widget.diagnosis);

  bool state = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'Diagnosis',
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Color(0xFFEBEBEB),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            if (animation.isCompleted) {
              controller.reverse(from: 1);
            } else if (animation.isDismissed) {
              controller.forward();
            }
            await Future.delayed(Duration(milliseconds: 175));
            state = !state;
          },
          child: Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width * 0.75,
              height: animation.value * 250,
              decoration: BoxDecoration(
                color: Color(0xFFEBEBEB),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: [
                    Text(
                      "${widget.diagnosis["Prediction"]}",
                      style: TextStyle(fontSize: 30),
                    ),
                    // SizedBox(height: 20,),
                    state
                        ? Container(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                prec,
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              ),
                            ),
                            width: animation.value * 250,
                            decoration: BoxDecoration(
                              color: Color(0xFF0066FE),
                              borderRadius: BorderRadius.circular(40),
                            ),
                          )
                        : Container(),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
