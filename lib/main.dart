// ignore_for_file: avoid_print

import 'package:flutter/material.dart'; 
import 'dart:convert';
import 'package:http/http.dart' as http;  
import 'package:flutter/cupertino.dart';
import 'package:flutter_catalog/model.dart'; 
    

    String apiURL = 'https://jsonplaceholder.typicode.com/users'; //Input***
void main() { runApp(const MyApp());} 


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp( 
      //home: Home(),
         home: Scaffold(
          body: JSONListView(),             //1)Cal to create List at body
      )
    );
  }
}



class JSONListView extends StatefulWidget {
  const JSONListView({Key? key}) : super(key: key);

  @override CustomJSONListView createState() => CustomJSONListView();
}
 
class CustomJSONListView extends State {

  //fetch & convert Json data to Map, List, Return
  Future<List<GetUsers>> fetchJSONData(String apiURL) async { 
   var uri =  Uri.parse(apiURL); //1) Parse String to Uri
    var jsonResponse = await http.get(uri); //2) getData
    if (jsonResponse.statusCode == 200) {  //3)//Is Json Successfully Exit 
      //4)jsonData to Map
      final jsonItems = json.decode(jsonResponse.body).cast<Map<String, dynamic>>(); 
      //5) Map To List
      List<GetUsers> usersList = jsonItems.map<GetUsers>((json) {
        return GetUsers.fromJson(json); 
      }).toList(); 
      return usersList;//6)Return List
    } else { throw Exception('Failed to load data from internet');}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      body:
      
       FutureBuilder<List<GetUsers>>(
        future: fetchJSONData(apiURL), //data
        builder: (context, futureData) { 
        if (!futureData.hasData) return const Center(child: CircularProgressIndicator()); //To Show Spinner
          return ListView(
            children: futureData.data!.map((hello) => ListTile(
                  title: Text(hello.name),
                  onTap: (){ print(hello.name); },
                  subtitle: Text(hello.phoneNumber),
                ),
              )
            .toList(),
          );
        },
      ),
    );
  }
    // 
  }
 