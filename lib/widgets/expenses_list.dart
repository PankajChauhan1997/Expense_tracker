import 'package:flutter/material.dart';

import '../models/expenseModel.dart';
import 'expenses_List/expenses.dart';
import 'expenses_List/expenses_items.dart';

class ExpenseList extends StatelessWidget {
  ExpenseList({Key? key,required this.expenses,required this.onremove}) : super(key: key);
  final List<ExpenseData> expenses;
  final void Function(ExpenseData expense) onremove;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount:expenses.length,itemBuilder: (context,index) =>
    Dismissible(key: ValueKey(expenses[index]),background:Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color:Theme.of(context).colorScheme.error),
    ),//Colors.red),
        onDismissed:(direction){
      onremove(expenses[index]);
    },
    child: Expense_item(expenses[index],))
    );
  }
}
