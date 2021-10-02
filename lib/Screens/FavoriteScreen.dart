import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:location_voitures/Constants/constants.dart';
import 'package:location_voitures/Screens/DetailsVehicleScreen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Stream<QuerySnapshot> _favoriteStream = FirebaseFirestore.instance
      .collection('Vehicles')
      .where('favorite', isEqualTo: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0XFFF3F3F4),
      appBar: AppBar(
        title: Text("My Favorites"),
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _favoriteStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              return Container(
                margin: EdgeInsets.only(
                    top: heightDevice * 0.01,
                    left: widthDevice * 0.04,
                    bottom: heightDevice * 0.01,
                    right: widthDevice * 0.04),
                height: heightDevice * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 0.5,
                      spreadRadius: 0.0,
                      offset:
                          Offset(2.0, 2.0), // shadow direction: bottom right
                    )
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 10, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/" + data['imageVoiture'].toString(),
                            height: heightDevice * 0.11,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: heightDevice * 0.02,
                            ),
                            child: Text(
                              data['price'].toString() + " Dhs" + "/day",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                right: widthDevice * 0.01,
                              ),
                              child: Column(children: [
                                Text(
                                  data['brand'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'RobotoMono',
                                  ),
                                ),
                                Text(
                                  data['modelYear'].toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontFamily: 'RobotoMono',
                                  ),
                                ),
                              ]),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  height: heightDevice * 0.06,
                                  width: widthDevice * 0.385,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetailsVehicleScreen(
                                              data['brand'],
                                              data['modelYear'],
                                              data['review'],
                                              data['carburant'],
                                              data['boiteVitesse'],
                                              data['speed'],
                                              data['emplacementPrise'],
                                              data['price'],
                                              data['imageVoiture'],
                                              data['idVoiture'],
                                              data['favorite'],
                                              data['power'],
                                            ),
                                          ));
                                    },
                                    child: Text(
                                      "Details",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    style: TextButton.styleFrom(
                                      backgroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        bottomRight: Radius.circular(25),
                                      )),
                                    ),
                                  ),
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
            }).toList(),
          );
        },
      ),
    );
  }
}
