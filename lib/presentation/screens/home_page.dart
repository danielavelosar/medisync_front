import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/api/graphql_service.dart';
import 'package:prueba_64/presentation/screens/all_appointments.dart';
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
        body: _appointmentResponse == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                    maxHeight: MediaQuery.of(context).size.height),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      DecoratedBox(
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
                            image: MediaQuery.of(context).size.width > 1000
                                ? DecorationImage(
                                    image: const AssetImage(
                                        'lib/assets/images/doctor3.png'),
                                    fit: BoxFit.contain,
                                    alignment: Alignment.bottomRight,
                                  )
                                : null,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment:
                              MediaQuery.of(context).size.width > 1000
                                  ? MainAxisAlignment.spaceBetween
                                  : MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MediaQuery.of(context).size.width > 1000
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width >
                                              800
                                          ? 50
                                          : MediaQuery.of(context).size.width >
                                                  400
                                              ? 20
                                              : 0),
                                  SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        MediaQuery.of(context).size.width > 800
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: const SizedBox(
                                                    height: 120,
                                                    width: 200,
                                                    child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                        image: AssetImage(
                                                            'lib/assets/images/medisync_logo_azul.png'),
                                                        fit: BoxFit.contain,
                                                        alignment:
                                                            Alignment.center,
                                                      )),
                                                    )),
                                              )
                                            : SizedBox(
                                                height: 20,
                                              ),
                                        Text("Welcome Back!",
                                            style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        800
                                                    ? 60
                                                    : 30,
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
                                        SizedBox(
                                            height: MediaQuery.of(context)
                                                        .size
                                                        .width >
                                                    800
                                                ? 5
                                                : 20),
                                        SizedBox(
                                          child: DropdownSpecialties(
                                            token: widget.token,
                                            tokenType: widget.tokenType,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.width > 800
                                  ? 20
                                  : 10),
                          Text(
                            "Pending Appointments",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.width > 800
                                  ? 20
                                  : 10),
                          ConstrainedBox(
                            constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height / 4,
                                maxHeight:
                                    MediaQuery.of(context).size.height > 600
                                        ? 200
                                        : 150),
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding:
                                        MediaQuery.of(context).size.width > 800
                                            ? const EdgeInsets.symmetric(
                                                horizontal: 100)
                                            : const EdgeInsets.symmetric(
                                                horizontal: 30),
                                    child: AppointmentWidget(
                                      appointmentResponse:
                                          _appointmentResponse!,
                                      token: widget.token,
                                      tokenType: widget.tokenType,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                                textStyle:
                                    Theme.of(context).textTheme.titleSmall,
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
                              child: SizedBox(
                                height: 50,
                                width: MediaQuery.of(context).size.width > 800
                                    ? 300
                                    : 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: const Text(
                                      "All my appointments",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
  }
}
