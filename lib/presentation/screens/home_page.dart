import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/api/graphql_service.dart';
import 'package:prueba_64/utils/graphql_config.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.token, required this.tokenType});
  final String token;
  final String tokenType;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    _renderAppointments();
  }

  List<BookedAppointment>? _appointmentResponse;

  Future<List<BookedAppointment>> _renderAppointments() async {
    final GraphQLClient _client =
        GraphQlConfig.createAuthClient(widget.token, widget.tokenType);
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
        body: Column(children: <Widget>[
          Center(
            child: FutureBuilder(
              future: _renderAppointments(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print(snapshot.data!.length);
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        print(
                            "snapshot.data![index].doctor.specialty.toString()");
                        return Card(
                          child: Text(snapshot.data![index].doctor.specialty
                              .toString()),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ]));
  }
}
