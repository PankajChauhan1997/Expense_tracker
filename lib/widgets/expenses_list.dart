import 'package:flutter/material.dart';

import '../models/expenseModel.dart';
import 'expenses_List/expenses_items.dart';

class expense_list extends StatelessWidget {
   expense_list({Key? key,required this.expenses}) : super(key: key);
  final List<ExpenseData> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount:expenses.length,itemBuilder: (context,index) =>
    Expense_item(expenses[index])
    );
  }
}
