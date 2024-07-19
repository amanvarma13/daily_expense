import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../Core/app_colors.dart';
import '../../../Core/app_dimen.dart';
import '../../../core/app_decoration.dart';
import '../../../core/app_text_styles.dart';
import '../../../utils/notification.dart';
import '../reminder_bloc/reminder_bloc.dart';
import '../reminder_bloc/reminder_event.dart';
import '../reminder_model/reminder.dart';

class AddReminderScreen extends StatelessWidget {
  AddReminderScreen({super.key});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ValueNotifier<DateTime> _selectedDateTime = ValueNotifier<DateTime>(DateTime.now());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime.value),
      );
      if (time != null) {
        _selectedDateTime.value = DateTime(date.year, date.month, date.day, time.hour, time.minute);
      }
    }
  }

  void _addReminder(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final title = _titleController.text.trim();
      final description = _descriptionController.text.trim();
      final reminder = Reminder(
        title: title,
        description: description,
        dateTime: _selectedDateTime.value,
      );
      context.read<ReminderBloc>().add(AddReminder(reminder));
      NotificationService().scheduleNotification(reminder);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Reminder',
          style: AppTextStyles().bold5TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.06,
            textColor: AppColors().black1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(AppDimen.margin3),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                TextFormField(
                  controller: _titleController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  style: AppTextStyles().bold5TextStyle(
                    textColor: AppColors().black1,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                  decoration: AppDecoration.textFieldInputDecoration("Title", context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                TextFormField(
                  controller: _descriptionController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  style: AppTextStyles().bold5TextStyle(
                    textColor: AppColors().black1,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                  decoration: AppDecoration.textFieldInputDecoration("Description", context),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Container(
                  padding: EdgeInsets.only(
                    left: AppDimen.padding2,
                    right: AppDimen.padding1,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors().black1, width: 2.0),
                    borderRadius: BorderRadius.circular(AppDimen.circular10),
                  ),
                  child: ValueListenableBuilder<DateTime>(
                    valueListenable: _selectedDateTime,
                    builder: (context, value, child) {
                      return ListTile(
                        title: Text(DateFormat('dd-MM-yyyy HH:mm').format(value)),
                        trailing: const Icon(Icons.calendar_today),
                        onTap: () => _pickDateTime(context),
                      );
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                InkWell(
                  onTap: () {
                    _addReminder(context);
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
                      "Add Reminder",
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


