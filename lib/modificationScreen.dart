import 'package:codabenetest/listScreen.dart';
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
  ModificationScreen(this.dataset, {Key? key}) : super(key: key);

  static const routeName = "/ModificationScreen";

  Map<String, DateTime> dataset = {};

  @override
  State<ModificationScreen> createState() => _ModificationScreenState();
}

class _ModificationScreenState extends State<ModificationScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime expiryDate = DateTime.now();
  String gtinCode = "";

  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context)!.settings.arguments
    //     as ModificationScreenArguments;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                  false ? "Ajout d'une référence" : "${gtinCode}"),
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
                            textInputDecoration.copyWith(labelText: "GTIN"),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Il faut renseigner ce champ";
                          }
                          setState(() {
                            gtinCode = value;
                          });
                        },
                      ),
                      const SizedBox(height: 30,),
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
                  //if(gtinCode == "") return;
                  if (_formKey.currentState!.validate()) {
                    if(widget.dataset.containsKey(gtinCode)) {
                      DateTime? currentExpiryDate = widget.dataset[gtinCode];
                      if(currentExpiryDate != null) {
                        DateTimeRange timeRange = DateTimeRange(start: currentExpiryDate, end: expiryDate);
                        if(timeRange.duration.isNegative) {
                          setState(() {
                            widget.dataset[gtinCode] = expiryDate;
                          });
                        }
                      }
                    } else {
                      setState(() {
                        widget.dataset[gtinCode] = expiryDate;
                      });
                    }
                    Navigator.pop(context);
                  } else {
                    debugPrint("Erreur de validation !");
                  }
                },
                child: Text(true ? "Enregistrer" : "Modifier")),
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
