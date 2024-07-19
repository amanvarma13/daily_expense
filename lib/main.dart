import 'package:daily_expenses/modules/expenses/expenses_bloc/expenses_bloc.dart';
import 'package:daily_expenses/modules/expenses/expenses_ui/expense_list_screen.dart';
import 'package:daily_expenses/modules/reminder_notification_screen/reminder_bloc/reminder_bloc.dart';
import 'package:daily_expenses/modules/reminder_notification_screen/reminder_screen/reminder_list_screen.dart';
import 'package:daily_expenses/utils/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'database/database_helper.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings("@mipmap/ic_launcher");
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await DatabaseHelper().database;
  await NotificationService().init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<ExpensesBloc>(
          create: (context) => ExpensesBloc(),
        ),
        BlocProvider<ReminderBloc>(
          create: (context) => ReminderBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: '/',
        routes: {
          '/': (context) => ExpenseListScreen(),
          '/reminder': (context) => ReminderListScreen(),
        },
      ),
    );
  }
}