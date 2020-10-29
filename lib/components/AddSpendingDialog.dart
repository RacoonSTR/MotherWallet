import 'package:flutter/material.dart';

class AddSpendingDalog extends StatefulWidget {
  @override
  _AddSpendingDalogState createState() => _AddSpendingDalogState();
}

class _AddSpendingDalogState extends State<AddSpendingDalog> {
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Spending'),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'How much did you spend',
                labelText: 'Count *',
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                RegExp regExp = RegExp(r"^[0-9]+(.[0-9]+)?$", multiLine: true);
                if (value.isEmpty) {
                  return 'Please enter count';
                }
                if (!regExp.hasMatch(value)) {
                  return 'Invalid value';
                }
                return null;
              },
            ),
            InputDatePickerFormField(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now(),
            )
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.red,
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('Add'),
        ),
      ],
    );
  }
}
