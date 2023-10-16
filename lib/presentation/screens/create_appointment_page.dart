import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba_64/api/graphql_service.dart';
import 'package:prueba_64/utils/graphql_config.dart';

// ignore: must_be_immutable
class CreateAnAppointmentPage extends StatefulWidget {
  const CreateAnAppointmentPage(
      {super.key,
      required this.token,
      required this.tokenType,
      required this.doctorId,
      required this.date,
      required this.timeBlockId});

  final String token;
  final String tokenType;
  final int doctorId;
  final String date;
  final int timeBlockId;
  @override
  State<CreateAnAppointmentPage> createState() =>
      _CreateAnAppointmentPageState();
}

class _CreateAnAppointmentPageState extends State<CreateAnAppointmentPage> {
  bool isCreated = false;

  @override
  void initState() {
    super.initState();
    _createAppointment();
  }

  Future<bool> _createAppointment() async {
    final GraphQLClient client =
        GraphQlConfig.createAuthClient(widget.token, widget.tokenType);
    isCreated = await GraphQlService().createAppointment(
        client: client,
        doctorId: widget.doctorId,
        date: widget.date,
        timeBlockId: widget.timeBlockId);

    setState(() {});
    return isCreated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create an appointment"),
        ),
        body: Center(
          child: isCreated == true
              ? Text("Appointment created")
              : Text("Appointment not created"),
        ));
  }
}
