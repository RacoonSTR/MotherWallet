import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mother_wallet/components/AddSpendingDialog.dart';

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

  Widget buildCard({Widget child}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Material(
        type: MaterialType.card,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Some text here'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildCard(
              child: Container(
                padding: EdgeInsets.all(20),
                child: buildPaddingText(
                  DateFormat('EEEE, MMMM dd').format(
                    DateTime.now(),
                  ),
                ),
              ),
            ),
            buildCard(
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
            buildCard(
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddSpendingDalog();
            },
          );
        },
      ),
    );
  }
}
