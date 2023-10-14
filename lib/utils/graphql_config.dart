import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlConfig {
  static HttpLink url = HttpLink('http://localhost:5555/graphql/');
  GraphQLClient client = GraphQLClient(
    link: url,
    cache: GraphQLCache(),
  );
}
