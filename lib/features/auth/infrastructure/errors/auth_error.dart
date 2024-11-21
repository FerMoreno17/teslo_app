class WrongCredentials implements Exception {}
class InvalidToken implements Exception {}
class ConectionTimeout implements Exception {}
class CustomError implements Exception {
  final String message;
  CustomError(this.message);
}
