import 'package:flutter/material.dart';

import '../../models/expenseModel.dart';

class Expense_item extends StatelessWidget {
  const Expense_item(this.expense,{Key? key,}) : super(key: key);

  final ExpenseData expense;
  @override
  Widget build(BuildContext context) {
    return Card(color:Colors.purple[100],
        child:Padding(
      padding: const EdgeInsets.symmetric(horizontal:20,vertical:16),
      child: Column(crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text(expense.title,style:TextStyle(fontWeight:FontWeight.bold,fontSize:16)),
          SizedBox(height:4),
          Row(children:[
            Text("\$${expense.amount.toStringAsFixed(2)}"),
            const Spacer(),
            Row(children:[
              Icon(categoryIcons[expense.category]),
              SizedBox(width:8),
              Text(expense.formattedDate),
            ])
          ])
        ],
      ),
    ));
  }
}
