import 'package:codabenetest/modificationScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  static const routeName = "/ListScreen";

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Map<String, DateTime> dataset = {};

  bool creation = true;

  Center emptyDatasetScreen() {
    return const Center(
        child: Text( "Il n'y a pas de date de péremption, ajoutez en une !")
    );
  }

  Container showDataset() {
    return Container(
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
          return Container(
            child: const Text("Vide"),
          );
        },
      ),
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
          Navigator.pushNamed(context, ModificationScreen.routeName, arguments: ModificationScreenArguments(dataset, creation));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
