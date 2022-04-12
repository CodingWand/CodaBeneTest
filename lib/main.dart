import 'package:codabenetest/listScreen.dart';
import 'package:codabenetest/modificationScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodaBeneTest',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName : (context) => HomePage(),
        ListScreen.routeName : (context) => ListScreen(),
        ModificationScreen.routeName : (context) => ModificationScreen()
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "Bienvenue",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 50,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 100),
            child: Center(
                child: TextButton(
                  onPressed: (){
                    Navigator.popAndPushNamed(context, ListScreen.routeName);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                  ),
                  child: Text(
                    "Commencer",
                    style: TextStyle(fontSize: 25, color: Colors.white,),
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}
