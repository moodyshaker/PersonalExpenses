import 'package:flutter/material.dart';
import 'package:personal_expenses/app_logic/app_logic.dart';
import 'package:personal_expenses/model/transaction.dart';
import 'package:personal_expenses/widgets/custom_button.dart';
import 'package:personal_expenses/widgets/header.dart';
import 'package:personal_expenses/widgets/input_field.dart';
import 'package:provider/provider.dart';

class BottomSheetDialog extends StatefulWidget {
  final bool isUpdated;
  final TransactionModel model;

  BottomSheetDialog({@required this.isUpdated, this.model});

  @override
  _BottomSheetDialogState createState() => _BottomSheetDialogState();
}

class _BottomSheetDialogState extends State<BottomSheetDialog> {
  bool _dateHasFocus = false;
  bool _titleHasFocus = false;
  bool _amountHasFocus = false;
  FocusNode _dateFocusNode;
  FocusNode _titleFocusNode;
  FocusNode _amountFocusNode;
  AppLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = Provider.of<AppLogic>(context, listen: false);
    _logic.initBottomSheetControllers();
    if (widget.isUpdated) {
      _logic.setCurrentDate(widget.model.date);
      _logic.titleController.text = widget.model.title;
      _logic.amountController.text = widget.model.amount.toString();
    } else {
      _logic.setCurrentDate(DateTime.now());
    }
    _dateFocusNode = FocusNode();
    _titleFocusNode = FocusNode();
    _amountFocusNode = FocusNode();
    _dateFocusNode.addListener(() {
      setState(() {
        _dateHasFocus = _dateFocusNode.hasFocus;
      });
    });
    _titleFocusNode.addListener(() {
      setState(() {
        _titleHasFocus = _titleFocusNode.hasFocus;
      });
    });
    _amountFocusNode.addListener(() {
      setState(() {
        _amountHasFocus = _amountFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _dateFocusNode.dispose();
    _titleFocusNode.dispose();
    _amountFocusNode.dispose();
    _logic.bottomSheetControllersDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 20.0,
        right: 40.0,
        left: 40.0,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.0,
      ),
      child: Consumer<AppLogic>(
        builder: (context, data, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Header(
              text: 'Add Transaction',
              size: 30.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 12.0,
            ),
            InputField(
              isFocused: _titleHasFocus,
              focusNode: _titleFocusNode,
              isPassword: false,
              controller: data.titleController,
              labelText: 'Enter your title',
              capitalization: TextCapitalization.sentences,
            ),
            SizedBox(
              height: 12.0,
            ),
            InputField(
              isFocused: _dateHasFocus,
              focusNode: _dateFocusNode,
              controller: data.dateController,
              isPassword: false,
              labelText: 'Enter your Date',
              onTap: () async {
                await data.datePicker(context);
              },
            ),
            SizedBox(
              height: 12.0,
            ),
            InputField(
              focusNode: _amountFocusNode,
              isFocused: _amountHasFocus,
              isPassword: false,
              controller: data.amountController,
              labelText: 'Enter your amount',
              type: TextInputType.number,
            ),
            SizedBox(
              height: 12.0,
            ),
            CustomButton(
              color: Colors.purple,
              name: widget.isUpdated ? 'Update' : 'Add',
              onPress: () {
                if (data.titleController.text.isNotEmpty &&
                    data.amountController.text.isNotEmpty &&
                    data.dateController.text.isNotEmpty) {
                  if (widget.isUpdated) {
                    TransactionModel model = TransactionModel.withId(
                      id: widget.model.id,
                      title: data.titleController.text,
                      amount: double.parse(data.amountController.text),
                      date: data.dateTime,
                      userId: data.getUserId(),
                    );
                    data.update(model);
                  } else {
                    TransactionModel model = TransactionModel(
                      title: data.titleController.text,
                      amount: double.parse(data.amountController.text),
                      date: data.dateTime,
                      userId: data.getUserId(),
                    );
                    data.insert(model);
                  }
                  data.dateController.clear();
                  data.titleController.clear();
                  data.amountController.clear();
                  data.getTransactionList(data.getUserId());
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
