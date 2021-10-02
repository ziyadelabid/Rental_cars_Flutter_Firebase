import 'package:flutter/material.dart';
import 'package:location_voitures/Constants/constants.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  TextEditingController _reportMessageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              child: Container(
                child: TextFormField(
                  decoration: InputDecoration(hintText: ""),
                  keyboardType: TextInputType.emailAddress,
                  controller: _reportMessageController,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Send",
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Color(0XFF1E4240),
              ),
            )
          ],
        ),
      ),
    );
  }
}
