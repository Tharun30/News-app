import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Row(
                  children: [
                    FlatButton(
                      onPressed: () {},
                      color: Colors.blueAccent,
                      child: Text('This is Button'),
                    ),
                    FlatButton(
                      onPressed: () {},
                      color: Colors.blueAccent,
                      child: Text('This is Button'),
                    ),
                    FlatButton(
                      onPressed: () {},
                      color: Colors.blueAccent,
                      child: Text('This is Button'),
                    ),
                    FlatButton(
                      onPressed: () {},
                      color: Colors.blueAccent,
                      child: Text('This is Button'),
                    ),
                  ],
                ),
              ),
              height: 100,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 124,
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return FlatButton(
                    onPressed: () {},
                    color: Colors.blueAccent,
                    child: Text('This is Button'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
