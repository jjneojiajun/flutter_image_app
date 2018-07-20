// Import flutter helper library

import 'package:flutter/material.dart';
// only care about this one function! 
import 'package:http/http.dart' show get;
// for the json
import 'dart:convert';

import 'model/image_model.dart';

import 'widgets/image_list.dart';


// Create a class that will be our custom Widget
// This class must extend the 'StatelessWidget' base class
// App is now a sub class of a StatelessWidget

// Stateless Vs Stateful
// StatelessWidget = Used if this widget will never contain its own data
// StatefulWidget = Used if this widget is going to maintain some data source

class App extends StatefulWidget {
  createState() {
    return AppState();
  }  
} 


// State<App>
class AppState extends State<App>{
  int counter = 0;
  List<ImageModel> images = [];

  // Build Method Return the widgets that *this* widget will show
  void fetchImage() async {
    counter++;
    var response = await get('https://jsonplaceholder.typicode.com/photos/$counter');
    var imageModel = ImageModel.fromJson(json.decode(response.body));

    setState(() {
      images.add(imageModel);
    });
  }

  Widget build(context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lets See Images!'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchImage, // need to pass a function
          child: Icon(Icons.add),
        ),
        body: ImageList(images),
      ), 
    );
  }
}

