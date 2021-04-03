import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/db_test.dart';

class BookmarkPage extends StatefulWidget {
  @override
  _BookmarkPageState createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage>
    with TickerProviderStateMixin {
  var db;
  late bool loading;
  late AnimationController controller;
  getbookmarks() async {
    db = await DbManager().main2();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
    loading = true;
    getbookmarks();
  }

  @override
  Widget build(BuildContext context) {
    if (loading == false) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Bookmarks'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onPressed: () {
                DbManager().deleteBM(db, 0);
              },
            )
          ],
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
