import 'package:flutter/material.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba_64/api/graphql_service.dart';
import 'package:prueba_64/presentation/widgets/appointments_widget.dart';
import 'package:prueba_64/presentation/widgets/available_appo_widget.dart';
import 'package:prueba_64/utils/graphql_config.dart';
import 'package:intl/intl.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage(
      {super.key,
      required this.specialty,
      required this.token,
      required this.tokenType});
  final Specialty specialty;
  final String token;
  final String tokenType;

  @override
  State<SearchResultsPage> createState() => _SearchResultPage();
}

class _SearchResultPage extends State<SearchResultsPage> {
  @override
  void initState() {
    super.initState();
    _getAvailableAppointments();
  }

  List<AvailableAppointment>? _availableAppointmentResponse;

  Future<List<AvailableAppointment>> _getAvailableAppointments() async {
    print("cargando citas disponibles");
    final GraphQLClient client =
        GraphQlConfig.createAuthClient(widget.token, widget.tokenType);

    // Format the date as "yyyy-MM-dd"
    final nowFormattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final laterFormattedDate = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(const Duration(days: 7)));

    // Convert the formatted date to a string
    final nowDateString = nowFormattedDate.toString();
    final laterDateString = laterFormattedDate.toString();

    _availableAppointmentResponse = null;
    _availableAppointmentResponse = await GraphQlService()
        .getAvailableAppointments(
            client: client,
            specialty: widget.specialty.toString().split(".")[1],
            startDate: nowDateString,
            endDate: laterDateString);

    setState(() {});

    return _availableAppointmentResponse!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: _availableAppointmentResponse == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text("Appointments",
                        style: Theme.of(context).textTheme.titleLarge),
                    Text("by ${widget.specialty.toString().split(".")[1]}",
                        style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: AvailableAppointmentWidget(
                          appointmentResponse: _availableAppointmentResponse!,
                          token: widget.token,
                          tokenType: widget.tokenType),
                    ),
                  ],
                ),
              ));
  }
}
