import 'package:flutter/material.dart';

class ModificationScreenArguments
{
  Map<String, DateTime> dataset;
  bool creation;
  String? gtinCode;

  ModificationScreenArguments(this.dataset, this.creation);
}

class ModificationScreen extends StatefulWidget {

  ModificationScreen({Key? key}) : super(key: key);

  static const routeName = "/ModificationScreen";

  @override
  State<ModificationScreen> createState() => _ModificationScreenState();
}

class _ModificationScreenState extends State<ModificationScreen> {

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as ModificationScreenArguments;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(args.creation ? "Ajout d'un référence" : "${args.gtinCode}"),
            )
          ],
        ),
      ),
    );
  }
}
