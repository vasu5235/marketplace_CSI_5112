import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:marketplace/constants/api_url.dart';
import 'package:marketplace/constants/route_names.dart';
import 'package:http/http.dart' as http;

import 'package:marketplace/constants/constants.dart';
import 'package:email_validator/email_validator.dart';

class SignUp extends StatefulWidget {
  final Function onLogInSelected;

  SignUp({@required this.onLogInSelected});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Simple signUp form using TextFields and buttons from action_button.dart
  var emailTextFieldController = TextEditingController();
  var passwordFieldController = TextEditingController();
  var nameFieldController = TextEditingController();

  String userName, email, password, confirmPassword, mobile;
  bool visible = true;

  String message = '';

  void validateEmail(String enteredEmail) {
    if (EmailValidator.validate(enteredEmail)) {
      setState(() {
        message = '';
      });
    } else {
      setState(() {
        message = 'Please enter a valid email address!';
      });
    }
  }

  // String validateEmail(String value) {
  //   String pattern =
  //       r'^\S+@\S+\.\S+$';
  //   RegExp regExp = new RegExp(pattern);
  //   if (value.isEmpty) {
  //     return 'Email is required';
  //   } else if (!regExp.hasMatch(value)) {
  //     return 'Invalid email';
  //   } else {
  //     return null;
  //   }
  // }

  String get _errorText {
    // at any time, we can get the text from _controller.value.text
    final text = nameFieldController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 4) {
      return 'Minimum 3 Characters required';
    }
    // return null if the text is valid
    return null;
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 4) {
      return 'Password must be at least 4 characters';
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.all(size.height > 770
          ? 64
          : size.height > 670
              ? 32
              : 16),
      child: Center(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            height: size.height *
                (size.height > 770
                    ? 0.7
                    : size.height > 670
                        ? 0.8
                        : 0.9),
            width: 500,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[700],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        width: 30,
                        child: Divider(
                          color: kPrimaryColor,
                          thickness: 2,
                        ),
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        controller: nameFieldController,
                        decoration: InputDecoration(
                          hintText: 'Name',
                          labelText: 'Name',
                          suffixIcon: Icon(
                            Icons.person_outline,
                          ),
                          errorText: _errorText,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        //validator: UIData.validateEmail,
                        onSaved: (str) {
                          userName = str;
                        },
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      TextField(
                        controller: emailTextFieldController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          labelText: 'Email',
                          suffixIcon: Icon(
                            Icons.mail_outline,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (enteredEmail) => validateEmail(enteredEmail),
                      ),
                      Text(message, textAlign: TextAlign.left),
                      SizedBox(
                        height: 32,
                      ),
                      TextFormField(
                        controller: passwordFieldController,
                        obscureText: visible,
                        validator: validatePassword,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          labelText: 'Password',
                          suffixIcon: Icon(
                            Icons.lock_outline,
                          ),
                            suffix: InkWell(
                              child: visible
                                  ? Icon(
                                Icons.visibility_off,
                                size: 18,
                                color: Colors.blue,
                              )
                                  : Icon(
                                Icons.visibility,
                                size: 18,
                                color: Colors.blueAccent,
                              ),
                              onTap: () {
                                setState(() {
                                  visible = !visible;
                                });
                              },
                            )
                        ),
                      ),
                      SizedBox(
                        height: 64,
                      ),

                      GestureDetector(
                          onTap: () async {
                            // var test = _LogInState.getEmailTextControllerValue();
                            var email = emailTextFieldController.text;
                            var password = passwordFieldController.text;
                            var name = nameFieldController.text;
                            int randomId = Random().nextInt(99999);

                            Map bodyData = {
                              "id": randomId,
                              "name": name,
                              "email": email,
                              "password": password,
                              "isMerchant": false
                            };

                            var body = json.encode(bodyData);

                            // print("email: " + emailTextFieldController.text);
                            // print("password: " + passwordFieldController.text);
                            String uri = ApiUrl.envUrl;
                            final url = Uri.encodeFull("${uri}/user");

                            // print("===URL===" + url);

                            var response = await http.post(url,
                                headers: {'Content-Type': 'application/json'},
                                body: body);
                            print("Response\n" + response.body);

                            if (response.body == "true") {
                              AlertDialog signUpResultDialog = AlertDialog(
                                // Retrieve the text the that user has entered by using the
                                // TextEditingController.
                                content: Text(
                                    "Success!, please Login with your credentials"),
                              );

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return signUpResultDialog;
                                },
                              );
                            } else {
                              AlertDialog signUpFailure = AlertDialog(
                                // Retrieve the text the that user has entered by using the
                                // TextEditingController.
                                content: Text(
                                    "Oops! Failed to register, please try again"),
                              );

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return signUpFailure;
                                },
                              );
                            }
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryColor.withOpacity(0.2),
                                  spreadRadius: 4,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, RouteNames.home);
                                },
                                child: Text(
                                  "CREATE ACCOUNT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          )),
                      SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          GestureDetector(
                            onTap: () {
                              widget.onLogInSelected();
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Log In",
                                  style: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: kPrimaryColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
