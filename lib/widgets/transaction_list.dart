import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './txCard.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransaction;
  final Function toDeleteTrans;
  const TransactionList(this.userTransaction, this.toDeleteTrans);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 480,
      child: userTransaction.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraint) {
                return Column(
                  children: [
                    Text('No Transaction is added'),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: constraint.maxHeight * 0.6,
                      child: Image.asset(
                        'assets\images\waiting.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TxCard(
                    transaction: userTransaction[index],
                    toDeleteTrans: toDeleteTrans);
              },
              itemCount: userTransaction.length,
            ),
    );
  }
}
