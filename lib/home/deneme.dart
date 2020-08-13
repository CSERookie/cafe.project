import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FastFood extends StatefulWidget {
  @override
  _FastFoodState createState() => new _FastFoodState();
}

class _FastFoodState extends State<FastFood> {
  @override
  void initState() {
//    Firestore.instance.collection('mountains').document()
//        .setData({ 'title': 'Mount Baker', 'type': 'volcano' });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Fast-Food"),
      ),
      body: new MountainList(),
      
    );
  }
}

class MountainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('hpc').snapshots(),
      builder: (BuildContext context, snapshot) {
        if (!snapshot.hasData) return new Text('Loading...');
        return ListView(
          children: snapshot.data.documents.map((document) {
            return ListTile(
              title: Text(document['title']),
              subtitle: Text(document['type']),
            );
          }).toList(),
        );
      },
    );
  }
}