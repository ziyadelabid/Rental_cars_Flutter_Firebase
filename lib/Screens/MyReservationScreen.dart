import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyReservationsScreen extends StatefulWidget {
  final String? userId;
  MyReservationsScreen(this.userId);

  @override
  State<MyReservationsScreen> createState() => _MyReservationsScreenState();
}

class _MyReservationsScreenState extends State<MyReservationsScreen> {
  final Stream<QuerySnapshot> _reservationStream =
      FirebaseFirestore.instance.collection('Reservations').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: _reservationStream,
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
              return ListTile(
                title: Text(data['brandR']),
                subtitle: Text(data['modelYearR']),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
