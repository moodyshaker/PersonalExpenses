import 'dart:io';

import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/widgets/fab.dart';
import 'package:personal_expenses/widgets/home_tab.dart';
import 'package:personal_expenses/widgets/ios_add_icon.dart';
import 'package:personal_expenses/widgets/portarit_view.dart';
import 'package:personal_expenses/widgets/my_awesome_dialog.dart';
import 'package:personal_expenses/widgets/pop_widget.dart';
import 'package:personal_expenses/widgets/profile_icon.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  static const String id = 'HOME';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AppLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = Provider.of<AppLogic>(context, listen: false);
    _logic.initDatabase();
    _logic.getTransactionList(_logic.getUserId());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Consumer<AppLogic>(
      builder: (context, data, child) => PopScopeWidget(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            actions: [
              DeleteAllAction(
                data: data,
                isPortrait: mediaQuery.orientation == Orientation.portrait,
              ),
              if (Platform.isIOS)
                IosAdd(
                  isPortrait: mediaQuery.orientation == Orientation.portrait,
                  data: data,
                ),
            ],
            title: Row(
              children: [
                ProfileIcon(
                  logic: data,
                ),
                SizedBox(
                  width: 8.0,
                ),
                const Text('Personal Expenses'),
              ],
            ),
          ),
          body: mediaQuery.orientation == Orientation.landscape
              ? Column(
                  children: [
                    Row(
                      children: [
                        HomeTab(
                          onPress: (int i) {
                            print(i);
                            data.selectedTab(i);
                          },
                          selectedPage: data.selectedPage,
                          pageNumber: 0,
                          name: 'Expenses',
                        ),
                        HomeTab(
                          selectedPage: data.selectedPage,
                          pageNumber: 1,
                          name: 'Chart',
                          onPress: (int i) {
                            print(i);
                            data.selectedTab(i);
                          },
                        ),
                      ],
                    ),
                    data.getCurrent(data),
                  ],
                )
              : PortraitView(
                  data: data,
                ),
          floatingActionButton: Platform.isAndroid ? FAB() : Container(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }
}
