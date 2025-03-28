import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final uuid=  Uuid();
enum Category {food,travel,leisure,work}
const categoryIcons= {
  Category.food:Icons.lunch_dining,
  Category.travel:Icons.flight_takeoff,
  Category.leisure:Icons.movie,
  Category.work:Icons.work,
};
final formatter=DateFormat.yMd();

class ExpenseData{
ExpenseData({
  required this.title,
  required this.amount,
  required this.date,
  required this.category,

}
):id=uuid.v4();
final String id;
final String title;
final double amount;
final DateTime date;
final Category category;

String get formattedDate {
return formatter.format(date);
}
}
class ExpenseBucket{
  ExpenseBucket({required this.category,required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseData>allExpenses,this.category):
        expenses=allExpenses.where((expense)=>expense.category==category).toList();
  final Category category;
  final List<ExpenseData>expenses;

  double get totalExpenses{
    double sum=0;
     for(final expense in expenses){
       sum+=expense.amount;
     }
     return sum;
  }
}