import 'package:flutter/material.dart';
import 'package:prueba_64/presentation/screens/home_page.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/api/graphql_service.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _cardIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  LoginResponse? _loginResponse;
  String _error = "";


  void _loginButtonAction(String cardId, String password) 
  async {
    _loginResponse = null;
    _loginResponse =
        await GraphQlService().login(cardId: cardId, password: password);
        
    if (_loginResponse!.token == "") {
      // TODO: show error
      _error = "Invalid credentials";
      _loginResponse = null;
    }
    else if (_loginResponse == null) {
    }
    else {
      print("correct credentials");
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(
            token: _loginResponse!.token,
            tokenType: _loginResponse!.tokenType,
          ),
        ),
      );
    }
    setState(() {});
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_error != "")
                Text(
                  _error,
                  style: const TextStyle(color: Colors.red),
                ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _cardIdController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CardId',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: ElevatedButton(
                  onPressed: () {
                    _loginButtonAction(
                        _cardIdController.text, _passwordController.text);
                  },
                  child: const Text('Login'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}