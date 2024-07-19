import 'package:daily_expenses/modules/reminder_notification_screen/reminder_bloc/reminder_event.dart';
import 'package:daily_expenses/modules/reminder_notification_screen/reminder_bloc/reminder_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../database/database_helper.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  ReminderBloc() : super(ReminderState([])) {
    on<LoadReminders>(_onLoadReminders);
    on<AddReminder>(_onAddReminder);
    on<EditReminder>(_onEditReminder);
    on<RemoveReminder>(_onRemoveReminder);
  }

  Future<void> _onLoadReminders(LoadReminders event, Emitter<ReminderState> emit) async {
    final reminders = await _databaseHelper.getReminders();
    emit(ReminderState(reminders));
  }

  Future<void> _onAddReminder(AddReminder event, Emitter<ReminderState> emit) async {
    await _databaseHelper.insertReminder(event.reminder);
    final reminders = await _databaseHelper.getReminders();
    emit(ReminderState(reminders));
  }

  Future<void> _onEditReminder(EditReminder event, Emitter<ReminderState> emit) async {
    await _databaseHelper.updateReminder(event.reminder);
    final reminders = await _databaseHelper.getReminders();
    emit(ReminderState(reminders));
  }

  Future<void> _onRemoveReminder(RemoveReminder event, Emitter<ReminderState> emit) async {
    await _databaseHelper.deleteReminder(event.reminder.id!);
    final reminders = await _databaseHelper.getReminders();
    emit(ReminderState(reminders));
  }
}
