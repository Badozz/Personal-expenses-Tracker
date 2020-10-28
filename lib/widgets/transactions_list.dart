import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;

  TransactionList(this.transactions, this.deleteTransaction);
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text('No transactions added yet'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.7,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: FittedBox(
                          child: Text(
                            '\$${transactions[index].amount}',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      '${transactions[index].title}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    subtitle: Text(
                      DateFormat().add_yMMMd().format(transactions[index].date),
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? FlatButton.icon(
                            onPressed: () => deleteTransaction(
                              transactions[index].id,
                            ),
                            icon: Icon(
                              Icons.delete,
                              color: Colors.blue,
                            ),
                            label: Text('Delete'),
                          )
                        : IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.blue,
                            ),
                            onPressed: () => deleteTransaction(
                              transactions[index].id,
                            ),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
