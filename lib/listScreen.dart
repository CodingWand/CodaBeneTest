import 'package:codabenetest/modificationScreen.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  static const routeName = "/ListScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vos produits"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("Il n'y a pas de date de péremption, ajoutez en une !")
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, ModificationScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
