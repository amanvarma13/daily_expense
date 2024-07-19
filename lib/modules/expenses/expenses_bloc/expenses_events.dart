import 'package:equatable/equatable.dart';
import '../expenses_model/expenses_model.dart';

abstract class ExpensesEvent extends Equatable {
  const ExpensesEvent();
  @override
  List<Object> get props => [];
}

class LoadExpenses extends ExpensesEvent {}

class AddExpense extends ExpensesEvent {
  final ExpensesModel expense;
  const AddExpense(this.expense);
  @override
  List<Object> get props => [expense];
}

class EditExpense extends ExpensesEvent {
  final ExpensesModel oldExpense;
  final ExpensesModel newExpense;
  const EditExpense(this.oldExpense, this.newExpense);
  @override
  List<Object> get props => [oldExpense, newExpense];
}

class RemoveExpense extends ExpensesEvent {
  final ExpensesModel expense;
  const RemoveExpense(this.expense);
  @override
  List<Object> get props => [expense];
}
