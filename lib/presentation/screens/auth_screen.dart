import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toot/presentation/widgets/buttom_nav_bar.dart';
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
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Colors.white70
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerLeft,
                stops: [0, 1],
              ),
            ),
          ),
          Positioned(
            right: 0.25.sw,
            top: 0.1.sh,
            child: Image.asset(
              "assets/images/Group 1547.png",
              fit: BoxFit.contain,
              height: 0.18.sh,
              width: 0.5.sw,
            ),
          ),
          Positioned(
            top: 0.08.sh,
            child: SingleChildScrollView(
              child: Container(
                height: deviceSize.height,
                width: deviceSize.width,
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
          ),
        ],
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
  bool isError=false;
  final _passwordController = TextEditingController();

  void _submit() async {
    if (!_formKey.currentState!.validate()) {
     setState(() {
       isError=true;
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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: isError==true?_authMode == AuthMode.Signup ? 360.h : 300.h:_authMode == AuthMode.Signup ? 320.h:260.h,
        constraints: BoxConstraints(
            minHeight: isError==true?_authMode == AuthMode.Signup ? 360.h : 300.h:_authMode == AuthMode.Signup ? 320.h:260.h),
        width: deviceSize.width * 0.85,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'الايميل'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || !value!.contains('@')) {
                      return 'الايميل غير صالح !';
                    }
                  },
                  onSaved: (value) {
                    _authData['email'] = value!;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'كلمة السر'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty || value.length < 5) {
                      return 'كلمة السر قصيرة جدا !';
                    }
                  },
                  onSaved: (value) {
                    _authData['password'] = value!;
                  },
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.Signup,
                    decoration: InputDecoration(labelText: 'تأكيد كلمة السر'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return 'كلمة السر غير متطابقة !';
                            }
                          }
                        : null,
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  SizedBox(
                    width: 0.60.sw,
                    child: ElevatedButton(
                      onPressed: () {
                        return _submit();
                      },
                      child: Text(
                          _authMode == AuthMode.Login ? 'تسجيل الدخول' : 'سجل'),
                      style: ElevatedButton.styleFrom(
                        primary: Color(Constants.mainColor),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
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
      ),
    );
  }
}
