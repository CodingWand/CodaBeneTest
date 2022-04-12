import 'package:codabenetest/modificationScreen.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({Key? key}) : super(key: key);

  static const routeName = "/ListScreen";

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Map<String, DateTime> dataset = {};

  bool creation = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vos produits"),
        centerTitle: true,
      ),
      body: Container(
        child: (dataset.isEmpty) ? Center(
          child: Text( "Il n'y a pas de date de péremption, ajoutez en une !")
        ) : Container(),
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
