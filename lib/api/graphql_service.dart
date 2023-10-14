import 'dart:async';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:prueba_64/api/api_models.dart';
import 'package:prueba_64/utils/graphql_config.dart';

class GraphQlService {
  static GraphQlConfig graphQlConfig = GraphQlConfig();
  GraphQLClient client = graphQlConfig.client;

  FutureOr<LoginResponse> login(
      {required String cardId, required String password}) async {
    try {
      QueryResult result = await client.mutate(MutationOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: gql(''' 
              mutation Login(\$cardId: String!, \$password: String!){
                login(cardId: \$cardId, password: \$password)
                  {
                    token,
                    tokenType
                  }
                } 
            '''),
        variables: {"cardId": cardId, "password": password},
      ));

      if (result.hasException) {
        print("una excepcion");
        if (result.exception!.graphqlErrors[0].message ==
            "Invalid credentials") {
          return LoginResponse(token: "", tokenType: "");
        }
        throw result.exception!;
      }

      LoginResponse response =
          LoginResponse.fromMap(map: result.data!['login']);
      print("hay respuesta");
      return response;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }
}
