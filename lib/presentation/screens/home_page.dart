import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/api/graphql_service.dart';
import 'package:prueba_64/presentation/screens/all_appointments.dart';
import 'package:prueba_64/presentation/widgets/appointments_widget.dart';
import 'package:prueba_64/utils/graphql_config.dart';
import 'package:prueba_64/presentation/screens/search_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.token, required this.tokenType});
  final String token;
  final String tokenType;
  final GraphQLClient client = GraphQlConfig.createAuthClient("", "");

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
        await GraphQlService().getBookedAppointments(client: client);

    print(_appointmentResponse?[0].doctor.specialty.toString());
    setState(() {});

    return _appointmentResponse!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              SafeArea(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width > 800
                                      ? MediaQuery.of(context).size.width / 3
                                      : null,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Welcome Back!",
                                          style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .fontSize,
                                              fontWeight: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge!
                                                  .fontWeight,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary)),
                                      Text("Schedule By Specialty",
                                          style: TextStyle(
                                              fontSize: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .fontSize,
                                              fontWeight: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .fontWeight,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary)),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 2,
                                            fixedSize: const Size(250, 60),
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            textStyle: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SearchResultsPage(
                                                            specialty: Specialty
                                                                .Anesthesiology,
                                                            token: widget.token,
                                                            tokenType: widget
                                                                .tokenType)));
                                          },
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Search by Specialty",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              SizedBox(width: 10),
                                              Icon(
                                                Icons.search,
                                                color: Colors.white,
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Pending Appointments",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  AppointmentWidget(
                    appointmentResponse: _appointmentResponse!,
                    token: widget.token,
                    tokenType: widget.tokenType,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        textStyle: Theme.of(context).textTheme.titleSmall,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllAppointments(
                                  token: widget.token,
                                  tokenType: widget.tokenType,
                                  )),
                        );
                      },
                      child: const Text(
                        "See all appointments",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ));
  }
}
