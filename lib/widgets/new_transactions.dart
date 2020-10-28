import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime datePicked;

  void getDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then(
      (value) {
        setState(
          () {
            datePicked = value;
          },
        );
      },
    );
  }

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredAmount == null) {
      return;
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0 || datePicked == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      datePicked,
    );

    Navigator.pop(context);
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
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitData(),
                // onChanged: (val) {
                //   titleInput = val;
                // },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
                // onChanged: (val) => amountInput = val,
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      datePicked == null
                          ? 'No date picked'
                          : DateFormat().add_yMd().format(datePicked),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  FlatButton(
                      onPressed: getDatePicker,
                      child: Text(
                        'CHOOSE DATE',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('Add Transaction'),
                textColor: Colors.white,
                onPressed: submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
