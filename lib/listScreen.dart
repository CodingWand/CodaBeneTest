import 'package:codabenetest/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  static const routeName = "/ListScreen";

  //static Map<String, DateTime> dataset = {};

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Map<String, DateTime> dataset = {};
  final _formKey = GlobalKey<FormState>();

  bool creation = true;

  Center emptyDatasetScreen() {
    return const Center(
        child: Text( "Il n'y a pas de date de péremption, ajoutez en une !")
    );
  }

  Container showDataset() {
    return Container(
      key: ValueKey<int>(dataset.length),
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: dataset.length,
        itemBuilder: (context, index) {
          String gtinCode = dataset.keys.elementAt(index);
          DateTime? tmpDate = dataset[gtinCode];
          if(tmpDate != null) {
            DateTime expiryDate = tmpDate;
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("GTIN : $gtinCode"),
                  Text(DateFormat.yMMMMEEEEd().format(expiryDate)),
                ],
              ),
            );
          }
          return const Text("Vide");
        },
      ),
    );
  }

  Widget showModificationScreen() {
    DateTime expiryDate = DateTime.now();
    String gtinCode = "";

    return ListView(
      children: [
        Center(
          child: Text("Ajout d'une référence : $gtinCode"),
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
                    decoration: textInputDecoration.copyWith(labelText: "GTIN"),
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
                      return null;
                    },
                  ),
                  const SizedBox(height: 30,),
                  Column(
                    key: ValueKey(expiryDate.toString()),
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
                if(dataset.containsKey(gtinCode)) {
                  DateTime? currentExpiryDate = dataset[gtinCode];
                  if(currentExpiryDate != null) {
                    DateTimeRange timeRange = DateTimeRange(start: currentExpiryDate, end: expiryDate);
                    if(timeRange.duration.isNegative) {
                      setState(() {
                        dataset[gtinCode] = expiryDate;
                      });
                    }
                  }
                } else {
                  setState(() {
                    dataset[gtinCode] = expiryDate;
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vos produits"),
        centerTitle: true,
      ),
      body: Container(
        child: (dataset.isEmpty) ? emptyDatasetScreen() : showDataset(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(context: context, builder: (context) {
            return showModificationScreen();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
