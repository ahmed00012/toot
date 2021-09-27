import 'dart:ui';

import 'package:email_validator/email_validator.dart';
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
  final _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.Login;

  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
    'phone': '',
  };

  final _passwordController = TextEditingController();

  _showDialog(BuildContext context, String title) {
    VoidCallback continueCallBack = () => {
          Navigator.of(context).pop(),
          // code on continue comes here
        };

    BlurryDialog alert = BlurryDialog('خطأ', title, continueCallBack);

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

    _authMode == AuthMode.Signup
        ? await BlocProvider.of<AuthCubit>(context).register(
            name: _authData['name'],
            phone: _authData['phone'],
            email: _authData['email'],
            password: _authData['password'],
            confirmPassword: _authData['password'])
        : await BlocProvider.of<AuthCubit>(context).login(
            phone: _authData['phone'],
            password: _authData['password'],
          );
  }

  void _switchAuthMode() {
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
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            _showDialog(context, state.error);
          } else if (state is AuthLoaded) {
            if (_authMode == AuthMode.Login) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => BottomNavBar(),
                ),
              );
            } else {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ActivateAccountScreen(
                    phone: _authData['phone'],
                    email: _authData['email'],
                    name: _authData['name'],
                    password: _authData['password'],
                  ),
                ),
              );
            }
          }
        },
        builder: (context, state) => Stack(children: [
          Form(
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
                        "assets/images/logo.png",
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
                            if (!EmailValidator.validate(val)) {
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
                            return 'يجب ان تحتوي كلمة السر علي 8 حروف او ارقام علي الاقل !';
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
          Visibility(
            visible: state is AuthLoading,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              elevation: 0,
              content: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(
                    'assets/images/loading.gif',
                    height: 0.4.sw,
                    width: 0.4.sw,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
