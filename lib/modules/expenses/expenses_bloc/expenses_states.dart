import 'package:equatable/equatable.dart';

import '../expenses_model/expenses_model.dart';

class ExpensesState extends Equatable {
  final List<ExpensesModel> expenses;

  const ExpensesState(this.expenses);

  @override
  List<Object> get props => [expenses];
}
