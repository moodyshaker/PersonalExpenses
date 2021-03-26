import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/app_logic/shred_pref.dart';
import 'package:personal_expenses/model/transaction.dart';
import 'package:personal_expenses/model/user_profile.dart';
import 'package:personal_expenses/persistence/expenses_database.dart';
import 'package:personal_expenses/screen/chart.dart';
import 'package:personal_expenses/screen/expenses_list.dart';
import 'package:personal_expenses/utils.dart';

import 'auth.dart';

class AppLogic extends ChangeNotifier {
  ExpensesDatabase _database;
  DateTime _date;
  Auth _auth;
  bool _loading = false;
  bool _isLogged = false;
  SharedAppPref _sharedAppPref;
  List<TransactionModel> _transactionList = List<TransactionModel>();
  TextEditingController _titleController;
  TextEditingController _amountController;
  TextEditingController _dateController;
  TextEditingController _emailCheckController;
  TextEditingController _loginEmailController;
  TextEditingController _loginPasswordController;
  TextEditingController _registrationConfirmPasswordController;
  TextEditingController _registrationPasswordController;
  TextEditingController _registrationEmailController;
  TextEditingController _registrationConfirmEmailController;
  TextEditingController _registrationFirstNameController;
  TextEditingController _registrationLastNameController;
  TextEditingController _profileChangeNameController;
  bool _checking = false;
  bool _isListEmpty = false;
  int _selectedPage = 0;
  bool _isPopulating = true;

  bool get isListEmpty => _isListEmpty;

  void selectedTab(int value) {
    _selectedPage = value;
    notifyListeners();
  }

  Widget getCurrent(AppLogic data) {
    Widget container;
    switch (_selectedPage) {
      case 0:
        container = Expanded(
          child: ExpensesList(
            data: data,
          ),
        );
        break;
      case 1:
        container = Chart(
          data: data,
        );
    }
    return container;
  }

  int get selectedPage => _selectedPage;

  TextEditingController get loginEmailController => _loginEmailController;

  TextEditingController get profileChangeNameController =>
      _profileChangeNameController;

  void initProfileChangeNameController() {
    _profileChangeNameController = TextEditingController();
  }

  void initRegistrationControllers() {
    _registrationConfirmPasswordController = TextEditingController();
    _registrationPasswordController = TextEditingController();
    _registrationEmailController = TextEditingController();
    _registrationConfirmEmailController = TextEditingController();
    _registrationLastNameController = TextEditingController();
    _registrationFirstNameController = TextEditingController();
  }

  void registrationControllersDispose() {
    _registrationConfirmPasswordController.dispose();
    _registrationPasswordController.dispose();
    _registrationEmailController.dispose();
    _registrationConfirmEmailController.dispose();
    _registrationLastNameController.dispose();
    _registrationFirstNameController.dispose();
  }

  void profileCHangeNameControllerDispose() {
    profileChangeNameController.dispose();
  }

  void initBottomSheetControllers() {
    _titleController = TextEditingController();
    _amountController = TextEditingController();
    _dateController = TextEditingController();
  }

  Future<String> createNewUser(String email, String password,
      {String username, String photoUrl}) async {
    String msg = await _auth.createNewUser(email, password,
        displayName: username, photoUrl: photoUrl);
    return msg;
  }

  Future<String> updateProfile({String username, String photoUrl}) async {
    String msg =
        await _auth.updateProfile(displayName: username, photoUrl: photoUrl);
    return msg;
  }

  void initEmailCheckingControllers() {
    _emailCheckController = TextEditingController();
  }

  void initLoginControllers() {
    _loginEmailController = TextEditingController();
    _loginPasswordController = TextEditingController();
  }

  String formatDate(DateTime date) {
    DateFormat formatter = DateFormat('MMM dd, yyyy');
    String newDate = formatter.format(date);
    return newDate;
  }

  bool get checking => _checking;

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void logged(bool value) {
    _isLogged = value;
    notifyListeners();
  }

  TextEditingController get emailCheckController => _emailCheckController;

  bool get isLogged => _isLogged;

  bool get isLoading => _loading;

  void initAuth() async {
    _auth = Auth.instance;
    await _auth.initAuth();
  }

  void emailCheckControllerDispose() {
    _emailCheckController.dispose();
  }

  Future<UserProfile> googleSignIn() async {
    UserProfile user = await _auth.googleSignIn();
    return user;
  }

  Future<UserProfile> facebookLogin() async {
    UserProfile user = await _auth.facebookSignIn();
    return user;
  }

