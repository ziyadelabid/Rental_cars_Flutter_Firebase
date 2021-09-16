import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
                  "Total : " + widget.totalMontant.toString() + "DH",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 58,
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
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(25))),
                  ),
                ),
              )
            ],
          ),
          height: 60,
          width: double.maxFinite,
        ),
      ),
      appBar: AppBar(backgroundColor: Colors.black, elevation: 0, actions: [
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
                color: Colors.black,
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
                    top: heightDevice * 0.02, left: widthDevice * 0.05),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Payment Method",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ))),
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
      "dateReservation ": widget.startDate,
      "dateRetour": widget.endDate,
      "montantTotal": widget.totalMontant,
      "paymentMethod": "Cash",
      "reservationStatus": "not approved",
    });
  }
}
