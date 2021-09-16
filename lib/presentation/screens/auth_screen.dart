import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/widgets/buttom_nav_bar.dart';
import 'package:toot/presentation/widgets/default_text_field.dart';

import '../../constants.dart';
import 'activate_account_screen.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.white, Colors.white10],
                begin: Alignment.centerRight,
                end: Alignment.topLeft),
          ),
          height: 1.sh,
          width: 1.sw,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: deviceSize.width > 600 ? 2 : 1,
                child: AuthCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {'email': '', 'password': ''};
  var _isLoading = false;
  bool isError = false;
  final _passwordController = TextEditingController();

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        isError = true;
      });
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

    // setState(() {
    //   _isLoading = true;
    // });

    // try {
    //   if (_authMode == AuthMode.Login) {
    //     // Log user in
    //     await Provider.of<Auth>(context, listen: false).signIn(
    //       _authData['email'],
    //       _authData['password'],
    //     );
    //   } else {
    //     // Sign user up
    //     await Provider.of<Auth>(context, listen: false).signUp(
    //       _authData['email'],
    //       _authData['password'],
    //     );
    //   }
    // } on HttpException catch (error) {
    //   var errorMessage = 'Authentication failed';
    //   if (error.toString().contains('EMAIL_EXISTS')) {
    //     errorMessage = 'This email already in use';
    //   } else if (error.toString().contains('INVALID_EMAIL')) {
    //     errorMessage = 'This is not a valid email';
    //   } else if (error.toString().contains('INVALID_PASSWORD')) {
    //     errorMessage = 'invalid password';
    //   } else if (error.toString().contains('WEAK_PASSWORD')) {
    //     errorMessage = 'This password is too weak';
    //   }
    //   _showErrorDialog(errorMessage);
    // } catch (error) {
    //   const errorMessage = 'please try again later';
    //   _showErrorDialog(errorMessage);
    // }
    // setState(() {
    //   _isLoading = false;
    // });
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
    final deviceSize = MediaQuery.of(context).size;
    return Container(
      height: isError == true
          ? _authMode == AuthMode.Signup
              ? 620.h
              : 540.h
          : _authMode == AuthMode.Signup
              ? 540.h
              : 460.h,
      constraints: BoxConstraints(
          minHeight: isError == true
              ? _authMode == AuthMode.Signup
                  ? 600.h
                  : 520.h
              : _authMode == AuthMode.Signup
                  ? 540.h
                  : 460.h),
      width: deviceSize.width * 0.85,
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                "assets/images/Group 1547.png",
                fit: BoxFit.contain,
                height: 0.18.sh,
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
              BuildTextField(
                icon: 'assets/images/smartphone.png',
                hint: 'رقم الجوال',
              ),
              BuildTextField(
                icon: 'assets/images/icon-padlock.png',
                hint: 'كلمة المرور',
              ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'الايميل'),
              //   keyboardType: TextInputType.emailAddress,
              //   validator: (value) {
              //     if (value!.isEmpty || !value!.contains('@')) {
              //       return 'الايميل غير صالح !';
              //     }
              //   },
              //   onSaved: (value) {
              //     _authData['email'] = value!;
              //   },
              // ),
              // TextFormField(
              //   decoration: InputDecoration(labelText: 'كلمة السر'),
              //   obscureText: true,
              //   controller: _passwordController,
              //   validator: (value) {
              //     if (value!.isEmpty || value.length < 5) {
              //       return 'كلمة السر قصيرة جدا !';
              //     }
              //   },
              //   onSaved: (value) {
              //     _authData['password'] = value!;
              //   },
              // ),
              if (_authMode == AuthMode.Signup)
                BuildTextField(
                  icon: 'assets/images/icon-padlock.png',
                  hint: 'تاكيد كلمة المرور',
                ),
              // TextFormField(
              //   enabled: _authMode == AuthMode.Signup,
              //   decoration: InputDecoration(labelText: 'تأكيد كلمة السر'),
              //   obscureText: true,
              //   validator: _authMode == AuthMode.Signup
              //       ? (value) {
              //           if (value != _passwordController.text) {
              //             return 'كلمة السر غير متطابقة !';
              //           }
              //         }
              //       : null,
              // ),
              SizedBox(
                height: 20,
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
                    child: Text(
                        _authMode == AuthMode.Login ? 'تسجيل الدخول' : 'سجل'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(Constants.mainColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
              FlatButton(
                child: Text(
                    '${_authMode == AuthMode.Login ? 'سجل' : 'تسجيل الدخول'}'),
                onPressed: _switchAuthMode,
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                textColor: Color(Constants.mainColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
