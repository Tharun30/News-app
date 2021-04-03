import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Cachedata {
  final String API_URL =
      "https://wcreu.com/index.php/wp-json/wp/v2/posts?per_page=20&categories=6&status=publish";
}

class example extends StatefulWidget {
  @override
  _exampleState createState() => _exampleState();
}

class _exampleState extends State<example> with TickerProviderStateMixin {
  var text;
  late AnimationController controller;
  var loading;

  addcachedata() async {
    String filename = 'CacheData.json';
    var json = [
      {
        "id": 14279,
        "date": "2021-03-31T18:20:47",
        "date_gmt": "2021-03-31T12:50:47",
        "jetpack_featured_media_url":
            "https://wcreu.com/wp-content/uploads/2021/03/KOT-DAK-4.jpg"
      },
      {
        "id": 14251,
        "date": "2021-03-30T18:25:50",
        "date_gmt": "2021-03-30T12:55:50",
        "jetpack_featured_media_url":
            "https://wcreu.com/wp-content/uploads/2021/03/IMG_20210330_0013-1.jpg"
      }
    ];
    setState(() {
      loading = false;
    });
    var cacheDir = await getTemporaryDirectory();
    if (await File(cacheDir.path + "/" + filename).exists()) {
      print("Loading from cache");
      String jsonData = File(cacheDir.path + "/" + filename).readAsStringSync();
      final response = jsonDecode(jsonData);
      print(response);

      return jsonData;
    } else {
      print("Loading from API");
      final response = await Dio().get(
          'https://wcreu.com/index.php/wp-json/wp/v2/posts?per_page=20&categories=$num&status=publish');

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.data);
        var tempDir = await getTemporaryDirectory();
        File file = new File(tempDir.path + "/" + filename);
        file.writeAsString(jsonResponse, flush: true, mode: FileMode.write);
        print(jsonResponse);

        return jsonResponse;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    setState(() {
      text = addcachedata();
      loading = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return Scaffold(body: Center(child: Text(text.toString())));
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
