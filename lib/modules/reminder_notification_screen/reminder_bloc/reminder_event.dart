import 'package:equatable/equatable.dart';
import '../reminder_model/reminder.dart';

abstract class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object> get props => [];
}

class LoadReminders extends ReminderEvent {}

class AddReminder extends ReminderEvent {
  final Reminder reminder;

  const AddReminder(this.reminder);

  @override
  List<Object> get props => [reminder];
}

class EditReminder extends ReminderEvent {
  final Reminder reminder;

  const EditReminder(this.reminder);

  @override
  List<Object> get props => [reminder];
}

class RemoveReminder extends ReminderEvent {
  final Reminder reminder;

  const RemoveReminder(this.reminder);

  @override
  List<Object> get props => [reminder];
}
