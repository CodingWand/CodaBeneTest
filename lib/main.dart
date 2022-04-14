import 'package:codabenetest/screens/listScreen.dart';
import 'package:codabenetest/screens/modificationScreen.dart';
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

        //fontFamily: "Cardo",

        textTheme: const TextTheme(
          headline1: TextStyle(
            fontFamily: "JosefinSans",
            fontSize: 70,
            color: Colors.amber,
          ),
          headline2: TextStyle(
            fontFamily: "JosefinSans",
            fontSize: 50,
            color: Colors.amber,
          ),
          bodyText1: TextStyle(fontSize: 20, color: Colors.black),
          bodyText2: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName : (context) => const HomePage(),
        ListScreen.routeName : (context) => const ListScreen(),
        ModificationScreen.routeName : (context) => const ModificationScreen()
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
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(100),
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
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}
