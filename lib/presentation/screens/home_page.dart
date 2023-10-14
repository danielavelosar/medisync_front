import 'package:flutter/material.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/api/graphql_service.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.token, required this.tokenType});
  final String token;
  final String tokenType;
  
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: non_constant_identifier_names
  LoginResponse? _login_response;

  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Token: ${widget.token}'),
        ),
        body: SafeArea(
          child: _login_response == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Token: ${_login_response!.token}',
                      ),
                      Text(
                        'TokenType: ${_login_response!.tokenType}',
                      ),
                    ],
                  ),
                ),
        ));
  }
}
