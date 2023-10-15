import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/api/graphql_service.dart';
import 'package:prueba_64/presentation/screens/create_appointment_page.dart';
import 'package:prueba_64/presentation/widgets/appointments_widget.dart';
import 'package:prueba_64/utils/graphql_config.dart';
import 'package:prueba_64/presentation/screens/search_page.dart';
import 'package:prueba_64/presentation/widgets/dropdown_specialties.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.token, required this.tokenType});
  final String token;
  final String tokenType;
  final GraphQLClient _client = GraphQlConfig.createAuthClient("", "");

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    final GraphQLClient _client =
        GraphQlConfig.createAuthClient(widget.token, widget.tokenType);
    _renderAppointments(_client);
  }

  List<BookedAppointment>? _appointmentResponse;

  Future<List<BookedAppointment>> _renderAppointments(_client) async {
    _appointmentResponse = null;
    _appointmentResponse =
        await GraphQlService().getBookedAppointments(client: _client);

    print(_appointmentResponse?[0].doctor.specialty.toString());
    setState(() {});

    return _appointmentResponse!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Token: ${widget.token}'),
        ),
        body: _appointmentResponse == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchResultsPage(
                                    specialty: Specialty.Anesthesiology)));
                      },
                      child: const Text("Search By Specialty")),
                  const Text("Appointments"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateAnAppointmentPage(
                                  token: widget.token,
                                  tokenType: widget.tokenType,
                                  doctorId: -35,
                                  date: "2023-10-13",
                                  timeBlockId: 1)),
                        );
                      },
                      child: const Text("create an appointment")),
                  AppointmentWidget(
                    appointmentResponse: _appointmentResponse!,
                    token: widget.token,
                    tokenType: widget.tokenType,
                  ),
                ],
              ));
  }
}
