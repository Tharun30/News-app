import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/db_test.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  var db;

  getbookmarks() async {
    db = await DbManager().main2();
  }

  @override
  void initState() {
    super.initState();

    getbookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Of Employees'),
      ),
      body: FutureBuilder<List>(
        future: DbManager().bookmarks(db),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, int position) {
                    final item = snapshot.data![position];
                    //get your item data here ...
                    return Card(
                      child: ListTile(
                        title: CachedNetworkImage(
                          imageUrl: item.row[1],
                        ),
                        subtitle: Text(item.row[0].toString()),
                        trailing: Text(item.row[2].toString()),
                      ),
                    );
                  },
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
