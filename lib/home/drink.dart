import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class DrinkState extends StatefulWidget {
  @override
  _DrinkStateState createState() => _DrinkStateState();
}

class _DrinkStateState extends State<DrinkState> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Drink"),
      ),
      body: new DrinkState1(),
      
      
    );
  }
}

class DrinkState1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('hpc1').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return ListView(
          children: snapshot.data.documents.map<Widget>((document) {
            return ListTile(
              leading: CircleAvatar(backgroundImage: AssetImage('assets/solarits12.png'),),
              title: Text(document['title']),
              subtitle: Text('Fiyat:' + document['price'].toString()+ ' ₺'),
            );
          }).toList(),
        );
      },
    );
  }
}