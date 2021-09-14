import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location_voitures/Screens/HomeScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:location_voitures/Screens/SignUpScreen.dart';
import 'package:location_voitures/Screens/VehicleScreen.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
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
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(top: heightDevice * 0.10),
              child: Column(children: [
                Text(
                  "Sign In",
                  style: TextStyle(
                    color: Color(0XFF091424),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoMono',
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Enter your credentials to continue",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 23,
                      color: Color(0XFF091424),
                      fontFamily: 'RobotoMono',
                    ),
                  ),
                )
              ]),
            ),
            Container(
                margin: EdgeInsets.only(top: heightDevice * 0.05),
                child: Lottie.asset('assets/animations/car-animation.json')),
            Container(
              margin: EdgeInsets.only(top: heightDevice * 0.02),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.email,
                                size: 28,
                              )),
                          SizedBox(
                            width: widthDevice * 0.7,
                            child: TextFormField(
                              decoration: InputDecoration(hintText: "Email"),
                              keyboardType: TextInputType.emailAddress,
                              validator: emailValidator,
                              controller: _emailController,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: heightDevice * 0.02),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5, right: 10),
                            child: Icon(
                              Icons.security,
                              size: 28,
                            ),
                          ),
                          SizedBox(
                            width: widthDevice * 0.7,
                            child: TextFormField(
                              decoration: InputDecoration(hintText: "Password"),
                              controller: _passwordController,
                              validator: pwdValidator,
                              obscureText: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: widthDevice * 0.1),
                      child: SizedBox(
                        width: widthDevice * 0.8,
                        height: heightDevice * 0.09,
                        child: TextButton(
                          onPressed: firebaseSignIn,
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'RobotoMono',
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: widthDevice * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You don't have an account ! ",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'RobotoMono',
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpScreen()));
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontFamily: 'RobotoMono',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

//Connexion par email/mot de passe
  void firebaseSignIn() async {
    _loginFormKey.currentState!.validate();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text)
          .then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => VehicleScreen()),
            (_) => false);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

//Connexion par Google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Connexion par Facebook
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeScreen()));
    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
