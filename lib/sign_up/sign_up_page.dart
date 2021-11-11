import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../app.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  final GlobalKey<FormState> _key = new GlobalKey();
  final TextEditingController _userNameController = new TextEditingController();
  final TextEditingController _firstNameController =
      new TextEditingController();
  final TextEditingController _lastNameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmPasswordController =
      new TextEditingController();
  final TextEditingController _mobileController = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _validate = false;
  bool visible = true;
  String userName,
      firstName,
      lastName,
      email,
      password,
      confirmPassword,
      mobile;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      body: new Form(key: _key, autovalidate: _validate, child: _body(context)),
    );
  }

  _body(BuildContext context) =>
      ListView(physics: BouncingScrollPhysics(), children: <Widget>[
        Container(
            padding: EdgeInsets.all(15),
            child: Column(children: <Widget>[_formUI()]))
      ]);
  @override
  void dispose() {
    if (this.mounted) super.dispose();
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _mobileController.dispose();
  }

  _formUI() {
    return new Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 40.0),
          _inputUserName(),
          SizedBox(height: 12.0),
          _inputFirstName(),
          SizedBox(height: 12.0),
          _inputLastName(),
          SizedBox(height: 12.0),
          _inputEmail(),
          SizedBox(height: 12.0),
          _inputPassword(),
          SizedBox(height: 12.0),
          _inputConfirmPassword(),
          SizedBox(height: 12.0),
          _inputMobile(),
          SizedBox(height: 20.0),
          SizedBox(
              width: double.infinity,
              child: RaisedButton(
                color: Colors.orangeAccent,
                textColor: Colors.white,
                padding: const EdgeInsets.all(15.0),
                child: Text("Submit".toUpperCase()),
                onPressed: () {
                  _sendToServer();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ))
        ],
      ),
    );
  }

  _inputUserName() {
    return new TextFormField(
      controller: _userNameController,
      validator: validateUsername,
      decoration: new InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        hintText: 'Username (Login)',
        prefixIcon: _prefixIcon(Icons.person_outline),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
      keyboardType: TextInputType.emailAddress,
      //validator: UIData.validateEmail,
      onSaved: (str) {
        userName = str;
      },
    );
  }

  _inputFirstName() {
    return new TextFormField(
      controller: _firstNameController,
      validator: validateUsername,
      decoration: new InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        hintText: 'First name',
        prefixIcon: _prefixIcon(Icons.person_outline),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
      keyboardType: TextInputType.emailAddress,
      //validator: UIData.validateEmail,
      onSaved: (str) {
        firstName = str;
      },
    );
  }

  _inputLastName() {
    return new TextFormField(
      controller: _lastNameController,
      validator: validateUsername,
      decoration: new InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        hintText: 'Last name',
        prefixIcon: _prefixIcon(Icons.person_outline),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
      keyboardType: TextInputType.emailAddress,
      //validator: UIData.validateEmail,
      onSaved: (str) {
        lastName = str;
      },
    );
  }

  _inputEmail() {
    return new TextFormField(
      controller: _emailController,
      decoration: new InputDecoration(
        contentPadding: const EdgeInsets.all(16.0),
        hintText: 'Email',
        prefixIcon: _prefixIcon(Icons.email),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none),
        filled: true,
        fillColor: Colors.grey.withOpacity(0.1),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: validateEmail,
      onSaved: (str) {
        email = str;
      },
    );
  }

  _inputPassword() {
    return TextFormField(
        controller: _passwordController,
        obscureText: visible,
        validator: validatePassword,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16.0),
            hintText: 'Password',
            prefixIcon: _prefixIcon(Icons.lock),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            suffix: InkWell(
              child: visible
                  ? Icon(
                      Icons.visibility_off,
                      size: 18,
                      color: Colors.orange,
                    )
                  : Icon(
                      Icons.visibility,
                      size: 18,
                      color: Colors.orange,
                    ),
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
            )),
        onSaved: (str) {
          password = str;
        });
  }

  _inputConfirmPassword() {
    return TextFormField(
        controller: _confirmPasswordController,
        obscureText: visible,
        validator: (confirmation) {
          return confirmation.isEmpty
              ? 'Confirm password is required'
              : validationEqual(confirmation, _passwordController.text)
                  ? null
                  : 'Password not match';
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16.0),
            hintText: 'Confirm password',
            prefixIcon: _prefixIcon(Icons.lock),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1),
            suffix: InkWell(
              child: visible
                  ? Icon(
                      Icons.visibility_off,
                      size: 18,
                      color: Colors.orange,
                    )
                  : Icon(
                      Icons.visibility,
                      size: 18,
                      color: Colors.orange,
                    ),
              onTap: () {
                setState(() {
                  visible = !visible;
                });
              },
            )),
        onSaved: (str) {
          confirmPassword = str;
        });
  }

  _inputMobile() {
    return TextFormField(
        controller: _mobileController,
        validator: validateMobile,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16.0),
            hintText: 'Mobile',
            prefixIcon: _prefixIcon(Icons.phone),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1)),
        onSaved: (str) {
          mobile = str;
        });
  }

  _prefixIcon(IconData iconData) {
    return Container(
        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomRight: Radius.circular(10.0))),
        child: Icon(
          iconData,
          size: 20,
          color: Colors.grey,
        ));
  }

  _sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      var url_auth = Uri.parse(
          'http://spacex038i.pythonanywhere.com/api/v1/api-token-auth/');
      var response_auth = await http.post(
        url_auth,
        headers: {'Content-type': 'application/json'},
        body: json.encode({'username': 'admin', 'password': 'HkhG7thb'}),
      );
      Map<String, dynamic> token = jsonDecode(response_auth.body);
      var url = Uri.parse('http://spacex038i.pythonanywhere.com/api/v1/user/');
      var response = await http.post(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "token ${token['token']}"
        },
        body: json.encode({
          'username': '${_userNameController.text}',
          'last_name': '${_lastNameController.text}',
          'first_name': '${_firstNameController.text}',
          'email': '${_emailController.text}',
          'password': '${_passwordController.text}'
        }),
      );

      if ('${response.statusCode}' == '201') {
        // AlertDialog alert = AlertDialog(
        //   title: Text("Register "),
        //   content: Text("Register Succsess"),
        // );
        // Timer(Duration(seconds: 3), () {
        //   print("Yeah, this line is printed after 3 seconds");
        // });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AuthPage()));
      }
      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  String validateMobile(String value) {
    String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(pattern);
    final find = '+';
    final replaceWith = '0';
    if (value.replaceAll(" ", "").isEmpty) {
      return 'Mobile is required';
    } else if (value.replaceAll(" ", "").length != 12) {
      return 'Mobile number not + or must 11 digits';
    } else if (!regExp.hasMatch(value.replaceAll(find, replaceWith))) {
      return 'Mobile number must be digits';
    } else if (((value.replaceAll(" ", "")))[0] != '+') {
      return 'Not + ';
    }

    return null;
  }

  String validateUsername(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Username is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Username must be a-z and A-Z';
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return 'Email is required';
    } else if (!regExp.hasMatch(value)) {
      return 'Invalid email';
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Confirm password is required';
    } else if (value.length < 4) {
      return 'Confirm password must be at least 4 characters';
    }
    return null;
  }

  bool validationEqual(String currentValue, String checkValue) {
    if (currentValue == checkValue) {
      return true;
    } else {
      return false;
    }
  }
}
