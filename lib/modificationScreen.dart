import 'package:flutter/material.dart';

class ModificationScreen extends StatefulWidget {

  //Modify the code here because the app need the dataset and the creation boolean
  Map<String, DateTime>? dataset;
  bool? creation;
  String? gtinCode;

  static const routeName = "/ModificationScreen";

  ModificationScreen({this.dataset, this.creation, this.gtinCode, Key? key}) : super(key: key);

  @override
  State<ModificationScreen> createState() => _ModificationScreenState();
}

class _ModificationScreenState extends State<ModificationScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text("Ajout d'une référence"),//Text(this.widget.creation ? "Ajout d'une référence" : "Modification"),
            )
          ],
        ),
      ),
    );
  }
}
