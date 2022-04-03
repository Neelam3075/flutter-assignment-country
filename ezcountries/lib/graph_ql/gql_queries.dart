const String queryAllCountries = r'''query Query {countries {
    name 
    capital 
    currency 
    code 
    emoji 
    languages {
      code
      name
    }}}''';

const String queryCountry = r'''query Query($code: ID!) {
  country(code: $code) {
    name 
    capital 
    currency 
    code 
    emoji
    languages {
      code
      name
    }
  }
} ''';
