import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/adaptive_button.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTrx;

  NewTransaction({Key? key, required this.addTrx});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTrx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year - 1),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                        decoration: InputDecoration(labelText: 'Title'),
                        controller: _titleController,
                        onSubmitted: (_) => _submitData()),
                    TextField(
                        decoration: InputDecoration(labelText: 'Amount'),
                        controller: _amountController,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        onSubmitted: (_) => _submitData()),
                    Container(
                      height: 70,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Text(_selectedDate == null
                                  ? 'No Date Chosen!'
                                  : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}')),
                          AdaptiveFlatButton(
                              text: 'Choose Date', handler: _presentDatePicker)
                        ],
                      ),
                    ),
                    ElevatedButton(
                        child: Text('Add Transaction'),
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            onPrimary:
                                Theme.of(context).textTheme.button?.color),
                        onPressed: _submitData)
                  ]))),
    );
  }
}
