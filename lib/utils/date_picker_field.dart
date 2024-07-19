import 'package:daily_expenses/core/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Core/app_colors.dart';

class DatePickerField extends StatelessWidget {
  final TextEditingController dateController;
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateSelected;

  const DatePickerField({super.key,
    required this.dateController,
    required this.initialDate,
    required this.onDateSelected,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      onDateSelected(picked);
      dateController.text = DateFormat('dd-MM-yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: AppTextStyles().bold5TextStyle(
        textColor: AppColors().black1,
        fontSize: MediaQuery.of(context).size.width*0.05
      ),
      controller: dateController,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
      ),
      readOnly: true,
    );
  }
}
