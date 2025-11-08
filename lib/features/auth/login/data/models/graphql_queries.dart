class GraphQLQueries {
  // Singleton instance
  static final GraphQLQueries _instance = GraphQLQueries._internal();
  factory GraphQLQueries() => _instance;
  GraphQLQueries._internal();

  // 🔐 LOGIN MUTATION
  String get loginMutation => '''
    mutation GenerateCustomerToken(\$email: String!, \$password: String!) {
      generateCustomerToken(email: \$email, password: \$password) {
        token
      }
    }
  ''';

  // 👤 CUSTOMER QUERY
  String get customerQuery => '''
    query GetCustomer {
      customer {
        id
        firstname
        lastname
        email
        date_of_birth
        gender
        is_subscribed
        addresses {
          firstname
          lastname
          street
          city
          region {
            region_code
            region
          }
          postcode
          country_code
          telephone
        }
      }
    }
  ''';
}
