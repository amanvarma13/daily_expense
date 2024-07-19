import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../Core/app_colors.dart';
import '../../../Core/app_dimen.dart';
import '../../../core/app_text_styles.dart';
import '../reminder_bloc/reminder_bloc.dart';
import '../reminder_bloc/reminder_event.dart';
import '../reminder_bloc/reminder_state.dart';
import 'add_reminder_screen.dart';

class ReminderListScreen extends StatelessWidget {
  ReminderListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    context.read<ReminderBloc>().add(LoadReminders());

    return Scaffold(
      appBar: AppBar(title: Text('Reminders')),
      body: BlocBuilder<ReminderBloc, ReminderState>(
        builder: (context, state) {
          if (state.reminders.isEmpty) {
            return Center(child: Text('No reminders added yet.',
              style: AppTextStyles().bold5TextStyle(
                fontSize: MediaQuery.of(context).size.width*0.045,
                textColor: AppColors().black1,
              ),
            ));
          }

          return ListView.builder(
            itemCount: state.reminders.length,
            itemBuilder: (context, index) {
              final reminder = state.reminders[index];
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
                  title: Text(reminder.title),
                  subtitle: Text(DateFormat('dd-MM-yyyy HH:mm').format(reminder.dateTime)),
                  onTap: () {
                    // Handle edit reminder
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<ReminderBloc>().add(RemoveReminder(reminder));
                    },
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddReminderScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
