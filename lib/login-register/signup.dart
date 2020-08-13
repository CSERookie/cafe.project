import 'package:solarits2/login-register/models/passwordfield.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:solarits2/login-register/models/persondata.dart';



class SignUpScreen extends StatefulWidget {
  @override
  State createState() {
    return new SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      new GlobalKey<FormFieldState<String>>();
  PersonData person = new PersonData();
  bool _autovalidate = false;
  bool _isLoading = false;
  


  String _validateName(String value) {
    
    if (value.isEmpty || value.length < 5) return 'Adınızı Soyadınızı giriniz';
    final RegExp nameExp = new RegExp(r'^[A-Za-zşŞıIüÜğĞöÖçÇ ]+$');
    if (!nameExp.hasMatch(value)) return 'İsminiz harflerden oluşmalıdır';
    return null;
  }

  String _validatePassword(String value) {
    
    if (value == null || value.isEmpty) return 'Lütfen şifrenizi giriniz';
    if (value.length < 6) return 'Şifreniz en az 6 karakterden oluşmalıdır';
    return null;
  }

  String _validateEMail(value) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    if (!regExp.hasMatch(value)) {
      return 'Geçerli bir eposta adresi giriniz';
    }
    return null;
  }

  Widget button() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: new BorderRadius.circular(30.0),
        shadowColor: Colors.deepOrangeAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 100.0,
          onPressed: () => _handleSubmitted(),
          color: Colors.deepOrangeAccent,
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: const Text('Sign Up'),
      ),
      body: new SafeArea(
        top: false,
        bottom: false,
        child: new Form(
          key: _formKey,
          autovalidate: _autovalidate,
          child: new SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                new TextFormField(
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(),
                    hintText: 'What do people call you?',
                    labelText: 'Name',
                    filled: true,
                  ),
                  validator: _validateName,
                  onSaved: (String vale) {
                    person.name = vale;
                  },
                  enabled: !_isLoading,
                ),
                new SizedBox(
                  height: 20.0,
                ),
                new TextFormField(
                  decoration: new InputDecoration(
                    border: new OutlineInputBorder(),
                    hintText: 'Enter your email address',
                    labelText: 'Email',
                    filled: true,
                  ),
                  validator: _validateEMail,
                  onSaved: (String vale) {
                    person.email = vale;
                  },
                  keyboardType: TextInputType.emailAddress,
                  enabled: !_isLoading,
                ),
                new SizedBox(
                  height: 20.0,
                ),
                new PasswordField(
                  fieldKey: _passwordFieldKey,
                  helperText: 'No more than 8 characters.',
                  labelText: 'Password *',
                  onSaved: (String value) {
                    setState(() {
                      person.password = value;
                    });
                  },
                ),
                
                const SizedBox(height: 20.0),
                new TextFormField(
                  decoration: const InputDecoration(
                    border: const OutlineInputBorder(),
                    filled: true,
                    labelText: 'Re-type password',
                  ),
                  maxLength: 8,
                  obscureText: true,
                  validator: _validatePassword,
                  enabled: !_isLoading,
                ),
                new SizedBox(
                  height: 60.0,
                ),
                Container(
                  child: Center(child: button()),
                ),
                _isLoading
                    ? new Center(
                        child: new CircularProgressIndicator(
                        backgroundColor: Colors.teal,
                      ))
                    : new Container()
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      setState(() {
        _isLoading = true;
      });
      UserAuth auth = new UserAuth();
      print(person.email);
      print("password "+person.password);
      auth.createUser(person).then((FirebaseUser user) {
        showInSnackBar('Signup successfull.');
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
      }).catchError((e) {
        setState(() {
          _isLoading = false;
        });
        print(e);
        showInSnackBar(e);
      });
    }
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }
}