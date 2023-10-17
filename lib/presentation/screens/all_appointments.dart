import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/api/graphql_service.dart';
import 'package:prueba_64/presentation/screens/create_appointment_page.dart';
import 'package:prueba_64/presentation/widgets/appointments_widget.dart';
import 'package:prueba_64/utils/graphql_config.dart';
import 'package:prueba_64/presentation/screens/search_page.dart';

class AllAppointments extends StatefulWidget {
  AllAppointments({super.key, required this.token, required this.tokenType});
  final String token;
  final String tokenType;
  final GraphQLClient client = GraphQlConfig.createAuthClient("", "");

  @override
  State<AllAppointments> createState() => _AllAppointmentsState();
}

class _AllAppointmentsState extends State<AllAppointments> {
  @override
  void initState() {
    super.initState();
    final GraphQLClient client =
        GraphQlConfig.createAuthClient(widget.token, widget.tokenType);
    _renderAppointments(client);
  }

  List<BookedAppointment>? _appointmentResponse;

  Future<List<BookedAppointment>> _renderAppointments(client) async {
    _appointmentResponse = null;
    _appointmentResponse =
        await GraphQlService().getAppointmentsHistory(client: client);

    setState(() {});

    return _appointmentResponse!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: _appointmentResponse == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "All Appointments",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: AppointmentWidget(
                      appointmentResponse: _appointmentResponse!,
                      token: widget.token,
                      tokenType: widget.tokenType,
                    ),
                  ),
                ],
              ));
  }
}
