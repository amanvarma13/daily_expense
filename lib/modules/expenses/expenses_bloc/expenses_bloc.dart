import '../../../database/database_helper.dart';
import 'package:bloc/bloc.dart';
import 'expenses_events.dart';
import 'expenses_states.dart';

class ExpensesBloc extends Bloc<ExpensesEvent, ExpensesState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  ExpensesBloc() : super(ExpensesState([])) {
    on<LoadExpenses>(_onLoadExpenses);
    on<AddExpense>(_onAddExpense);
    on<EditExpense>(_onEditExpense);
    on<RemoveExpense>(_onRemoveExpense);
  }

  Future<void> _onLoadExpenses(LoadExpenses event, Emitter<ExpensesState> emit) async {
    final expenses = await _databaseHelper.getExpenses();
    emit(ExpensesState(expenses));
  }

  Future<void> _onAddExpense(AddExpense event, Emitter<ExpensesState> emit) async {
    await _databaseHelper.insertExpense(event.expense);
    final expenses = await _databaseHelper.getExpenses();
    emit(ExpensesState(expenses));
  }

  Future<void> _onEditExpense(EditExpense event, Emitter<ExpensesState> emit) async {
    await _databaseHelper.updateExpense(event.newExpense);
    final expenses = await _databaseHelper.getExpenses();
    emit(ExpensesState(expenses));
  }

  Future<void> _onRemoveExpense(RemoveExpense event, Emitter<ExpensesState> emit) async {
    await _databaseHelper.deleteExpense(event.expense.id!);
    final expenses = await _databaseHelper.getExpenses();
    emit(ExpensesState(expenses));
  }
}
