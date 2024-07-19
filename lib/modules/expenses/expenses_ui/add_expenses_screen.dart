import 'package:daily_expenses/Core/app_colors.dart';
import 'package:daily_expenses/core/app_decoration.dart';
import 'package:daily_expenses/core/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../Core/app_dimen.dart';
import '../../../utils/date_picker_field.dart';
import '../expenses_bloc/expenses_bloc.dart';
import '../expenses_bloc/expenses_events.dart';
import '../expenses_model/expenses_model.dart';

class AddExpenseScreen extends StatelessWidget {
  AddExpenseScreen({super.key});
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final DateTime _selectedDate = DateTime.now();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _dateController.text = DateFormat('dd-MM-yyyy').format(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Expense',
          style: AppTextStyles().bold5TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.06,
            textColor: AppColors().black1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(AppDimen.margin4),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                TextFormField(
                  controller: _noteController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: AppDecoration.textFieldInputDecoration("Note", context),
                  style: AppTextStyles().bold5TextStyle(
                    textColor: AppColors().black1,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a note';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                TextFormField(
                  controller: _amountController,
                  decoration: AppDecoration.textFieldInputDecoration("Amount", context),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  style: AppTextStyles().bold5TextStyle(
                    textColor: AppColors().black1,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    try {
                      double.parse(value);
                    } catch (e) {
                      return 'Please enter a valid amount';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                  padding: EdgeInsets.only(
                    left: AppDimen.padding2,
                    right: AppDimen.padding1,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors().black1, width: 2.0),
                    borderRadius: BorderRadius.circular(AppDimen.circular10),
                  ),
                  child: DatePickerField(
                    dateController: _dateController,
                    initialDate: _selectedDate,
                    onDateSelected: (date) {
                      _dateController.text = DateFormat('dd-MM-yyyy').format(date);
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final String note = _noteController.text;
                      final double amount = double.parse(_amountController.text);
                      final DateTime date = DateFormat('dd-MM-yyyy').parse(_dateController.text);
                      final expense = ExpensesModel(note: note, amount: amount, date: date);
                      context.read<ExpensesBloc>().add(AddExpense(expense));
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(AppDimen.padding2),
                    decoration: BoxDecoration(
                      color: AppColors().green3,
                      borderRadius: BorderRadius.circular(AppDimen.circular30),
                    ),
                    child: Text(
                      "Add Expense",
                      style: AppTextStyles().bold6TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.055,
                        textColor: AppColors().white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
