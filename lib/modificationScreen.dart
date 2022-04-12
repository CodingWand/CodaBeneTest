import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ModificationScreenArguments {
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
  final _formKey = GlobalKey<FormState>();

  DateTime expiryDate = DateTime.now();
  String gtinCode = "";

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments
        as ModificationScreenArguments;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                  args.creation ? "Ajout d'une référence" : "${args.gtinCode}"),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: "nombre GTIN", labelText: "GTIN"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null) return "Il faut renseigner ce champ";
                        setState(() {
                          gtinCode = value;
                        });
                      },
                    ),
                    TextFormField(
                      onTap: () async {
                        DateTime? tmpDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year + 100));
                        if(tmpDate != null) {
                          expiryDate = tmpDate;
                        }
                      },
                      decoration:
                          const InputDecoration(labelText: "Date d'expiration"),
                      keyboardType: TextInputType.datetime,
                      initialValue: DateFormat.yMd().format(expiryDate),
                      validator: (value) {
                        if (value != null) {
                          DateTime tmpDate = DateTime.parse(value);
                          if (DateTimeRange(start: DateTime.now(), end: tmpDate)
                                  .duration
                                  .inDays <
                              0) return "Renseignez une date valide";
                          setState(() {
                            expiryDate = tmpDate;
                          });
                        } else {
                          return "Renseignez ce champ";
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(args.creation ? "Enregistrer" : "Modifier")
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Annuler")
            )
          ],
        ),
      ),
    );
  }
}
