import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../Core/app_colors.dart';
import '../../../Core/app_dimen.dart';
import '../../../core/app_decoration.dart';
import '../../../core/app_text_styles.dart';
import '../../../utils/date_picker_field.dart';
import '../expenses_bloc/expenses_bloc.dart';
import '../expenses_bloc/expenses_events.dart';
import '../expenses_model/expenses_model.dart';

class EditExpenseScreen extends StatelessWidget {
  final ExpensesModel expense;
  EditExpenseScreen({super.key, required this.expense});
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _noteController.text = expense.note;
    _amountController.text = expense.amount.toString();
    _dateController.text = DateFormat('dd-MM-yyyy').format(expense.date);
    final DateTime selectedDate = expense.date;

    return Scaffold(
      appBar: AppBar(title: Text('Edit Expense',
        style: AppTextStyles().bold5TextStyle(
          fontSize: MediaQuery.of(context).size.width*0.06,
          textColor: AppColors().black1),
        )
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(AppDimen.margin4),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.05),
              TextField(
                controller: _noteController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: AppTextStyles().bold5TextStyle(
                  textColor: AppColors().black1,
                  fontSize: MediaQuery.of(context).size.width*0.05
                ),
                decoration: AppDecoration.textFieldInputDecoration("Note", context),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                style: AppTextStyles().bold5TextStyle(
                  textColor: AppColors().black1,
                  fontSize: MediaQuery.of(context).size.width*0.05
                ),
                decoration: AppDecoration.textFieldInputDecoration("Amount", context),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
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
                  initialDate: selectedDate,
                  onDateSelected: (date) {
                    _dateController.text = DateFormat('dd-MM-yyyy').format(date);
                  },
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.1),

              InkWell(
                onTap: (){
                  final String note = _noteController.text;
                  final double amount = double.parse(_amountController.text);
                  final DateTime date = DateFormat('dd-MM-yyyy').parse(_dateController.text);
                  final updatedExpense = ExpensesModel(
                    id: expense.id,
                    note: note,
                    amount: amount,
                    date: date,
                  );
                  context.read<ExpensesBloc>().add(EditExpense(expense, updatedExpense));
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(AppDimen.padding2),
                  decoration: BoxDecoration(
                    color: AppColors().green3,
                    borderRadius: BorderRadius.circular(AppDimen.circular30)
                  ),
                  child: Text("Update Expense",
                    style: AppTextStyles().bold6TextStyle(
                      fontSize: MediaQuery.of(context).size.width*0.055,
                      textColor: AppColors().white
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.02,),
              InkWell(
                onTap: (){
                  context.read<ExpensesBloc>().add(RemoveExpense(expense));
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width*0.8,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(AppDimen.padding2),
                  decoration: BoxDecoration(
                    color: AppColors().red2,
                    borderRadius: BorderRadius.circular(AppDimen.circular30)
                  ),
                  child: Text("Remove Expense",
                    style: AppTextStyles().bold6TextStyle(
                      fontSize: MediaQuery.of(context).size.width*0.055,
                      textColor: AppColors().white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
