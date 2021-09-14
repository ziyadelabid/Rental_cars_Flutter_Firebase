import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:location_voitures/Controllers/vehicleController.dart';
import 'package:location_voitures/Drawers/DrawerUser.dart';
import 'package:location_voitures/Screens/DetailsVehicleScreen.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({Key? key}) : super(key: key);

  @override
  _VehicleScreenState createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final CollectionReference vehiclesList =
      FirebaseFirestore.instance.collection('Vehicles');
  List vehicleList = [];

  fetchSpecialVehicles() async {
    dynamic result;
    if (changeWidget == "") {
      result = await VehicleController().getVehiclesList();
    } else {
      result = await getSpecificVehicle();
    }
    if (result == null) {
      print("unenable to retrieve data");
    } else {
      setState(() {
        vehicleList = result;
      });
    }
  }

  Future getSpecificVehicle() async {
    List vehicleList = [];
    try {
      await vehiclesList
          .where("brand", isEqualTo: changeWidget)
          .get()
          .then((value) => value.docs.forEach((element) {
                vehicleList.add(element);
              }));
      return vehicleList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  var changeWidget = "";
  @override
  void initState() {
    fetchSpecialVehicles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: Colors.red),
      drawer: DrawerUser(),
      backgroundColor: Color(0XFFf2f2f2),
      body: Container(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(children: [
            Container(
              color: Colors.red,
              height: 200,
              child: Center(
                child: Text(
                  "Promotions",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: heightDevice * 0.02),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: widthDevice * 0.03),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Brands",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                changeWidget = "";
                                fetchSpecialVehicles();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: widthDevice * 0.03,
                                  top: heightDevice * 0.015),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(25)),
                              width: 70,
                              height: 70,
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "All",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                changeWidget = "Bmw";
                                fetchSpecialVehicles();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: widthDevice * 0.03,
                                  top: heightDevice * 0.015),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(25)),
                              width: 70,
                              height: 70,
                              child: Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  "assets/Icons/bmwIcon.svg",
                                  color: Colors.white,
                                  height: 45,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                changeWidget = "Audi";
                                fetchSpecialVehicles();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: widthDevice * 0.03,
                                  top: heightDevice * 0.015),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(25)),
                              width: 70,
                              height: 70,
                              child: Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  "assets/Icons/audiIcon.svg",
                                  color: Colors.white,
                                  height: 45,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              fetchSpecialVehicles();
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: widthDevice * 0.03,
                                  top: heightDevice * 0.015),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(25)),
                              width: 70,
                              height: 70,
                              child: Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  "assets/Icons/mercedesIcon.svg",
                                  color: Colors.white,
                                  height: 45,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                changeWidget = "Maserati";
                                fetchSpecialVehicles();
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: widthDevice * 0.03,
                                top: heightDevice * 0.015,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(25)),
                              width: 70,
                              height: 70,
                              child: Align(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  "assets/Icons/maseratiIcon.svg",
                                  color: Colors.white,
                                  height: 45,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: heightDevice * 0.06,
                      left: widthDevice * 0.03,
                      right: widthDevice * 0.03,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Available Cars",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Icon(
                            Icons.image_search,
                            size: 24,
                          ),
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: heightDevice * 0.02,
                    ),
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: vehicleList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(
                              top: heightDevice * 0.01,
                              left: widthDevice * 0.04,
                              bottom: heightDevice * 0.01,
                              right: widthDevice * 0.04),
                          height: heightDevice * 0.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(35),
                          ),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      "assets/images/" +
                                          vehicleList[index]['imageVoiture']
                                              .toString(),
                                      height: heightDevice * 0.11,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        bottom: heightDevice * 0.02,
                                      ),
                                      child: Text(
                                        vehicleList[index]['price'].toString() +
                                            "\$/day",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: widthDevice * 0.04,
                                    top: heightDevice * 0.02495,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                          right: widthDevice * 0.01,
                                        ),
                                        child: Column(children: [
                                          Text(
                                            vehicleList[index]['brand']
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'RobotoMono',
                                            ),
                                          ),
                                          Text(
                                            vehicleList[index]['modelYear']
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontFamily: 'RobotoMono',
                                            ),
                                          ),
                                        ]),
                                      ),
                                      SizedBox(
                                        height: heightDevice * 0.06,
                                        width: widthDevice * 0.385,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsVehicleScreen(
                                                            vehicleList[index]
                                                                ['brand'],
                                                            vehicleList[index]
                                                                ['modelYear'],
                                                            vehicleList[index]
                                                                ['review'],
                                                            vehicleList[index]
                                                                ['carburant'],
                                                            vehicleList[index][
                                                                'boiteVitesse'],
                                                            vehicleList[index]
                                                                ['speed'],
                                                            vehicleList[index][
                                                                'emplacementPrise'],
                                                            vehicleList[index]
                                                                ['price'],
                                                            vehicleList[index][
                                                                'imageVoiture'])));
                                          },
                                          child: Text(
                                            "Details",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(25))),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
