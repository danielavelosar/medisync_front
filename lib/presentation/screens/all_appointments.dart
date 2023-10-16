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
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: _appointmentResponse == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.7),
                              Colors.white,
                            ],
                          ),
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30))),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            image: MediaQuery.of(context).size.width > 800
                                ? const DecorationImage(
                                    image: AssetImage(
                                        'lib/assets/images/logo_blanco_medisync.png'),
                                    fit: BoxFit.contain,
                                  )
                                : null),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width > 400
                                      ? 20
                                      : 0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "All Appointments",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppointmentWidget(
                    appointmentResponse: _appointmentResponse!,
                    token: widget.token,
                    tokenType: widget.tokenType,
                  ),
                ],
              ));
  }
}
