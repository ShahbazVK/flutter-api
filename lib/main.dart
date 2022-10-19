import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
    apicall();
  }

  var url, drinks;

  void apicall() async {
    url = Uri.https(
        'thecocktaildb.com', 'api/json/v1/1/search.php', {'s': 'cocktail'});
    var response = await http.get(url);
    print(jsonDecode(response.body)["drinks"]);
    drinks = jsonDecode(response.body)["drinks"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: LinearGradient(colors: [Colors.red,Colors.orange]),
      appBar: AppBar(
        title: Text("Cocktail"),
        backgroundColor: Color.fromARGB(255, 255, 153, 0),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.red, Colors.orange]),
        ),
        child: drinks == null
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: drinks.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        drinks[index]["strDrinkThumb"],
                      ),
                    ),
                    title: Text(
                      drinks[index]["strDrink"],
                    ),
                    subtitle: Text(drinks[index]["idDrink"]),
                  );
                },
              ),
      ),
    );
  }
}
