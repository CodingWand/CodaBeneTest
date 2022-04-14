import 'package:codabenetest/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class ModificationScreenArguments {
  final Map<String, DateTime> dataset;

  ModificationScreenArguments(this.dataset);
}

class ModificationScreen extends StatefulWidget {
  const ModificationScreen({Key? key}) : super(key: key);

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
            const Center(
              child: Text("Ajout d'une référence"),
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
                    if(args.dataset.containsKey(gtinCode)) {
                      DateTime? currentExpiryDate = args.dataset[gtinCode];
                      if(currentExpiryDate != null) {
                        DateTimeRange timeRange = DateTimeRange(start: currentExpiryDate, end: expiryDate);
                        if(timeRange.duration.isNegative) {
                          setState(() {
                            args.dataset[gtinCode] = expiryDate;
                          });
                        }
                      }
                    } else {
                      setState(() {
                        args.dataset[gtinCode] = expiryDate;
                      });
                    }
                    Navigator.pop(context);
                  } else {
                    debugPrint("Erreur de validation !");
                  }
                },
                child: const Text("Enregistrer")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Annuler"))
          ],
        ),
      ),
    );
  }
}
