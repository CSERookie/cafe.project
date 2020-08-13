import 'package:flutter/material.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Activity"),
      ),
      body: new ActivityPage1(),
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

class ActivityPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('CAFE'),
      
    );
  }
}