import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import '../../models/expenseModel.dart';
import '../chart/chart.dart';
import '../expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseData> _registeredExpenses = [];
  TextEditingController expTitle = TextEditingController();
  TextEditingController expAmt = TextEditingController();
  DateTime? selectedDate;
  Category selectedCategory = Category.leisure;

  @override
  void initState() {
    super.initState();
    // _loadExpenses(); // Load expenses on startup
  }

  @override
  void dispose() {
    expTitle.dispose();
    expAmt.dispose();
    super.dispose();
  }



  // Function to submit expense
  void submitExpense() {
    final amt = double.tryParse(expAmt.text);
    if (expTitle.text.trim().isEmpty || amt == null || amt <= 0 || selectedDate == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text("Invalid input"),
          content: const Text("Please fill all the required data!!!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Ok"),
            ),
          ],
        ),
      );
      return;
    }

    setState(() {
      _registeredExpenses.add(
        ExpenseData(title: expTitle.text, amount: amt, date: selectedDate!, category: selectedCategory),
      );

    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Success'),backgroundColor:Colors.green,));

    // _saveExpenses(); // Save to local storage

    Navigator.pop(context);
    expTitle.clear();
    expAmt.clear();
    selectedDate = null;
  }
  void _addExpenses() {
    final keyboardSpace=MediaQuery.of(context).viewInsets.bottom;
    showModalBottomSheet(
      context: context,
      useSafeArea : true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        Category modalCategory = selectedCategory;
        DateTime? modalSelectedDate = selectedDate; // Local state for modal
        return StatefulBuilder(
            builder: (BuildContext modalContext, StateSetter setModalState) {
              return SizedBox(
                height: double.infinity,//MediaQuery.of(context).size.height, // Full screen height
                width: double.infinity,//MediaQuery.of(context).size.height, // Full screen height
                child: SingleChildScrollView(
                  child: Padding(
                    padding:  EdgeInsets.fromLTRB(16.0, 48, 16,keyboardSpace+16,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: expTitle,
                          maxLength: 50,
                          decoration: const InputDecoration(labelText: "Title"),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: TextField(
                                controller: expAmt,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    labelText: "Amount", prefixText: "₹"),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Flexible(
                              child: InkWell(
                                onTap: () async {
                                  final pickedDate = await showDatePicker(
                                    context: modalContext,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1997, DateTime.now().month, DateTime.now().day),
                                    lastDate: DateTime.now(),
                                  );
                                  if (pickedDate != null) {
                                    setModalState(() {
                                      modalSelectedDate = pickedDate;
                                    });
                                    // Update the main state's selectedDate
                                    setState(() {
                                      selectedDate = pickedDate;
                                    });
                                  }
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 20.0),
                                      child: Text(
                                          '${modalSelectedDate != null
                                              ? formatter.format(modalSelectedDate!)
                                              : "Select Date"}'),
                                    ),
                                    const Icon(Icons.calendar_month),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        DropdownButton<Category>(
                          value: modalCategory, // Use modal state
                          onChanged: (Category? newValue) {
                            if (newValue != null) {
                              setModalState(() {
                                modalCategory = newValue; // Update inside modal state
                              });
                              // Update the main state's selectedCategory
                              setState(() {
                                selectedCategory = newValue;
                              });
                              print("Selected in modal: $modalCategory");
                            }
                          },
                          items: Category.values.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()),
                            );
                          }).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                                onPressed: submitExpense, child: const Text('Save')),
                            ElevatedButton(onPressed: () =>
                                Navigator.of(context).pop(), child: const Text('Cancel')),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
  void _removeExpenses(ExpenseData expense){
    final expIndex=_registeredExpenses.indexOf(expense);
    setState((){
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(duration:Duration(seconds:3),backgroundColor:Colors.red,
            content:Text("Expense Deleted"),action:SnackBarAction(label: 'Undo', onPressed: () {
              setState((){
                _registeredExpenses.insert(expIndex,expense);

              });
            },)));
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: _addExpenses)],
      ),
      body: _registeredExpenses.isEmpty
          ? Center(
            child: const Text(
                    "Please add some data",
                    style: TextStyle(fontSize: 16),
                  ),
          )
          :Center(child:
      width < 600?
        Column(
          children: [
            Chart(expenses: _registeredExpenses),
            Expanded(child: ExpenseList(expenses: _registeredExpenses, onremove: _removeExpenses)),
          ],
        ): Row(
        children: [
          Expanded(child:Chart(expenses: _registeredExpenses)),
          Expanded(child: ExpenseList(expenses: _registeredExpenses, onremove: _removeExpenses)),
        ],
      ),
      ),
    );
  }
}