import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/cache.dart';
import 'package:path_provider/path_provider.dart';
import 'package:news_app/home.dart';
import 'package:dio/dio.dart';
import 'user.dart';

void main() {
  runApp(MaterialApp(
    title: 'Rest Api',
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => MyApp(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  late var futureAlbum;
  var check;
  var loading;
  late AnimationController controller;
  fetchdata(int num) async {
    setState(() {
      loading = false;
    });
    String filename = 'CacheData.json';
    var cacheDir = await getTemporaryDirectory();
    print(cacheDir);
    if (await File(cacheDir.path + "/" + filename).exists()) {
      print("Loading from cache");
      var jsonData = File(cacheDir.path + "/" + filename).readAsStringSync();
      final response = jsonDecode(jsonData);
      return response;
    } else {
      print("Loading from API");
      final response = await Dio().get(
          'https://wcreu.com/index.php/wp-json/wp/v2/posts?per_page=20&categories=$num&status=publish');

      if (response.statusCode == 200) {
        setState(() async {
          futureAlbum = response.data;
          loading = true;
          var tempDir = await getTemporaryDirectory();
          print(tempDir);
          File file = new File(tempDir.path + "/" + filename);
          file.writeAsString(futureAlbum, flush: true, mode: FileMode.write);
          return jsonDecode(response.data);
        });
      } else {
        throw Exception('Failed to load album');
      }
    }
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();

    futureAlbum = fetchdata(6);
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            title: Text(
              'ABC',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                onPressed: () {
                  // do something
                },
              )
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  height: 100,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        FlatButton(
                          child: Text('सभी समाचार'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            fetchdata(6);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton(
                          child: Text('अंतरराष्ट्रीय'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            fetchdata(5);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton(
                          child: Text('स्थानीय समाचार'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            fetchdata(25);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton(
                          child: Text('राजस्थान'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            fetchdata(25);
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton(
                          child: Text('ई पेपर'),
                          color: Colors.blueAccent,
                          textColor: Colors.white,
                          onPressed: () {
                            fetchdata(25);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 180,
                  child: ListView.builder(
                    itemCount: loading ? futureAlbum.length : 0,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 200,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: ListTile(
                            title: Image.network(futureAlbum[index]
                                ['jetpack_featured_media_url']),
                            subtitle: Text(futureAlbum[index]['date']),
                            trailing: FlatButton(
                              child: Text('-->'),
                              color: Colors.blueAccent,
                              textColor: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Datapage(futureAlbum[index])));
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          drawer: Drawer(),
        ),
      );
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            value: controller.value,
            semanticsLabel: 'Linear progress indicator',
          ),
        ),
      );
    }
  }
}

class Datapage extends StatelessWidget {
  var futurealbum;
  Datapage(@required this.futurealbum);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Data Page', style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              futurealbum['id'].toString(),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Image.network(
              futurealbum['jetpack_featured_media_url'],
              height: 350,
              width: 200,
            ),
            Text(
              futurealbum['date'].toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              futurealbum['status'].toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              futurealbum['title']['rendered'].toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              futurealbum.length.toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
