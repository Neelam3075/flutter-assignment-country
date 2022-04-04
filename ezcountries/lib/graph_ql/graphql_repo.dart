import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlRepo {
  callGraphQl(GraphQlCallbacks callbacks,
      {required String query, Map<String, dynamic>? variable}) async {
    GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: HttpLink('https://countries.trevorblades.com/graphql'),
    );
    QueryResult result = await client.query(
      QueryOptions(
        document: gql(query),
        variables: variable ?? {},
      ),
    );

    try {
      if (result.hasException &&
          (result.exception?.linkException?.originalException
              is SocketException)) {
        callbacks.onFail('Please check your Internet Connection');
      } else if (result.data != null) {
        callbacks.onSuccess(result.data!);
      } else {
        callbacks.onFail('Something went wrong');
      }
    } catch (e) {
      callbacks.onFail('Something went wrong');
    }
  }
}

class GraphQlCallbacks {
  GraphQlCallbacks({required this.onSuccess, required this.onFail});

  final Function(Map<String, dynamic> response) onSuccess;
  final Function(String error) onFail;
}
