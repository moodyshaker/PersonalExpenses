import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:provider/provider.dart';
import 'check_email.dart';
import 'home.dart';

class Splash extends StatefulWidget {
  static const String id = 'SPLASH';

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    AppLogic logic = Provider.of<AppLogic>(context, listen: false);
    logic.initAuth();
    logic.initSharedPref();
    Future.delayed(Duration(seconds: 2), () {
      logic.isFirstTime()
          ? Navigator.pushReplacementNamed(context, CheckEmail.id)
          : Navigator.pushReplacementNamed(context, Home.id);
    });
    _controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Opacity(
          opacity: _controller.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/wallet.png',
                width: 200,
                height: 200,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 50.0,
              ),
              const Text(
                'Expenses Tracker',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
