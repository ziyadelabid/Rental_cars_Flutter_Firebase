import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:location_voitures/Screens/LoginScreen.dart';

class DrawerUser extends StatefulWidget {
  const DrawerUser({Key? key}) : super(key: key);

  @override
  _DrawerUserState createState() => _DrawerUserState();
}

class _DrawerUserState extends State<DrawerUser> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  String? userEmail = "", userId = "";
  String firstName = "", lastName = "";

  @override
  void initState() {
    doSomeAsyncStuff();

    super.initState();
  }

  Future<void> doSomeAsyncStuff() async {
    User? user = _auth.currentUser;
    setState(() {
      userEmail = user!.email;
      userId = user.uid;
    });
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          lastName = documentSnapshot.get("lastName");
        });
        print('Document data: ${documentSnapshot.get("lastName")}');
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          new UserAccountsDrawerHeader(
            accountName: Text(
              lastName,
              style: TextStyle(color: Colors.red),
            ),
            accountEmail: Text(
              userEmail!,
              style: TextStyle(color: Colors.red),
            ),
            decoration: BoxDecoration(color: Colors.white),
            currentAccountPicture: new CircleAvatar(
              radius: 50.0,
              backgroundColor: const Color(0xFF778899),
              backgroundImage:
                  NetworkImage("http://tineye.com/images/widgets/mona.jpg"),
            ),
          ),
          ListTile(
            title: const Text('My Reservations'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('All Cars'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Report'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Profil'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            onPressed: signOutFromGoogle,
            child: Text("Log Out"),
          )
        ],
      ),
    );
  }

  Future<void> signOutFromGoogle() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginScreen()), (_) => false);
  }
}
