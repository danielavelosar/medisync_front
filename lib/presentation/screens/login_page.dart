import 'package:flutter/material.dart';
import 'package:prueba_64/presentation/screens/create_appointment_page.dart';
import 'package:prueba_64/presentation/screens/home_page.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/api/graphql_service.dart';
import 'package:prueba_64/presentation/widgets/dropdown_specialties.dart';

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

  void _loginButtonAction(String cardId, String password) async {
    _loginResponse = null;
    _loginResponse =
        await GraphQlService().login(cardId: cardId, password: password);

    if (_loginResponse!.token == "") {
      // TODO: show error
      _error = "Invalid credentials";
      _loginResponse = null;
    } else if (_loginResponse == null) {
    } else {
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
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).colorScheme.secondary,
            Colors.white,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 200,
              width: double.maxFinite,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )),
                  child: Padding(
                    padding:
                        //el padding de 20 a 50 cuando la pantalla es mas grande
                        MediaQuery.of(context).size.width > 400
                            ? const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 20)
                            : const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 30),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: const DecorationImage(
                            image: AssetImage(
                                'lib/assets/images/logo_blanco_medisync.png'),
                            fit: BoxFit.contain,
                          )),
                    ),
                  )),
            ),
            Expanded(
              flex: 7,
              child: SafeArea(
                top: false,
                right: false,
                left: false,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      )),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: MediaQuery.of(context).size.width > 400
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 150, vertical: 10)
                                    : const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 10),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .fontSize,
                                    fontWeight: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .fontWeight,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                          Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                if (_error != "")
                                  Text(
                                    _error,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextField(
                                    controller: _cardIdController,
                                    decoration: InputDecoration(
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                      border: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          )),
                                      labelText: 'CardId',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: TextField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelStyle: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
                                      border: UnderlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary)),
                                      labelText: 'Password',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width > 400
                                      ? MediaQuery.of(context).size.width * 0.4
                                      : MediaQuery.of(context).size.width * 0.8,
                                  height:
                                      MediaQuery.of(context).size.width > 400
                                          ? MediaQuery.of(context).size.height *
                                              0.06
                                          : null,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _loginButtonAction(_cardIdController.text,
                                          _passwordController.text);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      shadowColor: Colors.black,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Text('Login',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
