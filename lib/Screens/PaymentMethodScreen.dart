import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:location_voitures/Constants/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PaymentMethods { cash, paypal, cheque, visa }

class PaymentMethodScreen extends StatefulWidget {
  final String brand, modelYear, emplacementPrise, imageVoiture;
  final double review;
  final DateTime startDate, endDate;
  final int price, idVoiture, totalMontant, difference;
  PaymentMethodScreen(
      this.brand,
      this.modelYear,
      this.emplacementPrise,
      this.price,
      this.imageVoiture,
      this.idVoiture,
      this.review,
      this.totalMontant,
      this.difference,
      this.startDate,
      this.endDate);

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestoreIns = FirebaseFirestore.instance;
  PaymentMethods? _paymentMethod = PaymentMethods.cash;
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0XFF78000a),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: widthDevice * 0.05),
                child: Text(
                  "Total : " + widget.totalMontant.toString() + " Dhs",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: SizedBox(
                  height: heightDevice * 0.1,
                  width: widthDevice * 0.5,
                  child: TextButton(
                    onPressed: _addReservation,
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.only(topLeft: Radius.circular(25))),
                    ),
                  ),
                ),
              )
            ],
          ),
          height: 60,
          width: double.maxFinite,
        ),
      ),
      appBar: AppBar(backgroundColor: primaryColor, elevation: 0, actions: [
        Container(
            margin: EdgeInsets.only(right: widthDevice * 0.03),
            child: Icon(Icons.more_horiz, size: 22)),
      ]),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              height: heightDevice * 0.32,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: heightDevice * 0.01, left: widthDevice * 0.05),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.brand,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: heightDevice * 0.01),
                                  child: Text(
                                    widget.modelYear,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                ),
                              ]),
                          Container(
                            margin: EdgeInsets.only(right: widthDevice * 0.05),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: widthDevice * 0.02),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellowAccent,
                                    size: 22,
                                  ),
                                ),
                                Text(
                                  widget.review.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 22),
                                ),
                              ],
                            ),
                          )
                        ]),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/" + widget.imageVoiture.toString(),
                      height: heightDevice * 0.2,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: heightDevice * 0.03, left: widthDevice * 0.08),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Payment Method",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: heightDevice * 0.04),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Cash'),
                    leading: Radio<PaymentMethods>(
                      value: PaymentMethods.cash,
                      groupValue: _paymentMethod,
                      onChanged: (PaymentMethods? value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.cashRegister,
                          color: Color(0XFF006535),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Paypal'),
                    leading: Radio<PaymentMethods>(
                      value: PaymentMethods.paypal,
                      groupValue: _paymentMethod,
                      onChanged: (PaymentMethods? value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.paypal,
                          color: Color(0XFF0D367F),
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Cheque'),
                    leading: Radio<PaymentMethods>(
                      value: PaymentMethods.cheque,
                      groupValue: _paymentMethod,
                      onChanged: (PaymentMethods? value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.check,
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                  ListTile(
                    title: const Text('Visa'),
                    leading: Radio<PaymentMethods>(
                      value: PaymentMethods.visa,
                      groupValue: _paymentMethod,
                      onChanged: (PaymentMethods? value) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      },
                    ),
                    trailing: Wrap(
                      spacing: 12,
                      children: <Widget>[
                        FaIcon(
                          FontAwesomeIcons.ccVisa,
                          color: Color(0XFF0C1A6B),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _addReservation() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    firestoreIns.collection("Reservations").doc().set({
      "idUser": uid,
      "idVehicle": widget.idVoiture,
      "brandR": widget.brand,
      "modelYearR": widget.modelYear,
      "imageVoitureR": widget.imageVoiture,
      "dateReservation": widget.startDate,
      "dateRetour": widget.endDate,
      "montantTotal": widget.totalMontant,
      "paymentMethod": _paymentMethod.toString().split('.').last,
      "approved": false,
      "reviewR": widget.review,
    }).then((value) {
      confirmDialog(context);
    }).onError((error, stackTrace) {
      errorDialog(context);
    });
  }

  confirmDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.white,
      content: SizedBox(
        height: 150,
        width: 200,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.check,
                color: Colors.green,
                size: 60,
              ),
              Text(
                "Confirmed Successfully",
                style: TextStyle(
                  fontFamily: principalFont,
                  fontSize: 20,
                ),
              ),
            ]),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  errorDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Simple Alert"),
      content: Text("Error ! Check your network connection"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
