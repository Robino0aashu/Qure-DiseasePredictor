import 'package:disease_pred/widgets/diseaseHistory.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
    required this.navigatetoDiagnosis,
  }) : super(key: key);

  final Function navigatetoDiagnosis;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.44,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(235, 235, 235, 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Good Morning,\n Sir',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuthScreen()));
                          },
                          icon: const Icon(Icons.exit_to_app))
                    ],
                  ),
                  const Text('How are you feeling today?',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0.5,
                              )
                            ],
                            color: Color.fromRGBO(235, 235, 235, 1),
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                          child: TextButton.icon(
                              onPressed: () => widget.navigatetoDiagnosis(),
                              icon: const Icon(Icons.medication_outlined),
                              label: const Text(
                                'Diagnosis',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              )),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(45)),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0.5,
                              )
                            ],
                            color: Color.fromRGBO(235, 235, 235, 1),
                            borderRadius: BorderRadius.all(Radius.circular(45)),
                          ),
                          child: TextButton.icon(
                              onPressed: () async {
                                Uri url =
                                    Uri(scheme: 'tel', path: "09841017000");
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                } else {
                                  print("Cannot Launch");
                                }
                              },
                              icon: const Icon(Icons.call),
                              label: const Text(
                                'Call Us',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.only(
                top: 16,
                left: 16,
                right: 16,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Diagnosis History',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
            DiseaseHistory(),
          ]),
        ),
      ),
    );
  }
}
