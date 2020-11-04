import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mother_wallet/components/AddSpendingDialog.dart';
import 'package:mother_wallet/db/models/Pay.dart';
import 'package:mother_wallet/db/providers/PayProvider.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime _date;
  int _wallet;
  int _daylyPay;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
    this._date = DateTime.now();
    _loadData();
  }

  _loadData() async {
    this.setState(() {
      this._isLoading = true;
    });
    await _loadWallet();
    await _loadDailyPaid();
    this.setState(() {
      this._isLoading = false;
    });
  }

  _loadWallet() async {
    DateTime firstDayOfMounth = DateTime(this._date.year, this._date.month);

    int wallet = await PayProvider().getPayment(firstDayOfMounth, this._date);
    this.setState(() {
      this._wallet = wallet;
    });
  }

  _loadDailyPaid() async {
    Pay daylyPaid = await PayProvider().getPayByDate(this._date);
    this.setState(() {
      if (daylyPaid != null) {
        this._daylyPay = daylyPaid.value;
      } else {
        this._daylyPay = null;
      }
    });
  }

  bool _isCurrentDate() {
    return DateTime.now().difference(_date).inDays == 0;
  }

  void _changeDate(int days) {
    this.setState(() {
      if (days > 0) {
        this._date = this._date.add(
              Duration(days: days),
            );
      } else {
        this._date = this._date.subtract(
              Duration(days: -1 * days),
            );
      }
    });
    _loadData();
  }

  Widget _buildPaddingText(String text,
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

  Widget _buildCard({Widget child}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Material(
        type: MaterialType.card,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: child,
      ),
    );
  }

  Widget _buildArrows({Icon icon, Function onPressed}) {
    return SizedBox(
      height: 20,
      width: 20,
      child: IconButton(
        padding: new EdgeInsets.all(0.0),
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }

  Widget _buildData() {
    if (this._daylyPay == null) {
      return _buildCard(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Text(
            'We do not have data for this date',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return Column(
      children: [
        _buildCard(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(children: [
                  _buildPaddingText('Your wallet'),
                  _buildPaddingText(this._wallet.toString(), fontSize: 48),
                ]),
                Container(
                  child: Column(
                    children: [
                      _buildPaddingText('Today earned', fontSize: 18),
                      _buildPaddingText(_daylyPay.toString()),
                      _buildPaddingText('Today spended', fontSize: 18),
                      _buildPaddingText('0'),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        _buildCard(
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
            _buildCard(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildArrows(
                      icon: Icon(Icons.keyboard_arrow_left),
                      onPressed: () => _changeDate(-1),
                    ),
                    _buildPaddingText(
                        DateFormat('EEEE, MMMM dd').format(
                          _date,
                        ),
                        fontSize: 24),
                    _buildArrows(
                      icon: Icon(Icons.keyboard_arrow_right),
                      onPressed: _isCurrentDate() ? null : () => _changeDate(1),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20),
              ),
            ),
            this._isLoading
                ? Container(
                    height: 20,
                    child: LinearProgressIndicator(),
                  )
                : _buildData()
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
