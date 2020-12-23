import 'package:flutter/material.dart';

class AddSpendingDialog extends StatefulWidget {
  Function onAdd;

  AddSpendingDialog(this.onAdd);

  @override
  _AddSpendingDialogState createState() => _AddSpendingDialogState();
}

class _AddSpendingDialogState extends State<AddSpendingDialog> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();

  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Spending'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _valueController,
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
            /*InputDatePickerFormField(
              
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now(),
            )*/
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
          onPressed: () async {
            await widget.onAdd(
                int.parse(_valueController.text), DateTime.now());
            Navigator.of(context).pop();
          },
          textColor: Colors.blue,
          child: Text('Add'),
        ),
      ],
    );
  }
}
