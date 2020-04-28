import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:flip_card/flip_card.dart';

import 'Category.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url =
      "http://newsapi.org/v2/top-headlines?country=in&apiKey=4e0ed9699cfd4357997c11b9968a3fd4";
  List data;
  bool enabled = false;

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    // print(response.body);
    setState(() {
      var convertDataToJSON = json.decode(response.body);
      data = convertDataToJSON['articles'];
    });
    return "Success";
  }

  @override
  Widget build(BuildContext context) {
    print("hello");
    if (data != null) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Breaking News',style: TextStyle(fontFamily: 'Kaushan Script',fontSize: 25),),
            backgroundColor: Colors.blueAccent,
          ),
          body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.red])),
    child: new ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  child: FlipCard(
                      direction: FlipDirection.HORIZONTAL,
                      // onTap: (){
                      //   _launchURL(data[index]['url']);
                      //},
                      back: Card(
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.all(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [Colors.blue, Colors.white])),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "DESCRIPTION : " +
                                          (data[index]['description'] != null
                                              ? data[index]['description']
                                              : "Null"),
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold
                                      ,fontFamily: 'Kaushan Script',),
                                      maxLines: 4,
                                    ),
                                    padding: EdgeInsets.only(
                                        top: 25.0, bottom: 5.0, left: 10.0),
                                  ),
                                  Container(
                                    child: Text(
                                      "Published AT : " +
                                          (data[index]['publishedAt'] != null
                                              ? data[index]['publishedAt']
                                              : "Null"),
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                      fontFamily: 'Kaushan Script'),
                                    ),
                                    padding: EdgeInsets.only(
                                        top: 25.0, bottom: 25.0),
                                  ),
                                  RaisedButton(
                                    color: Colors.green,
                                    child: Text(
                                      "GO TO URL",
                                      style: TextStyle(color: Colors.white,fontFamily: 'Kaushan Script'),
                                    ),
                                    onPressed: () {
                                      _launchURL(data[index]['url']);
                                    },
                                    elevation: 9.0,
                                  ),
                                  Container(height: 20.0)
                                ],
                              ))),
                      front: Container(
                        child: Card(
                          color: Colors.black,
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          elevation: 25.0,
                          margin: EdgeInsets.all(10),
                          child: Stack(
                            children: <Widget>[
                              Image(
                                  height: 250.0,
                                  width: 600.0,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      data[index]['urlToImage'] != null
                                          ? data[index]['urlToImage']
                                          : "")),
                              Container(
                                height: 220.0,
                                child: Text(
                                  data[index]['title'] != null
                                      ? data[index]['title']
                                      : " ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                alignment: Alignment.bottomCenter,
                                //   padding:EdgeInsets.only(left: 10.0,right: 10.0)
                                margin: EdgeInsets.all(10.0),
                              ),
                            ],
                          ),
                        ),
                      )),
                );
              }
              ),
          ),
          drawer: Drawer(
          child:  Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.red])),
              child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              DrawerHeader(
               /* decoration: BoxDecoration(
                    color: Colors.blue,
                    image: DecorationImage(
                        image: AssetImage("assets/images/category.jpg"),
                        fit: BoxFit.cover))*/
               child: Center(
                 child: Text("CATEGORIES",
                   style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,color: Colors.white,
                   fontFamily: 'Kaushan Script'),
                 )
               ),
              ),
              ListTile(
                contentPadding: EdgeInsets.all(15.0),
                leading: Container(
                    width: 66.0,
                    height: 69.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                new AssetImage("assets/images/homepage.png")))),
                title: Text(
                  'Home',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'Kaushan Script',fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.all(15.0),
                leading: Container(
                    width: 66.0,
                    height: 69.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                new AssetImage("assets/images/science.jpg")))),
                title: Text(
                  'Science',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'Kaushan Script',fontSize: 20),
                ),
                onTap: () {
                  _sendDataToSecondScreen(context, 'science');
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.all(15.0),
                leading: Container(
                    width: 66.0,
                    height: 69.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                new AssetImage("assets/images/health.jpg")))),
                title: Text(
                  'Health',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'Kaushan Script',fontSize: 20),
                ),
                onTap: () {
                  _sendDataToSecondScreen(context, 'health');
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.all(15.0),
                leading: Container(
                    width: 66.0,
                    height: 69.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage(
                                "assets/images/entertainment.jpg")))),
                title: Text(
                  'Entertainment',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'Kaushan Script',fontSize: 20),
                ),
                onTap: () {
                  _sendDataToSecondScreen(context, 'entertainment');
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.all(15.0),
                leading: Container(
                    width: 66.0,
                    height: 69.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage(
                                "assets/images/technology.jpg")))),
                title: Text(
                  'Technology',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'Kaushan Script',fontSize: 20),
                ),
                onTap: () {
                  _sendDataToSecondScreen(context, 'technology');
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.all(15.0),
                leading: Container(
                    width: 66.0,
                    height: 69.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                new AssetImage("assets/images/business.jpg")))),
                title: Text(
                  'Business',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'Kaushan Script',fontSize: 20),
                ),
                onTap: () {
                  _sendDataToSecondScreen(context, 'business');
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.all(15.0),
                leading: Container(
                    width: 66.0,
                    height: 69.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                new AssetImage("assets/images/sports.jpg")))),
                title: Text(
                  'Sports',
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontFamily: 'Kaushan Script',fontSize: 20),
                ),
                onTap: () {
                  _sendDataToSecondScreen(context, "sports",);
                },
              ),
            ],
          )
    )
    )
      );
    } else {
      return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.storage),
            title: Text('Breaking News',style: TextStyle(fontFamily: 'Kaushan Script',fontSize: 25),),
            backgroundColor: Colors.blueAccent,
          ),
          body:Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.blue, Colors.red])),
           child:  Center(child: SpinKitDualRing(size: 60, color: Colors.blueAccent)
              //SpinKitCubeGrid(size: 101.0, color: Colors.red)
              )
    )
      );
    }
  }
}

Future<void> _launchURL(String s) async {
  String url = s;
  //Uri.encodeFull(s);
  if (await canLaunch(url)) {
    await launch(url, forceSafariVC: false, forceWebView: false);
  } else {
    throw 'Could not launch $url';
  }
}

void _sendDataToSecondScreen(BuildContext context, String string) {
  String textToSend = string;
  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Category(
          text: textToSend,
        ),
      ));
}
