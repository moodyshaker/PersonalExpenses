import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/screen/check_email.dart';
import 'package:provider/provider.dart';
import 'screen/chart.dart';
import 'screen/expenses_list.dart';
import 'screen/home.dart';
import 'screen/login.dart';
import 'screen/profile.dart';
import 'screen/registration.dart';
import 'screen/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppLogic(),
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Colors.purple,
          primarySwatch: Colors.purple,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: Splash.id,
        routes: {
          Splash.id: (context) => Splash(),
          Home.id: (context) => Home(),
          Login.id: (context) => Login(),
          Registration.id: (context) => Registration(),
          CheckEmail.id: (context) => CheckEmail(),
          Profile.id: (context) => Profile(),
          Chart.id: (context) => Chart(),
          ExpensesList.id: (context) => ExpensesList(),
        },
      ),
    );
  }
}
