import 'package:codabenetest/screens/modificationScreen.dart';
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

  DateTime expiryDate = DateTime.now();
  String gtinCode = "";

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
              child: ListTile(
                title: Text(gtinCode),
                subtitle: Text(DateFormat.yMMMMEEEEd().format(expiryDate)),
              ),
            );
          }
          return const Text("Vide");
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vos produits"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Contenu mis à jour")));
              });
            },
            icon: const Icon(
              Icons.update,
            ),
          ),
        ],
      ),
      body: Container(
        child: (dataset.isEmpty) ? emptyDatasetScreen() : showDataset(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, ModificationScreen.routeName, arguments: ModificationScreenArguments(dataset));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
