import 'package:flutter/material.dart';
import 'package:solarits2/home/drink.dart';
import 'package:solarits2/home/fastfood.dart';





class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Category',
            style: TextStyle(fontSize: 35,),
          ),
          backgroundColor: Colors.orange.shade400,
        ),
        body: Row(
          children: <Widget>[
            GestureDetector(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("assets/drink1.jpg"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withAlpha(150), BlendMode.dstATop)),
                    ),
                    child: Text(
                      "DRİNK",
                      style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )),
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => DrinkState()));
                }),
            GestureDetector(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 2,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage("assets/fast-food3.jpg"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withAlpha(150), BlendMode.dstATop)),
                    ),
                    child: Text(
                      "FAST-FOOD",
                      style: TextStyle(
                        fontSize: 35,fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    )),
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => FastFood()));
                }),
          ],
        ));
  }
}
