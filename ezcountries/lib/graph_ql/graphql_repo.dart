import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlRepo {
  callGraphQl(GraphQlCallbacks callbacks,
      {required String query, Map<String, dynamic>? variable}) async {
    callbacks.onLoading(true);
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
      callbacks.onSuccess(result.data!);
    } catch (e) {
      callbacks.onFail('Something went wrong');
    }
    callbacks.onLoading(false);
  }
}

class GraphQlCallbacks {
  GraphQlCallbacks(
      {required this.onSuccess, required this.onFail, required this.onLoading});

  final Function(Map<String, dynamic> response) onSuccess;
  final Function(String error) onFail;
  final Function(bool loading) onLoading;
}
