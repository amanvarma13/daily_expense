import 'package:daily_expenses/modules/reminder_notification_screen/reminder_screen/reminder_list_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../Core/app_colors.dart';
import '../../../Core/app_dimen.dart';
import '../../../core/app_text_styles.dart';
import '../expenses_bloc/expenses_bloc.dart';
import '../expenses_bloc/expenses_events.dart';
import '../expenses_bloc/expenses_states.dart';
import '../expenses_model/expenses_model.dart';
import 'add_expenses_screen.dart';
import 'edit_expenses_screen.dart';

class ExpenseListScreen extends StatelessWidget {
  ExpenseListScreen({super.key});
  final ValueNotifier<DateTime> _selectedMonth = ValueNotifier<DateTime>(DateTime.now());

  void _incrementMonth() {
    _selectedMonth.value = DateTime(_selectedMonth.value.year, _selectedMonth.value.month + 1);
  }

  void _decrementMonth() {
    _selectedMonth.value = DateTime(_selectedMonth.value.year, _selectedMonth.value.month - 1);
  }

  List<ExpensesModel> _filterExpensesByMonth(List<ExpensesModel> expenses, DateTime month) {
    return expenses.where((expense) {
      return expense.date.year == month.year && expense.date.month == month.month;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    context.read<ExpensesBloc>().add(LoadExpenses());

    return Scaffold(
      appBar: AppBar(title: Text('Expenses',
        style: AppTextStyles().bold5TextStyle(
          fontSize: MediaQuery.of(context).size.width*0.06,
          textColor: AppColors().black1,
        ),
      ),
        actions: [
          PopupMenuButton<int>(
            onSelected: (item) => _onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(value: 0, child: Text('Reminders',
                style: AppTextStyles().bold5TextStyle(
                  fontSize: MediaQuery.of(context).size.width*0.04,
                  textColor: AppColors().black1,
                ),
              )),
            ],
          ),
        ],
      ),
      body: BlocBuilder<ExpensesBloc, ExpensesState>(
        builder: (context, state) {
          if (state.expenses.isEmpty) {
            return Center(child: Text('No expenses added yet.',
              style: AppTextStyles().bold5TextStyle(
                fontSize: MediaQuery.of(context).size.width*0.045,
                textColor: AppColors().black1,
              ),
            ));
          }
          return ValueListenableBuilder<DateTime>(
            valueListenable: _selectedMonth,
            builder: (context, value, _) {
              final filteredExpenses = _filterExpensesByMonth(state.expenses, value);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: _decrementMonth,
                      ),
                      GestureDetector(
                        child: Text(
                          DateFormat('MMMM yyyy').format(value),
                          style: AppTextStyles().bold5TextStyle(
                            fontSize: MediaQuery.of(context).size.width*0.05,
                            textColor: AppColors().black1,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward),
                        onPressed: _incrementMonth,
                      ),
                    ],
                  ),
                  Text(
                    "Expenses for ${DateFormat('MMMM yyyy').format(value)}",
                    style: AppTextStyles().bold5TextStyle(
                      fontSize: MediaQuery.of(context).size.width*0.05,
                      textColor: AppColors().black1,
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredExpenses.length,
                      itemBuilder: (context, index) {
                        final expense = filteredExpenses[index];
                        return Container(
                          margin: EdgeInsets.only(
                            left: AppDimen.margin3,
                            right: AppDimen.margin3,
                            bottom: AppDimen.margin1
                          ),
                          decoration: BoxDecoration(
                            color: AppColors().grey3,
                            borderRadius: BorderRadius.all(Radius.circular(AppDimen.circular15))
                          ),
                          child: ListTile(
                            title: Text(expense.note),
                            subtitle: Text(DateFormat('dd-MM-yyyy').format(expense.date)),
                            trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditExpenseScreen(expense: expense),
                              ));
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddExpenseScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  void _onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
          ReminderListScreen()));
        break;
    }
  }
}

