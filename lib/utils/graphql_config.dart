import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlConfig {
  static HttpLink url =
      HttpLink('https://mock-api-gateway-production.up.railway.app/graphql');
  GraphQLClient client = GraphQLClient(
    link: url,
    cache: GraphQLCache(),
  );
}
