import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class Cachedata {
  final String API_URL =
      "https://wcreu.com/index.php/wp-json/wp/v2/posts?per_page=20&categories=6&status=publish";
  addcachedata() async {
    String filename = 'CacheData.json';
    var cacheDir = await getTemporaryDirectory();
    if (await File(cacheDir.path + "/" + filename).exists()) {
      print("Loading from cache");
      var jsonData = File(cacheDir.path + "/" + filename).readAsStringSync();
      final response = jsonDecode(jsonData);
      return response;
    } else {
      print("Loading from API");
      var response = await http.get(Uri.parse(API_URL));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var tempDir = await getTemporaryDirectory();
        File file = new File(tempDir.path + "/" + filename);
        file.writeAsString(jsonResponse, flush: true, mode: FileMode.write);

        return jsonResponse;
      }
    }
  }
}
