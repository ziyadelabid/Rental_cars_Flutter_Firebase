import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationController
{
  final CollectionReference reservations =
      FirebaseFirestore.instance.collection('Reservations');
  Future getReservationsList() async {
    List reservationsList = [];
    try {
      await reservations.where('').get().then((value) => value.docs.forEach((element) {
            reservationsList.add(element);
          }));
      return reservationsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}