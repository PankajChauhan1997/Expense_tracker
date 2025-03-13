import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/expenseModel.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() {
    return _ExpnsesState();
  }
}
class _ExpnsesState extends State<Expenses>{
  final List<ExpenseData> _registeredExpenses=[
    ExpenseData(title: 'Fltter course',amount:19.99, date: DateTime.now(), category: Category.food,),
    ExpenseData(title: 'Fuel',amount:120.9, date: DateTime.now(), category: Category.leisure,),
  ];
  
@override
  Widget build(BuildContext context){
  return Scaffold(body:Center(child:Text("Pankaj")));
}
  }

