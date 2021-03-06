import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infodeck/animations/FadeAnimation.dart';
import 'package:infodeck/root_page.dart';
import 'package:fluttertoast/fluttertoast.dart';




enum AuthResultStatus {
  successful,
  emailAlreadyExists,
  wrongPassword,
  invalidEmail,
  userNotFound,
  userDisabled,
  operationNotAllowed,
  tooManyRequests,
  undefined,
}


class RegPage extends StatefulWidget {


  @override
  _RegPageState createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {


  String email, password, name;
  int _validate = 0;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();










  Future<void> register() async {
      try {
        final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


        final newUser = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);



          if (newUser != null) {
            Firestore.instance.collection('users').document(newUser.uid).setData({"email":email, "name": name});
            //hard coded package assigned to every newly created user
            Firestore.instance.collection('users').document(newUser.uid).collection('assignedpackages').document('package 1').setData({"name":'package 1', "check": false});
            Firestore.instance.collection('users').document(newUser.uid).collection('assignedpackages').document('package 2').setData({"name":'package 2', "check": false});
            Firestore.instance.collection('users').document(newUser.uid).collection('assignedpackages').document('package 3').setData({"name":'package 3', "check": false});
            Firestore.instance.collection('users').document(newUser.uid).collection('assignedpackages').document('package 4').setData({"name":'package 4', "check": false});
            Firestore.instance.collection('users').document(newUser.uid).collection('assignedpackages').document('package 5').setData({"name":'package 5', "check": false});
            Firestore.instance.collection('users').document(newUser.uid).collection('assignedpackages').document('package 6').setData({"name":'package 6', "check": false});
            Fluttertoast.showToast(
                msg: "Login Successful!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.black12,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => RootPage()),
            );
          }
      } catch (e) {
        var status;
        switch (e.code) {
          case "ERROR_INVALID_EMAIL":
            status = AuthResultStatus.invalidEmail;
            break;
          case "ERROR_WRONG_PASSWORD":
            status = AuthResultStatus.wrongPassword;
            break;
          case "ERROR_USER_NOT_FOUND":
            status = AuthResultStatus.userNotFound;
            break;
          case "ERROR_USER_DISABLED":
            status = AuthResultStatus.userDisabled;
            break;
          case "ERROR_TOO_MANY_REQUESTS":
            status = AuthResultStatus.tooManyRequests;
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
            status = AuthResultStatus.operationNotAllowed;
            break;
          case "ERROR_EMAIL_ALREADY_IN_USE":
            status = AuthResultStatus.emailAlreadyExists;
            break;
          default:
            status = AuthResultStatus.undefined;
        }

        String errorMessage;
        switch (status) {
          case AuthResultStatus.invalidEmail:
            errorMessage = "Your email address appears to be malformed.";
            break;
          case AuthResultStatus.wrongPassword:
            errorMessage = "Your password is wrong.";
            break;
          case AuthResultStatus.userNotFound:
            errorMessage = "User with this email doesn't exist.";
            break;
          case AuthResultStatus.userDisabled:
            errorMessage = "User with this email has been disabled.";
            break;
          case AuthResultStatus.tooManyRequests:
            errorMessage = "Too many requests. Try again later.";
            break;
          case AuthResultStatus.operationNotAllowed:
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          case AuthResultStatus.emailAlreadyExists:
            errorMessage =
            "The email has already been registered. Please login or reset your password.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(
            msg: "$errorMessage",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black12,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(210, 253, 253, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 150,
            child: Stack(
              children: <Widget>[

              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                FadeAnimation(
                  1,
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Colors.white,
                    ),


                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Text(
                            "REGISTER",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 30,
                              color: Color.fromRGBO(35, 121, 69, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: _name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),

                            onChanged: (value) {
                              name = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),

                            onChanged: (value) {
                              email = value;
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: TextFormField(
                            controller: _pass,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(color: Colors.grey),
                            ),

                            onChanged: (value) {
                              password = value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _name.text.isEmpty ? Fluttertoast.showToast(
                                    msg: "Please enter Name!",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.black,
                                    fontSize: 16.0
                                ) : _validate = _validate+1;
                                _email.text.isEmpty ? Fluttertoast.showToast(
                                    msg: "Please enter Email!",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.black,
                                    fontSize: 16.0
                                ) : _validate = _validate+1;
                                _pass.text.isEmpty ? Fluttertoast.showToast(
                                    msg: "Please enter Password!",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.black,
                                    fontSize: 16.0
                                ) : _validate = _validate+1;
                              });
                              if(_validate==3){
                                register();
                              }
                            },
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Color.fromRGBO(35, 121, 69, 1),
                              ),
                              child: Center(
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),

                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          child: InkWell(
                            onTap: () {

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => RootPage()));
                            },
                            child: new Text(
                              "Already a Member?",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}