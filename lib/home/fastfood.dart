import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FastFood extends StatefulWidget {
  @override
  _FastFoodState createState() => new _FastFoodState();
}

class _FastFoodState extends State<FastFood> {
  
  Future showDialog() async {
    
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Fast-Food"),
      ),
      body: new MountainList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          //  Firestore.instance.collection('hpc').document()
          //  .setData({ 'title': '', 'price': ''  });
        },
      ),
      
    );
  }
}

class MountainList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('hpc').snapshots(),
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