  void loginDispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
  }

  void forgetPasswordDispose() {
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
  }

  void initSharedPref() async {
    _sharedAppPref = SharedAppPref.instance;
    await _sharedAppPref.sharedPreference;
  }

  void setType(SignMethod signMethod) async {
    await _sharedAppPref.setType(signMethod.toString());
    notifyListeners();
  }

  void getUserFromSocial({@required SignMethod type}) async {
    if (type == SignMethod.FACEBOOK) {
      UserProfile user = await facebookLogin();
      _emailCheckController.text = user.email;
      setType(type);
      await saveSocialUser(user);
    } else if (type == SignMethod.GOOGLE) {
      UserProfile user = await googleSignIn();
      _emailCheckController.text = user.email;
      setType(type);
      await saveSocialUser(user);
    }
    notifyListeners();
  }

  Future<String> forgetPassword(String email) async {
    String msg = await _auth.forgetPassword(email);
    return msg;
  }

  setChecking(bool value) {
    _checking = value;
    notifyListeners();
  }

  Future<String> signOut() async {
    String msg = await _auth.firebaseSignOut();
    return msg;
  }

  Future<UserState> verifyEmail(String email) async {
    UserState state;
    try {
      List<String> list = await _auth.verifyEmail(_emailCheckController.text);
      if (list.isEmpty) {
        state = UserState.NOT_FOUND;
      } else {
        state = UserState.REGISTER;
      }
    } catch (e) {
      state = UserState.ERROR;
    }
    return state;
  }

  void setEmail(String email) async {
    await _sharedAppPref.setEmail(email);
  }

  Future<String> saveSocialUser(UserProfile user) async {
    try {
      await _sharedAppPref.setName(user.name);
      await _sharedAppPref.setEmail(user.email);
      if (user.photo != null) await _sharedAppPref.setPhotoUrl(user.photo);
      notifyListeners();
      return Auth.SUCCESS_MSG;
    } catch (e) {
      return e.message;
    }
  }

  Future<String> saveUser(User user) async {
    try {
      await _sharedAppPref.setId(user.uid);
      await _sharedAppPref.setName(user.displayName);
      await _sharedAppPref.setEmail(user.email);
      if (user.photoURL != null)
        await _sharedAppPref.setPhotoUrl(user.photoURL);
      notifyListeners();
      return Auth.SUCCESS_MSG;
    } catch (e) {
      return e.message;
    }
  }

  bool isFirstTime() => _sharedAppPref.isFirstTime();

  Future<String> clearUser() async {
    String msg = await _sharedAppPref.clearAll();
    return msg;
  }

  String getUserId() => _sharedAppPref.getId();

  String getUserType() => _sharedAppPref.getType();

  String getUserName() => _sharedAppPref.getUsername();

  String getUserEmail() => _sharedAppPref.getEmail();

  String getUserImage() => _sharedAppPref.getImageUrl();

  void setCurrentDate(DateTime dateTime) {
    _date = dateTime;
    dateController.text = formatDate(_date);
  }

  void deleteAll() async {
    await _database.deleteAll();
  }

  TextEditingController get titleController => _titleController;

  void closeDB() {
    closeDatabase();
  }

  void bottomSheetControllersDispose() {
    _titleController.dispose();
    _amountController.dispose();
    _dateController.dispose();
  }

  void initDatabase() async {
    _database = ExpensesDatabase.instance;
    await _database.db;
  }

  void insert(TransactionModel item) async {
    await _database.insert(item);
  }

  bool get isPopulating => _isPopulating;

  void getTransactionList(String userId) async {
    _isPopulating = true;
    _transactionList = await _database.getData(userId);
    _isPopulating = false;
    _isListEmpty = _transactionList.isEmpty;
    notifyListeners();
  }

  void delete(TransactionModel item) async {
    await _database.delete(item);
  }

  void update(TransactionModel item) async {
    await _database.update(item);
  }

  void closeDatabase() async {
    await _database.closeDB();
  }

  User get getCurrentUser => _auth.currentUser;

  Future<String> userLogin(String email, String password) async {
    String msg = await _auth.loginAccount(email, password);
    return msg;
  }

  List<TransactionModel> get transactionList => _transactionList;

  TextEditingController get amountController => _amountController;

  TextEditingController get dateController => _dateController;

  Future<DateTime> datePicker(BuildContext context) async {
    DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
    );
    if (date != null) {
      _date = date;
      dateController.text = formatDate(_date);
      notifyListeners();
    }
  }

  DateTime get dateTime => _date;

  TextEditingController get loginPasswordController => _loginPasswordController;

  TextEditingController get registrationLastNameController =>
      _registrationLastNameController;

  TextEditingController get registrationFirstNameController =>
      _registrationFirstNameController;

  TextEditingController get registrationConfirmEmailController =>
      _registrationConfirmEmailController;

  TextEditingController get registrationEmailController =>
      _registrationEmailController;

  TextEditingController get registrationPasswordController =>
      _registrationPasswordController;

  TextEditingController get registrationConfirmPasswordController =>
      _registrationConfirmPasswordController;
}
