import 'package:disease_pred/screens/homeScreen.dart';
import 'package:disease_pred/screens/tagSelectorScreen.dart';
import 'package:disease_pred/widgets/custom_bottomNav.dart';
import 'package:flutter/material.dart';

class TabManager extends StatefulWidget {
  const TabManager({super.key});

  @override
  State<TabManager> createState() => _TabManagerState();
}

class _TabManagerState extends State<TabManager> {
  late List<Widget> _content;
  int pageIndex = 0;

  void navigatePage(){
    setState(() {
      pageIndex=1;
    });
  }

  @override
  Widget build(BuildContext context) {
    _content = [
      HomeScreen( navigatetoDiagnosis: navigatePage,),
      TagSelectorScreen()
    ];
    return Scaffold(
        body: _content[pageIndex],
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: pageIndex,
          showElevation: true,
          onItemSelected: (index) {
            setState(() {
              pageIndex = index;
            });
          },
          items: [
            FlashyTabBarItem(
              icon: const Icon(Icons.home),
              title: const Text('Home'),
            ),
            FlashyTabBarItem(
              icon: const Icon(Icons.search_outlined),
              title: const Text('Diagnosis'),
            ),
          ],
        ));
  }
}
