import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/db_test.dart';

class Datapage extends StatefulWidget {
  var futurealbum;

  Datapage(this.futurealbum);

  @override
  _DatapageState createState() => _DatapageState();
}

class _DatapageState extends State<Datapage> {
  var database;
  var fido = Bookmark(
    id: 0,
    image: 'Fido',
    date: 'sdgs',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Data Page', style: TextStyle(color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.bookmark,
              color: Colors.black,
            ),
            onPressed: () async {
              database = await DbManager().main2();
              await DbManager().insertbookmark(
                  database,
                  Bookmark(
                    id: widget.futurealbum['id'],
                    image: widget.futurealbum['jetpack_featured_media_url'],
                    date: widget.futurealbum['date'].toString(),
                  ));
              Fluttertoast.showToast(
                msg: "Added to Bookmarks",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
              );
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              widget.futurealbum['id'].toString(),
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            CachedNetworkImage(
                imageUrl: widget.futurealbum['jetpack_featured_media_url']),
            Text(
              widget.futurealbum['date'].toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              widget.futurealbum['status'].toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              widget.futurealbum['title']['rendered'].toString(),
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            Text(
              widget.futurealbum.length.toString(),
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
