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
    final GraphQLClient _client =
        GraphQlConfig.createAuthClient(widget.token, widget.tokenType);
    _renderAppointments(_client);
  }
  
  List<BookedAppointment>? _appointmentResponse;


void _renderAppointments(GraphQLClient client) 
  async {
    _appointmentResponse = null;
    _appointmentResponse =
        await GraphQlService().getBookedAppointments(client: client);
        
    print(_appointmentResponse);
    
    setState(() {});
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Token: ${widget.token}',
                ),
                Text(
                  'TokenType: ${widget.tokenType}',
                ),
                
              ],
            ),
          ),
        ]));
  }
}
