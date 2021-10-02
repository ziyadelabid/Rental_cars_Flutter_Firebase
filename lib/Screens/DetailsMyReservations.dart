import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:location_voitures/Constants/constants.dart';

class DetailsMyReservations extends StatefulWidget {
  final String brandR,
      modelYearR,
      imageVoitureR,
      dateReservation,
      dateRetour,
      paymentMethod;
  final bool approved;
  final int montantTotal;
  final double reviewR;
  DetailsMyReservations(
      this.brandR,
      this.modelYearR,
      this.imageVoitureR,
      this.dateReservation,
      this.dateRetour,
      this.approved,
      this.montantTotal,
      this.paymentMethod,
      this.reviewR);

  @override
  _DetailsMyReservationsState createState() => _DetailsMyReservationsState();
}

class _DetailsMyReservationsState extends State<DetailsMyReservations> {
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: widget.approved == true ? Colors.green : Colors.red,
        child: Container(
          child: SizedBox(
            height: heightDevice * 0.08,
            child: Center(
              child: Text(
                widget.approved == true ? "Approved" : "Not Approved Yet",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 27,
                  fontFamily: principalFont,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
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
              height: heightDevice * 0.33,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
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
                                  widget.brandR,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26),
                                ),
                                Container(
                                  margin:
                                      EdgeInsets.only(top: heightDevice * 0.01),
                                  child: Text(
                                    widget.modelYearR,
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
                                  widget.reviewR.toString(),
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
                      "assets/images/" + widget.imageVoitureR.toString(),
                      height: heightDevice * 0.2,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: heightDevice * 0.495,
              width: widthDevice,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Container(
                margin: EdgeInsets.only(top: heightDevice * 0.05),
                child: Column(children: [
                  Container(
                    margin: EdgeInsets.only(left: widthDevice * 0.05),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_sharp,
                            color: Colors.white,
                            size: 30,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: widthDevice * 0.03),
                            child: Text(
                              "Reservation Period : ",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: principalFont,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: heightDevice * 0.04),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          widget.dateReservation,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: principalFont,
                            fontSize: 20,
                          ),
                        ),
                        FaIcon(FontAwesomeIcons.arrowRight,
                            size: 30, color: Colors.white),
                        Text(
                          widget.dateRetour,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: principalFont,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: widthDevice * 0.05, top: heightDevice * 0.05),
                    child: Row(
                      children: [
                        Icon(
                          Icons.payment_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: widthDevice * 0.03,
                          ),
                          child: Text(
                            "Payment Method :  " +
                                widget.paymentMethod.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: principalFont,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: widthDevice * 0.05, top: heightDevice * 0.05),
                    child: Row(
                      children: [
                        Icon(
                          Icons.attach_money_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: widthDevice * 0.03,
                          ),
                          child: Text(
                            "Total Amount :  " +
                                widget.montantTotal.toString() +
                                " Dhs",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: principalFont,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
