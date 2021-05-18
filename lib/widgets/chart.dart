import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import './chart_bars.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransction;
  Chart(this.recentTransction);

  List<Map<String, Object>> get allTransactionDetails {
    return List.generate(7, (index) {
      final weedDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;

      for (int i = 0; i < recentTransction.length; i++) {
        if (recentTransction[i].date.day == weedDay.day &&
            recentTransction[i].date.month == weedDay.month &&
            recentTransction[i].date.year == weedDay.year) {
          totalSum += recentTransction[i].amount;
        }
      }

      return {'Day': DateFormat.E().format(weedDay), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return allTransactionDetails.fold(0.0, (sum, tx) {
      return sum + tx['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          children: allTransactionDetails.map((tx) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBars(
                tx['Day'],
                tx['amount'],
                totalSpending == 0
                    ? 0.0
                    : (tx['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
