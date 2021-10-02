import 'package:flutter/material.dart';
import 'package:location_voitures/Constants/constants.dart';
import 'package:location_voitures/Screens/PaymentMethodScreen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class ReservationScreen extends StatefulWidget {
  final String brand, modelYear, emplacementPrise, imageVoiture;
  final double review;

  final int price, idVoiture;
  ReservationScreen(this.brand, this.modelYear, this.emplacementPrise,
      this.price, this.imageVoiture, this.idVoiture, this.review);

  @override
  _ReservationScreenState createState() => _ReservationScreenState();
}

class _ReservationScreenState extends State<ReservationScreen> {
  String _range = '', _startReservationDate = '', _endReservationDate = '';
  int difference = 0, totalMontant = 0;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

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
                  "Total : " + totalMontant.toString() + " Dhs",
                  style: TextStyle(
                    fontSize: 18,
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
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentMethodScreen(
                                  widget.brand,
                                  widget.modelYear,
                                  widget.emplacementPrise,
                                  widget.price,
                                  widget.imageVoiture,
                                  widget.idVoiture,
                                  widget.review,
                                  totalMontant,
                                  difference,
                                  startDate,
                                  endDate)));
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(
                          fontSize: 20,
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
                    top: heightDevice * 0.02, left: widthDevice * 0.05),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Reservation Days",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ))),
            Container(
              margin: EdgeInsets.only(top: heightDevice * 0.02),
              child: SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        startDate = DateTime.parse(
            DateFormat('yyyy-MM-dd').format(args.value.startDate));
        endDate = DateTime.parse(DateFormat('yyyy-MM-dd')
            .format(args.value.endDate ?? args.value.startDate));

        difference = endDate.difference(startDate).inDays + 1;
        totalMontant = widget.price * difference;
        _startReservationDate =
            DateFormat('yyyy-MM-dd').format(args.value.startDate).toString();
        _endReservationDate = DateFormat('yyyy-MM-dd')
            .format(args.value.endDate ?? args.value.startDate)
            .toString();

        _range = _startReservationDate + ' - ' + _endReservationDate;
        print(_range);
      }
    });
  }
}
