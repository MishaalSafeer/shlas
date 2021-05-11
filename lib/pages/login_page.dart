import 'package:flutter/material.dart';
import '../Services/auth.dart';
import '../Services/auth_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:auth/global.dart' as globals;


class EmailFieldValidator {
  static String validate(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }
  }


class PasswordFieldValidator {
  static String validate(String value) {
    return value.isEmpty ? 'Password can\'t be empty' : null;
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({this.onSignedIn});
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  Animation<double> _iconAnimation;
  AnimationController _iconAnimationController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final BaseAuth auth = AuthProvider.of(context).auth;
        if (_formType == FormType.login) {
          final String userId = await auth.signInWithEmailAndPassword(_email, _password);
          print('Signed in: $userId');
          widget.onSignedIn();
        } else {
          final String userId = await auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered user: $userId');
          moveToLogin();

        }

      } catch (e) {
        print('Error: $e');
        return 'email does not exist';
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }
  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));
    _iconAnimation = new CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.bounceOut,
    );
    _iconAnimation.addListener(() => this.setState(() {}));
    _iconAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(fit: StackFit.expand, children: <Widget>[
       new Theme(
        data: new ThemeData(
          brightness: Brightness.dark,
          inputDecorationTheme: new InputDecorationTheme(
            // hintStyle: new TextStyle(color: Colors.blue, fontSize: 20.0),
            labelStyle:
            new TextStyle(color: Colors.tealAccent, fontSize: 15.0),
          )
        ),
          isMaterialAppTheme: true,
          child: new Column(
             mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new FlutterLogo(
                  size: _iconAnimation.value * 140.0,
                ),

            Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
                 child: Form(
                  key: formKey,
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    ]
    ),

       )]
  ),
    );

  }

  List<Widget> buildInputs() {
    return <Widget>[
      TextFormField(
        key:Key('email'),
        decoration: InputDecoration(
            labelText: 'EMAIL',
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.white, fontSize: 25),

            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green)),
        icon: new Icon(
        Icons.mail,
        color: Colors.grey,
        )),
        validator: EmailFieldValidator.validate,
        onSaved: (String value) => _email = value,

      ),
      SizedBox(height: 20.0),
      TextFormField(
        key:Key('password'),
        decoration: InputDecoration(
            labelText: 'PASSWORD',
            labelStyle: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                color: Colors.white, fontSize: 25),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.green)),
        icon: new Icon(
        Icons.lock,
          color: Colors.grey,
          )),
        obscureText: true,
        validator: PasswordFieldValidator.validate,
        onSaved: (String value) => _password = value,
      ),
      SizedBox(height: 5.0),


    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {

      return <Widget>


      [ SizedBox(height: 10.0),
        RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                    side: BorderSide(color: Colors.green),

                ),

                key: Key('signIn'),
                 child: Text('Login', style: TextStyle(color: Colors.white,
                     fontWeight: FontWeight.bold,
                     fontFamily: 'Montserrat',fontSize: 25.0)),

                 onPressed: validateAndSubmit,
          color:Colors.green,

        ),
        Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Text(
                  'New to Smart Home ?',
                    style: TextStyle(fontFamily: 'Montserrat',color: Colors.white,),
                      ),
                      SizedBox(width: 5.0),
                      InkWell(
                        onTap:moveToRegister,
                        child: Text(
                        'Register',
                        style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),

                          )
                          ),

      ]
                          ),
      ];

    }
    else {
      return <Widget>[
        SizedBox(height: 10.0),
        RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(color: Colors.green),

          ),
          child: Text('Create an account', style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',fontSize: 25.0)),
              onPressed: validateAndSubmit,
          color:Colors.green,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Have an account ?',
                style: TextStyle(fontFamily: 'Montserrat',color: Colors.white,),
              ),
              SizedBox(width: 20.0),
              InkWell(
                  onTap:moveToLogin,
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),

                  )
              ),

            ]
        ),
      ];
    }
  }
}