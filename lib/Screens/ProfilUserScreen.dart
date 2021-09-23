import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location_voitures/Constants/constants.dart';
import 'package:location_voitures/Screens/VehicleScreen.dart';

class ProfilUserScreen extends StatefulWidget {
  final String firstName, lastName, phoneNumber, gender;
  final String? userEmail, userId;

  ProfilUserScreen(this.userEmail, this.userId, this.firstName, this.lastName,
      this.phoneNumber, this.gender);

  @override
  _ProfilUserScreenState createState() => _ProfilUserScreenState();
}

class _ProfilUserScreenState extends State<ProfilUserScreen> {
  var db = FirebaseFirestore.instance;
  late var _emailController =
      TextEditingController(text: widget.userEmail.toString());
  late var _firstNameController =
      TextEditingController(text: widget.firstName.toString());
  late var _lastNameController =
      TextEditingController(text: widget.lastName.toString());
  late var _phoneNumberController =
      TextEditingController(text: widget.phoneNumber.toString());

  late String genderValue = "male";
  var items = ["male", "female"];

  final GlobalKey<FormState> _editProfilForm = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Stack(
          children: [
            Container(
              height: heightDevice * 0.3,
              decoration: BoxDecoration(color: primaryColor),
              child: Container(
                margin: EdgeInsets.only(top: heightDevice * 0.08),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: widthDevice * 0.05),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          bottom: heightDevice * 0.02,
                          left: widthDevice * 0.05),
                      child: Text(
                        "Profile",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: widthDevice * 0.05),
                      child: TextButton(
                        onPressed: editProfil,
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: heightDevice * 0.20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(45),
                  topRight: Radius.circular(45),
                ),
              ),
              child: Form(
                key: _editProfilForm,
                child: Container(
                  width: widthDevice,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: widthDevice * 0.1, top: heightDevice * 0.06),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "First Name",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )),
                      ),
                      Container(
                        width: widthDevice * 0.8,
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "John"),
                          controller: _firstNameController,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: widthDevice * 0.1, top: heightDevice * 0.04),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Last Name",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )),
                      ),
                      Container(
                        width: widthDevice * 0.8,
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "Doe"),
                          controller: _lastNameController,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: widthDevice * 0.1, top: heightDevice * 0.04),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )),
                      ),
                      Container(
                        width: widthDevice * 0.8,
                        child: TextFormField(
                          decoration:
                              InputDecoration(hintText: "john.doe@gmail.com"),
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: widthDevice * 0.1, top: heightDevice * 0.04),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone Number",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )),
                      ),
                      Container(
                        width: widthDevice * 0.8,
                        child: TextFormField(
                          controller: _phoneNumberController,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: widthDevice * 0.1, top: heightDevice * 0.04),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Gender",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15),
                            )),
                      ),
                      Container(
                        width: widthDevice * 0.8,
                        child: DropdownButton(
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
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  void editProfil() async {
    await db.collection("Users").doc(widget.userId).set({
      "firstName": _firstNameController.text,
      "lastName": _lastNameController.text,
      "email": _emailController.text,
      "phoneNumber": _phoneNumberController.text,
      "gender": genderValue,
    }).then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => VehicleScreen()),
          (_) => false);
    });
  }
}
