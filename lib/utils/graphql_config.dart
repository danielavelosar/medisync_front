import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlConfig {
  static HttpLink url =
      HttpLink('https://mock-api-gateway-production.up.railway.app/graphql');
  GraphQLClient client = GraphQLClient(
    link: url,
    cache: GraphQLCache(),
  );

  static GraphQLClient createAuthClient(String token, String tokenType) {
    final AuthLink authLink = AuthLink(getToken: () async {
      return '$tokenType $token';
    });

    final Link link = authLink.concat(url);

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }
}
