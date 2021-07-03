import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTrx;
  const TransactionList(
      {Key? key, required this.transactions, required this.deleteTrx})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text('No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(height: 10),
                Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png'))
              ],
            );
          })
        : ListView(
            children: transactions
                .map((trx) => TransactionItem(
                    key: ValueKey(trx.id),
                    transaction: trx,
                    deleteTrx: deleteTrx))
                .toList());
  }
}
