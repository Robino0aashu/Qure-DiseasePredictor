import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class TagSelectorScreen extends StatefulWidget {
  @override
  _TagSelectorScreenState createState() => _TagSelectorScreenState();
}

class _TagSelectorScreenState extends State<TagSelectorScreen> {
  var isSending = false;
  bool isUploaded = false;
  late Map diagnosis;
  List<String> allTags = [
    'abdominal_pain',
    'abnormal_menstruation',
    'acidity',
    'acute_liver_failure',
    'altered_sensorium',
    'anxiety',
    'back_pain',
    'belly_pain',
    'blackheads',
    'bladder_discomfort',
    'blister',
    'blood_in_sputum',
    'bloody_stool',
    'blurred_and_distorted_vision',
    'breathlessness',
    'brittle_nails',
    'bruising',
    'burning_micturition',
    'chest_pain',
    'chills',
    'cold_hands_and_feets',
    'coma',
    'congestion',
    'constipation',
    'continuous_feel_of_urine',
    'continuous_sneezing',
    'cough',
    'cramps',
    'dark_urine',
    'dehydration',
    'depression',
    'diarrhoea',
    'dischromic_patches',
    'distention_of_abdomen',
    'dizziness',
    'drying_and_tingling_lips',
    'enlarged_thyroid',
    'excessive_hunger',
    'extra_marital_contacts',
    'family_history',
    'fast_heart_rate',
    'fatigue',
    'fluid_overload',
    'foul_smell_ofurine',
    'headache',
    'high_fever',
    'hip_joint_pain',
    'history_of_alcohol_consumption',
    'increased_appetite',
    'indigestion',
    'inflammatory_nails',
    'internal_itching',
    'irregular_sugar_level',
    'irritability',
    'irritation_in_anus',
    'joint_pain',
    'knee_pain',
    'lack_of_concentration',
    'lethargy',
    'loss_of_appetite',
    'loss_of_balance',
    'loss_of_smell',
    'malaise',
    'mild_fever',
    'mood_swings',
    'movement_stiffness',
    'mucoid_sputum',
    'muscle_pain',
    'muscle_wasting',
    'muscle_weakness',
    'nausea',
    'neck_pain',
    'nodal_skin_eruptions',
    'obesity',
    'pain_behind_the_eyes',
    'pain_during_bowel_movements',
    'pain_in_anal_region',
    'painful_walking',
    'palpitations',
    'passage_of_gases',
    'patches_in_throat',
    'phlegm',
    'polyuria',
    'prominent_veins_on_calf',
    'puffy_face_and_eyes',
    'pus_filled_pimples',
    'receiving_blood_transfusion',
    'receiving_unsterile_injections',
    'red_sore_around_nose',
    'red_spots_over_body',
    'redness_of_eyes',
    'restlessness',
    'runny_nose',
    'rusty_sputum',
    'scurring',
    'shivering',
    'silver_like_dusting',
    'sinus_pressure',
    'skin_peeling',
    'skin_rash',
    'slurred_speech',
    'small_dents_in_nails',
    'spinning_movements',
    'spotting_urination',
    'stiff_neck',
    'stomach_bleeding',
    'stomach_pain',
    'sunken_eyes',
    'sweating',
    'swelled_lymph_nodes',
    'swelling_joints',
    'swelling_of_stomach',
    'swollen_blood_vessels',
    'swollen_extremeties',
    'swollen_legs',
    'throat_irritation',
    'toxic_look_(typhos)',
    'ulcers_on_tongue',
    'unsteadiness',
    'visual_disturbances',
    'vomiting',
    'watering_from_eyes',
    'weakness_in_limbs',
    'weakness_of_one_body_side',
    'weight_gain',
    'weight_loss',
    'yellow_crust_ooze',
    'yellow_urine',
    'yellowing_of_eyes',
    'yellowish_skin',
    'itching'
  ];

  List<String> selectedTags = [];

  List<String> displayedTags = [];

  TextEditingController searchController = TextEditingController();

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;


  @override
  void initState() {
    super.initState();
    displayedTags = allTags;
  }

  void filterTags(String searchTerm) {
    setState(() {
      displayedTags = allTags
          .where((tag) => tag.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    });
  }

  void toggleTagSelection(String tag) {
    setState(() {
      if (selectedTags.contains(tag)) {
        selectedTags.remove(tag);
      } else {
        selectedTags.insert(0, tag);
      }
    });
  }

  void _uploadSymptoms(List<String> symptom) async {
    setState(() {
      isSending = true;
    });

    http.Response resp = await http.post(
        Uri.parse("https://disease-predictor-api.onrender.com/pred/"),
        body: json.encode({"data": symptom}),
        headers: {"Content-Type": "application/json"});

    setState(() {
      isSending = false;
    });

    if (resp.statusCode == 200) {
      print(jsonDecode(resp.body)["Prediction"]);
      setState(() {
        isUploaded = true;
        diagnosis = jsonDecode(resp.body);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: const Center(child: Text('Diagnosis Result')),
                content: Container(
                  // height: 300,
                  // width: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Disease: ${diagnosis['Prediction']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 20),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Suggestions: ',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 18.0 * (diagnosis['Precaution'].length),
                        width: 300,
                        child: ListView.builder(
                          itemBuilder: (context, index) => Text(
                              '${index + 1}. ${diagnosis['Precaution'][index]}'),
                          itemCount: diagnosis['Precaution'].length,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: () async{
                        var querySnapshot = await _firestore.collection('History').get();
                        var arr1,arr2;
                        bool flag=false;
                        for (var i in querySnapshot.docs){
                          if (i.id==_auth.currentUser?.uid){
                            arr1 = i.data()['Diagnosis'];
                            arr2 = i.data()['Dates'];

                            arr2.add(DateTime.now());
                            arr1.add(diagnosis['Prediction']);
                            flag=true;
                          }
                        }
                        if(flag){
                          _firestore.collection('History').doc(_auth.currentUser?.uid).update({'Diagnosis':arr1,'Dates':arr2});
                        }
                        else{
                          _firestore.collection('History').doc(_auth.currentUser?.uid).set({'Diagnosis':[diagnosis["Prediction"]],'Dates':[DateTime.now()]});
                        }

                        Navigator.of(context).pop();
                      }, child: const Text('Add to History'))
                ],
              );
            });
      });
    } else {
      print("API call return failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            'Choose Symptoms',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Color(0xFFebebeb),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: filterTags,
                decoration: const InputDecoration(
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
            ),
            if (selectedTags.isNotEmpty)
              Expanded(
                flex: 1,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: selectedTags.length,
                    itemBuilder: (context, index) {
                      final tag = selectedTags[index];
                      return InkWell(
                        onLongPress: () {
                          toggleTagSelection(tag);
                        },
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Color(0xFF0066FE)),
                          alignment: Alignment.center,
                          height: 10,
                          child: Text(
                            tag.split('_').join(' ').toUpperCase(),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
              ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                itemCount: displayedTags.length,
                itemBuilder: (context, index) {
                  final tag = displayedTags[index];
                  final isSelected = selectedTags.contains(tag);
                  return ListTile(
                    title: Text(tag.split('_').join(' ').toUpperCase()),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle,
                            color: Color(0xFF0066FE))
                        : null,
                    onTap: () => toggleTagSelection(tag),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF0066FE),
                  shadowColor: const Color(0xFF0066FE),
                  elevation: 5,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
                child: isSending ? CircularProgressIndicator() : Text('Submit'),
                onPressed: () {
                  _uploadSymptoms(selectedTags);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
