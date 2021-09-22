import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_voitures/Screens/LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPwdController = TextEditingController();
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _phoneNumberController = TextEditingController();
  var items = ["male", "female"];
  String genderValue = "male";

  @override
  void initState() {
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    _confirmPwdController = new TextEditingController();
    _firstNameController = new TextEditingController();
    _lastNameController = new TextEditingController();
    _phoneNumberController = new TextEditingController();

    super.initState();
  }

  String? emailValidator(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value!)) {
      return 'Email format is invalid';
    } else {
      return "";
    }
  }

  String? pwdValidator(String? value) {
    if (value!.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'First Name*', hintText: "John"),
                  controller: _firstNameController,
                  validator: (value) {
                    if (value!.length < 3) {
                      return "Please enter a valid first name.";
                    }
                  },
                ),
                TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Last Name*', hintText: "Doe"),
                    controller: _lastNameController,
                    validator: (value) {
                      if (value!.length < 3) {
                        return "Please enter a valid last name.";
                      }
                    }),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Email', hintText: "john.doe@gmail.com"),
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: emailValidator,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Phone number', hintText: "062837283"),
                  keyboardType: TextInputType.phone,
                  controller: _phoneNumberController,
                ),
                DropdownButton(
                    isExpanded: true,
                    value: genderValue,
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        genderValue = newValue!;
                      });
                    }),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Password', hintText: "********"),
                  obscureText: true,
                  controller: _passwordController,
                  validator: pwdValidator,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Confirm Password*', hintText: "********"),
                  controller: _confirmPwdController,
                  obscureText: true,
                  validator: pwdValidator,
                ),
                TextButton(
                  onPressed: firebaseRegistration,
                  child: Text(
                    'submit',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void firebaseRegistration() async {
    if (_confirmPwdController.text == _passwordController.text) {
      _registerFormKey.currentState!.validate();
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text)
            .then((value) {
          FirebaseFirestore.instance
              .collection("Users")
              .doc(value.user!.uid)
              .set({
            "firstName": _firstNameController.text,
            "lastName": _lastNameController.text,
            "email": value.user!.email,
            "phoneNumber": _phoneNumberController.text,
            "gender": genderValue,
          });
        }).then((value) => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
                (_) => false));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      AlertDialog alert = AlertDialog(
        title: Text("Passwords doesn't match"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"))
        ],
        content: Text("It is the body of the alert Dialog"),
      );
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return alert;
          });
    }
  }
}
