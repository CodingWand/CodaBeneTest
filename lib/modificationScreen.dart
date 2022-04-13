import 'package:codabenetest/tools.dart';
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
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: "GTIN"),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null)
                            return "Il faut renseigner ce champ";
                          setState(() {
                            gtinCode = value;
                          });
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Date d'expiration"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(DateFormat.yMMMMEEEEd().format(expiryDate)),
                              TextButton(
                                onPressed: () async {
                                  DateTime? tmpDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate:
                                          DateTime(DateTime.now().year + 100));
                                  if (tmpDate != null) {
                                    setState(() {
                                      expiryDate = tmpDate;
                                    });
                                  }
                                },
                                child: const Icon(
                                  Icons.calendar_today,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if(args.dataset.containsKey(gtinCode)) {
                      DateTime? currentExpiryDate = args.dataset[gtinCode];
                      if(currentExpiryDate != null) {
                        DateTimeRange timeRange = DateTimeRange(start: currentExpiryDate, end: expiryDate);
                        if(timeRange.duration.isNegative) {
                          args.dataset[gtinCode] = expiryDate;
                        }
                      }
                    } else {
                      args.dataset[gtinCode] = expiryDate;
                    }
                    debugPrint("dataset : ${args.dataset}");
                    Navigator.of(context).pop();
                  }
                },
                child: Text(args.creation ? "Enregistrer" : "Modifier")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Annuler"))
          ],
        ),
      ),
    );
  }
}
