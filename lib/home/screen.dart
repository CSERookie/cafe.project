import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:solarits2/Model/weather.dart';
import 'package:http/http.dart' as http;
import 'package:solarits2/home/activity.dart';
import 'package:solarits2/home/category.dart';
import 'package:solarits2/login-register/loginscreen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';



Future<WeatherModel> getWeather(String lat, String lng) async {
  final response = await http.get(
      'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&appid=a54a16c48825a538dcb625a1c6f80b47&units=metric');
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    var model = WeatherModel.fromJson(result);
    return model;
  } else
    throw Exception('failed to load Weather information');
}

class Denemee extends StatefulWidget {
  @override
  _DenemeeState createState() => _DenemeeState();
}

class _DenemeeState extends State<Denemee> {
 LocationData _currentLocation;
  StreamSubscription<LocationData> _locationSubscription;

  var _locationService = new Location();
  String error;

  void initState() {
    super.initState();
    
    initPlatformState();

    _locationSubscription = _locationService
        .onLocationChanged()
        .listen((LocationData currentLocation) async {
      setState(() {
        _currentLocation = currentLocation;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "CAFE PROJECT ",
            style: TextStyle(fontSize: 35, color: Colors.white),
          ),
          backgroundColor: Colors.blue.shade400,
        ),
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('CAFE',textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),
              decoration: BoxDecoration(
                color: Colors.blue.shade500,
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_box),
              title: Text('LOGIN'),
              onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
        body:Container(
          //alignment: Alignment.center,
          //padding: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.blue.shade900, Colors.blue.shade300],
                  begin: Alignment(-1.0, 1.0),
                  end: Alignment(1.0, -1.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                //color: Colors.blue.shade200,
                alignment: Alignment.center,
                child: ScaleAnimatedTextKit(
    onTap: () {
        print("Tap Event");
      },
    text: [
      "CAFE",
      ],
    textStyle: TextStyle(
        fontSize: 30.0,
        color: Colors.blue.shade800
        
    ),
    textAlign: TextAlign.start,
    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
  ),
                /*Text(
                  "WOW BEACH",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue.shade800, fontSize: 30),
                ), */
                margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
              ),
              Container(
                child: FutureBuilder<WeatherModel>(
                  future: getWeather(_currentLocation.latitude.toString(),
                      _currentLocation.longitude.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      WeatherModel model = snapshot.data;
                      //var fm = DateFormat('HH:mm    dd  MM  yyyy');
                      
                      //var fm_hour = DateFormat.Hm();
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${model.name}',
                            style: TextStyle(color: Colors.white,fontSize: 17),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(width: 55, height: 55,
                              child: Image.network(
                                  'https://openweathermap.org/img/wn/${model.weather[0].icon}.png'),),
                              Text(
                                '${model.main.temp} °C',
                                style: TextStyle(color: Colors.white,fontSize: 27),
                              ),
                            ],
                          ),
                          //Text('${fm.format(DateTime.fromMillisecondsSinceEpoch((model.dt*1000),isUtc: true))}',style: TextStyle(fontSize: 15),),
                          Text(
                  formattedDate,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontStyle: FontStyle.italic),
                ), 
                        ],
                      );
                    } else if (snapshot.hasError)
                      return Text(
                        '${snapshot.error}',
                        style: TextStyle(fontSize: 30),
                      );
                    return CircularProgressIndicator();
                  },
                ),
              ),
              /*padding: EdgeInsets.only(top: 5),
                child: Text(
                  formattedDate,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontStyle: FontStyle.italic),
                ), */

              /*Container(
                child: currentLocation == null
                    ? CircularProgressIndicator()
                    : Text(
                        "Location:" +
                            currentLocation["latitude"].toString() +
                            " " +
                            currentLocation["longitude"].toString(),
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
              ), */
              Stack(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: 300,
                    height: 300,
                    margin:
                        EdgeInsets.only(top: 100), //--------spacebox( ) -------
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey.shade400),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 265,
                    height: 265,
                    margin: EdgeInsets.only(top: 118, left: 17),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade400,
                      border: Border.all(
                          color: Colors.blue.shade700,
                          width: 5,
                          style: BorderStyle.solid),
                    ),
                  ),
                  Positioned(
                      top: 185,
                      left: 90,
                      child: SizedBox(
                        width: 125,
                        height: 125,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle),
                          child: RaisedButton(
                            child: Text(
                              "MENU",
                              style:
                                  TextStyle(fontSize: 26, color: Colors.white),
                            ),
                            color: Colors.blue,
                            shape: CircleBorder(),
                            onPressed: () =>  Navigator.push(context,MaterialPageRoute(builder: (context) => MenuPage())),
                            //Navigator.push(context,MaterialPageRoute(builder: (context) => MenuPage())),
                          ),
                        ),
                      )),
                  Positioned(
                    top: 50,
                    left: 100,
                    child: SizedBox(
                      width: 105,
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle),
                        child: RaisedButton(
                          child: Text(
                            "ETKİNLİK",
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                          color: Colors.blue,
                          shape: CircleBorder(),
                          onPressed: () => 
                           Navigator.push(context,MaterialPageRoute(builder: (context) => ActivityPage())),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 300,
                    left: 0,
                    child: SizedBox(
                      width: 105,
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 5),
                            shape: BoxShape.circle),
                        child: RaisedButton(
                          child: Text(
                            "GARSON ÇAĞIR",
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          color: Colors.blue,
                          shape: CircleBorder(),
                          onPressed: () => _alertDialogGoster(context),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 300,
                    right: 0,
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              //color: Colors.blue,
                              border: Border.all(color: Colors.white, width: 5),
                              shape: BoxShape.circle),
                          child: RaisedButton(
                            child: Text(
                              "HESAP İSTE",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            color: Colors.blue,
                            shape: CircleBorder(),
                            onPressed: () => _hesapIste(context),
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void initPlatformState() async {
    try {
      _currentLocation = await _locationService.getLocation();


    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'Permission denied';
      }else if(e.code == "PERMISSION_DENIED_NEVER_ASK"){
        error = 'Permission denied';
      }
      _currentLocation = null;
    }
  }
}

void _alertDialogGoster(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (ctx) {
      return AlertDialog(title: Text('UYARI'),
      content: Text('Garson çağrıldı.'),
      actions: <Widget>[
        FlatButton(child: Text('OK'),onPressed: (){},)
      ],);
    }
  );
}

void _hesapIste(BuildContext context){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context){
      return AlertDialog(title: Text('UYARI'),content: Text('Hesap getiriliyor.'),actions: <Widget>[
        FlatButton(child: Text('OK'),onPressed: (){},)
      ]);
    }
  );
}