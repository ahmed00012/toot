import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/cubits/auth_cubit/auth_cubit.dart';
import 'package:toot/presentation/widgets/blurry_dialog.dart';
import 'package:toot/presentation/widgets/buttom_nav_bar.dart';
import 'package:toot/presentation/widgets/default_text_field.dart';

import '../../constants.dart';
import 'activate_account_screen.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
    'phone': '',
  };

  var _isLoading = false;
  final _passwordController = TextEditingController();

  _showDialog(BuildContext context) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context).pop(),
          // code on continue comes here
        };
    BlurryDialog alert = BlurryDialog("Abort",
        "Are you sure you want to abort this operation?", continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    if (_authMode == AuthMode.Login) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BottomNavBar(),
        ),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ActivateAccountScreen(),
        ),
      );
    }

    setState(() {
      _isLoading = true;
    });

    await BlocProvider.of<AuthCubit>(context).register(
        name: _authData['name'],
        phone: _authData['phone'],
        email: _authData['email'],
        password: _authData['password'],
        confirmPassword: _authData['password']);

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    _formKey.currentState!.reset();
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          height: 1.sh,
          width: 1.sw,
          padding: EdgeInsets.symmetric(horizontal: 0.08.sw),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "assets/images/Group 1547.png",
                    fit: BoxFit.contain,
                    height: 0.16.sh,
                    width: 0.5.sw,
                  ),
                  Text(
                    _authMode != AuthMode.Signup ? 'تسجيل دخول' : 'تسجيل',
                    style: TextStyle(
                        fontSize: 20.sp, color: Color(Constants.mainColor)),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (_authMode == AuthMode.Signup)
                    BuildTextField(
                      icon: 'assets/images/add card  (2).png',
                      hint: 'الاسم',
                      validator: (String? val) {
                        if (val!.isEmpty || val.length <= 6) {
                          return 'الاسم غير صالح !';
                        }
                      },
                      onSaved: (val) {
                        _authData['name'] = val!;
                      },
                    ),
                  if (_authMode == AuthMode.Signup)
                    BuildTextField(
                      icon: 'assets/images/icon-mail.png',
                      hint: 'الايميل',
                      validator: (val) {
                        if (val!.isEmpty || !val!.contains('@')) {
                          return 'الايميل غير صالح !';
                        }
                      },
                      onSaved: (val) {
                        _authData['email'] = val!;
                      },
                    ),
                  BuildTextField(
                    icon: 'assets/images/smartphone.png',
                    hint: 'رقم الجوال',
                    isNumeric: true,
                    validator: (val) {
                      if (!val.contains('05') || val.length != 10) {
                        return 'رقم الجوال غير صالح !';
                      }
                    },
                    onSaved: (val) {
                      print(val);
                      _authData['phone'] = val!;
                    },
                  ),
                  BuildTextField(
                    icon: 'assets/images/icon-padlock.png',
                    hint: 'كلمة المرور',
                    controller: _passwordController,
                    isObscure: true,
                    validator: (val) {
                      if (val.length < 8) {
                        return 'كلمة السر قصيرة جدا يجب ان تحتوي علي 8 حروف او ارقام !';
                      }
                    },
                    onSaved: (val) {
                      print(val);
                      _authData['password'] = val!;
                    },
                  ),
                  if (_authMode == AuthMode.Signup)
                    BuildTextField(
                      icon: 'assets/images/icon-padlock.png',
                      hint: 'تاكيد كلمة المرور',
                      validator: _authMode == AuthMode.Signup
                          ? (val) {
                              if (val != _passwordController.text) {
                                return 'كلمة السر غير متطابقة !';
                              }
                            }
                          : (val) {},
                      isObscure: true,
                      onSaved: (val) {},
                    ),
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    SizedBox(
                      width: 0.90.sw,
                      child: ElevatedButton(
                        onPressed: () {
                          return _submit();
                        },
                        child: Text(_authMode == AuthMode.Login
                            ? 'تسجيل الدخول'
                            : 'سجل'),
                        style: ElevatedButton.styleFrom(
                          primary: Color(Constants.mainColor),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    child: Text(
                        '${_authMode == AuthMode.Login ? 'سجل' : 'تسجيل الدخول'}'),
                    onPressed: _switchAuthMode,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
