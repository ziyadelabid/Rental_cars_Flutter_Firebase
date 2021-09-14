import 'package:cloud_firestore/cloud_firestore.dart';

class VehicleController {
  final CollectionReference vehiclesList =
      FirebaseFirestore.instance.collection('Vehicles');
  Future getVehiclesList() async {
    List vehicleList = [];
    try {
      await vehiclesList.get().then((value) => value.docs.forEach((element) {
            vehicleList.add(element);
          }));
      return vehicleList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
