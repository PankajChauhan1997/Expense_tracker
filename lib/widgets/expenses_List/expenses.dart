import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../expenses_list.dart';
import '../../models/expenseModel.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() {
    return _ExpnsesState();
  }
}
TextEditingController ExpTitle=TextEditingController();
TextEditingController ExpAmt=TextEditingController();
DateTime? selectedDate;
Category selectedCategory=Category.leisure;

class _ExpnsesState extends State<Expenses>{
  final List<ExpenseData> _registeredExpenses=[
    ExpenseData(title: 'Burger and Pizza',amount:19.99, date: DateTime.now(), category: Category.food,),
    ExpenseData(title: 'Cinema',amount:120.9, date: DateTime.now(), category: Category.leisure,),
  ];

  void getDatePicker()async{
    final now=DateTime.now();
    final firstDate=DateTime(1997,now.month,now.day);
    selectedDate=await showDatePicker(context: context,initialDate:now,
        firstDate:firstDate , lastDate: now);
    print("seeenffnfr;;;;;;......${selectedDate}");
  }
  @override
  void dispose(){
    ExpTitle.dispose();
    ExpAmt.dispose();
    super.dispose();
  }

  @override
  void _addExpenses(){
    showModalBottomSheet(context: context,
        builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column( crossAxisAlignment:CrossAxisAlignment.start,
            children:[

          TextField(controller:ExpTitle,
              maxLength:50,
              decoration:InputDecoration(label:Text("Title"))),
          Row(
            children: [
              Flexible(
                child: TextField(controller:ExpAmt,keyboardType:TextInputType.number,
                    decoration:InputDecoration(label:Text("Amount",),prefixText:"₹",)),
              ),
              SizedBox(width:16),
              Flexible(
                child: InkWell(onTap:getDatePicker,
                    child: Row(
                        crossAxisAlignment:CrossAxisAlignment.end,
                        mainAxisAlignment:MainAxisAlignment.end,
                    children:[
                  Padding(
                    padding: const EdgeInsets.only(right:20.0),
                    child: Text('${selectedDate!=null?formatter.format(selectedDate!):"selectedDate"}'),
                  ),
                    Icon(Icons.calendar_month),
                ])),
              )
            ],
          ),
        DropdownButton(
          value:selectedCategory,
          items: Category.values.map((category)=>
              DropdownMenuItem(
          value:category,
            child:
        Text(category.name.toUpperCase()))).toList(),
          onChanged: (value) {
          if(value==null){
            return;
          }
          setState((){
            selectedCategory=value;
          });
          },),
          Row(
            crossAxisAlignment:CrossAxisAlignment.center,
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed:(){
                print("${ExpTitle.text}");
                print("${ExpAmt.text}");
                print("${selectedDate}");
                ExpTitle.clear();
                ExpAmt.clear();
              },child:Text('Save')),

              ElevatedButton(onPressed:(){
                Navigator.of(context).pop();
              },child:Text('Cancel')),
            ],
          )
          // ])
        ]),
      );
        });

  }
@override
  Widget build(BuildContext context){
  return Scaffold(appBar:AppBar(title:Text("Expense Tracker"),actions:[
    IconButton(icon:Icon(Icons.add),onPressed:_addExpenses),
  ]),
      body:Center(child:Column(
    crossAxisAlignment:CrossAxisAlignment.center,
    mainAxisAlignment:MainAxisAlignment.center,
    children: [

      Flexible(child: expense_list(expenses: _registeredExpenses,)),
    ],
  )));
}
  }

