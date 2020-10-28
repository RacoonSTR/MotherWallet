import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Widget buildPaddingText(String text,
      {double padding = 5.0, double fontSize = 30}) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Some text here'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
            type: MaterialType.card,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    buildPaddingText('Your wallet'),
                    buildPaddingText('9999', fontSize: 48),
                  ]),
                  Container(
                    child: Column(
                      children: [
                        buildPaddingText('Today earned', fontSize: 18),
                        buildPaddingText('150'),
                        buildPaddingText('Today spended', fontSize: 18),
                        buildPaddingText('100'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Material(
            type: MaterialType.card,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Maybe some charts here :)\n I dunno, huh...',
                  style: TextStyle(fontSize: 24),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
